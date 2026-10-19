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
