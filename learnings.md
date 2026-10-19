# Learnings

Hard-won lessons from this monorepo. Add a date and a root cause for each.

---

## 2026-10-19 — PowerShell `Set-Content` writes UTF-8 BOM; PBIR JSON files must be BOM-free

**What happened:** After using PowerShell `Set-Content -Encoding UTF8` to replace `"Entity"` field references in 20 PBIR `.json` files following a table rename, Desktop refused to load the report — all visuals were broken.

**Root cause:** PowerShell 5.1 `Set-Content -Encoding UTF8` (and `Out-File -Encoding UTF8`) silently prepends a UTF-8 BOM (`\xef\xbb\xbf`). PBIR JSON files must be BOM-free; any BOM causes Desktop to reject the file.

**Fix:** After any PBIR JSON edit via PowerShell (or any Windows tool that writes UTF-8-with-BOM), run a BOM strip pass using Python before committing:

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

**Rule going forward:** Never use PowerShell `Set-Content`/`Out-File` to write PBIR JSON files. Use Python (`pathlib.Path.write_text(..., encoding='utf-8')` — no BOM) or the dedicated Edit/Write tools which write UTF-8 without BOM.

---

## 2026-10-19 — PBIR JSON requires updates to BOTH `"Entity"` AND `"queryRef"` after table renames

**What happened:** After renaming tables via XMLA and updating all `"Entity"` field values in PBIR JSON, visuals still showed errors on reload in Desktop.

**Root cause:** PBIR visual JSON contains two separate table name references:
1. `"Entity"` — the table name inside `SourceRef` objects (updated correctly in the first pass)
2. `"queryRef"` — a dot-separated string of the form `"TableName.ColumnOrMeasureName"` used to bind query projection results back to visual fields (missed in the first pass)

Desktop resolves `queryRef` at render time. A stale prefix (e.g. `"hospital_discharges.facility_name"`) fails to match the renamed model object even when the corresponding `"Entity"` is correct, causing a visual data error.

**Fix:** After table renames, replace BOTH `"Entity"` values AND `"queryRef"` dot-prefixes across all PBIR JSON files. Example Python snippet (combine with BOM strip):

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

**Rule going forward:** Any PBIR fix script must replace BOTH `"Entity"` AND `"queryRef"` prefixes in a single pass. Search for old table name strings without anchoring to `"Entity":` to catch all occurrences.
