# Power BI Desktop (PBIP) — Harness Reference

This document captures the workflow, tooling, and hard-won lessons for building Power BI reports with PBIP and the Desktop Bridge. Read it at the start of any session before making decisions about architecture or tooling.

---

## The Two-Harness System

```
ProjectPlanner (claude.ai)          FabricEngineer (Claude Code / Power BI Desktop)
─────────────────────────────       ──────────────────────────────────────────────
Report design consultation          PBIR edits, TMDL writes
DAX review                          Desktop Bridge operations
PBIR architecture                   Git add / commit / push
Session planning                    Execute approved plan
Never executes                      Never makes architectural decisions
                                    without ProjectPlanner input
```

**ProjectPlanner** is the design brain. It reads context files, reviews DAX, proposes PBIR architecture, and produces the session plan. It never writes files or executes commands.

**FabricEngineer** is the execution arm. It implements the approved plan — editing PBIR JSON, writing TMDL via the Desktop Bridge, managing Git. It does not make architectural decisions without prior ProjectPlanner input.

**Context files:** each project maintains its own `CLAUDE.md`, `state.md`, and `decisions.md` under `projects/<slug>/`. These are the ground truth for project status and design decisions.

**Desktop Bridge is the execution boundary.** Desktop renders what the Bridge writes. Any PBIR or TMDL change flows through the Bridge and is reflected on the next Desktop reload.

---

## Session Protocols

### Pre-session (ProjectPlanner)

```
1. Read HARNESS.md
2. Read projects/<slug>/state.md
3. State current status in one sentence
4. Confirm the next step before producing any plan
```

### Start-of-session (FabricEngineer)

```
1. Read HARNESS.md
2. Read projects/<slug>/CLAUDE.md
3. Read projects/<slug>/state.md
4. State current status in one sentence
5. Confirm the next step before executing anything
```

### End-of-session (FabricEngineer)

```
1. Update projects/<slug>/state.md
   - Current status
   - Blockers
   - Next step
2. git add + commit to feature branch
3. Open PR to main
```

---

## Git Branch Strategy

- Short-lived branches → PR → `main` (no dev/test chain)
- Branch naming: `<slug>/<description>` e.g. `competitor-sales/fix-geography-relationship`
- `protect-main` ruleset active: Restrict deletions, Block force pushes, Require PR (0 approvals, bypass: alisaghilutfi)
- Never push directly to `main`

---

## MCP & Plugins Configuration

| Plugin | Scope | Notes |
|---|---|---|
| `pbi-desktop@power-bi-agentic-development` | Project | Installed here; disabled in Fabric-Apps-Projects — enable here |
| `pbip@power-bi-agentic-development` | Project | Installed at project scope |
| `powerbi-modeling-mcp` | Both | Local .exe v1.0.0; read-only in ProjectPlanner; read-write via plugin in FabricEngineer |
| Desktop Bridge CLI | FabricEngineer | `@microsoft/powerbi-desktop-bridge-cli` — must open `.pbip` not `.pbix` |

---

## Report Design Workflow

### Phase 1: Open report via PBIP

Always open the `.pbip` file — never `.pbix` or `definition.pbir` directly.

```
File > Open > projects/<slug>/<Name>.pbip
```

### Phase 2: Verify Bridge connection

```bash
powerbi-desktop status
# reportDir must not be null
```

If `reportDir` is null, Desktop has a `.pbix` open or no file is open. Close and reopen the `.pbip`.

### Phase 3: Design brief first

Save brief to `projects/<slug>/docs/design-brief-<report>.md`. Wait for approval before implementing.

### Phase 4: Implement page by page

```
validate → reload → screenshot → adjust → next page
```

### Phase 5: Cleanup before commit

```bash
git checkout -- "*.Report/definition/database.tmdl"
git checkout -- "*.Report/definition/model.tmdl"
```

Desktop auto-modifies `database.tmdl` and `model.tmdl` on every save. Revert these before committing unless the change was intentional.

---

## PBIR Rules

**BOM rule — never use PowerShell `Set-Content`/`Out-File` for PBIR JSON**

PowerShell 5.1 `Set-Content -Encoding UTF8` and `Out-File -Encoding UTF8` silently prepend a UTF-8 BOM (`\xef\xbb\xbf`). PBIR JSON files must be BOM-free; any BOM causes Desktop to reject the file.

Use Python (`pathlib.Path.write_text(..., encoding='utf-8')` — no BOM) or the dedicated Edit/Write tools. After any PBIR JSON edit via PowerShell or any Windows tool that writes UTF-8-with-BOM, run a BOM strip pass before committing:

```python
import pathlib

report_dir = pathlib.Path(r"<path>\<Project>.Report")
fixed = []
for f in report_dir.rglob("*.json"):
    content = f.read_bytes()
    if content.startswith(b'\xef\xbb\xbf'):
        f.write_bytes(content[3:])
        fixed.append(f.name)
print(f"Fixed {len(fixed)} files:", fixed)
```

---

**Table rename rule — replace BOTH `"Entity"` AND `"queryRef"` after any table rename**

PBIR visual JSON contains two separate table name references:
1. `"Entity"` — the table name inside `SourceRef` objects
2. `"queryRef"` — a dot-separated string of the form `"TableName.ColumnOrMeasureName"` used to bind query projection results back to visual fields

Desktop resolves `queryRef` at render time. A stale prefix (e.g. `"hospital_discharges.facility_name"`) fails to match the renamed model object even when the corresponding `"Entity"` is correct, causing a visual data error.

Any PBIR fix script must replace BOTH `"Entity"` AND `"queryRef"` prefixes in a single pass. Search for old table name strings without anchoring to `"Entity":` to catch all occurrences. Example Python snippet (combine with BOM strip):

```python
replacements = {
    '"hospital_discharges.': '"fact_Hospital_Discharges.',
    '"surgical_program_size_summary.': '"dim_Surgical_Program.',
}
for f in report_dir.rglob("*.json"):
    content = f.read_bytes().lstrip(b'\xef\xbb\xbf').decode('utf-8')
    for old, new in replacements.items():
        content = content.replace(old, new)
    f.write_bytes(content.encode('utf-8'))
```

---

## Known Gotchas

| Trigger | Consequence — what to do instead |
|---|---|
| `diagramLayout.json` edited manually | Desktop regenerates and overwrites it on next save — never hand-edit |
| `DateTableTemplate_*` or `LocalDateTable_*` TMDL edited | Desktop-managed auto date tables; edits are silently overwritten |
| `.pbix` open in Desktop -> Bridge `reportDir: null` | Must open `.pbip` file, not `.pbix` or `definition.pbir` |

---

## Naming Conventions

- **Monorepo structure:** `projects/<slug>/` contains `CLAUDE.md` + `state.md` + `decisions.md` + `docs/` + PBIP files
- **Table and column names:** Title Case — no `gold_` prefix, no `snake_case`
- **Report prefix:** `rpt_`; **semantic model prefix:** `sm_` (consistent with Fabric-Analytics-Projects)
- **Project slugs:** lowercase-hyphenated e.g. `competitor-sales`, `supply-chain`

---

*Last updated: 2026-10-28*
