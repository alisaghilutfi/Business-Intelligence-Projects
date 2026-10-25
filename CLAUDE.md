# Business-Intelligence-Projects

Global guardrails: ~/.claude/CLAUDE.md (source: private repo dev-environment).

BI portfolio monorepo. Power BI Desktop / PBIP reports across Finance, Ecommerce, Supply Chain, Healthcare, Competitor Sales, plus Excel and SQL projects.

## Naming conventions

| Prefix | Artefact |
|---|---|
| `projects/<kebab-case>/` | Project folder — metadata (CLAUDE.md, state.md, decisions.md) and PBIP files (Desktop save path) co-located |

## Git

- Branching: short-lived branches (`feat/<slug>-<topic>`, `docs/…`, `chore/…`) → PR → `main`. No dev/test chain (no Fabric workspace sync). Never push directly to `main`.

## Workflow

1. Before starting any project: read `projects/<name>/CLAUDE.md` and `state.md`
2. Run `model-reviewer` agent before any semantic model changes
3. After any session: update `projects/<name>/state.md` with current status and blockers
4. Log design decisions in `projects/<name>/decisions.md` with date

## Design system

Use the Lotusoftware design system skill at `.claude/skills/lotusoftware-dashboard-design/`.
Always load it before creating or editing any report page or visual.
Palette: `#197278` (teal primary), max 4 intentional colours.
Layout: powerbi.tips Layout Trifecta — left nav 200px, top header 56px, content zone.

## DAX standards

- `VAR`/`RETURN` throughout — no single-expression measures over 2 tokens
- Copilot description on every measure
- Display folders: group by business domain
- Hide all raw/foreign-key columns from report view
- `_Measures` calculated table pattern for measure organisation

## Project kickoff

Before starting any new project or major feature, work through the Analyst Mindset
Kickoff Checklist in `_template/CLAUDE.md`. It is pre-loaded into every project
scaffold created by `/new-project`.

Key discipline: answer "What decision does this analysis support?" in one sentence
before touching data, writing DAX, or building any visual.

Full framework: `Analyst-Mindset-Framework.docx` in the repo root.

## MCP servers (Claude Code)

- `plugin:powerbi-authoring:powerbi-modeling-mcp` (local) — connects to the open Power BI Desktop instance; the write path for semantic model changes.
- The remote `plugin:fabric-skills` powerbi server is read-only and only for Fabric workspace models — not used in this repo.
- After MCP writes, save in Power BI Desktop (Ctrl+S) before reviewing git diff (the drift hook reminds you).

## Known gotchas

- PBIP files and project metadata are co-located under `projects/<slug>/` — there is no separate `PowerBI_<Name>/` root.
- Do not commit `localSettings.json` or `unappliedChanges.json` — they are in `.gitignore`.
- `.pbix` files are binary and cannot be diffed. Convert to PBIP before any model/report work.

## Projects

| Slug | Folder | Format | Status |
|---|---|---|---|
| `finance-analysis` | `projects/finance-analysis/` | PBIP ✓ | Registered |
| `competitor-sales` | `projects/competitor-sales/` | PBIP ✓ | Registered |
| `ecommerce-analysis` | `projects/ecommerce-analysis/` | PBIP ✓ | Registered |
| `healthcare-analysis` | `projects/healthcare-analysis/` | PBIP ✓ | Registered |
| `supply-chain` | `projects/supply-chain/` | PBIP ✓ | Registered |
| `excel-customer-churn` | `projects/excel-customer-churn/` | .xlsx | Registered |
| `sql-nashville-housing` | `projects/sql-nashville-housing/` | .sql | Registered |
| `sql-segmentation-cohorts` | `projects/sql-segmentation-cohorts/` | .sql | Registered |
