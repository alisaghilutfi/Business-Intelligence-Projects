---
description: Pre-commit validation checklist for a PBIP project. Checks for Desktop-managed TMDL files staged, BOM in staged PBIR JSON, and runs powerbi-report-author validate on the project Report folder.
argument-hint: <project-slug e.g. competitor-sales>
---

Run this validation checklist for project `$ARGUMENTS` before committing. Work through all three checks in order — do not stop on the first warning.

**Input handling.** If $ARGUMENTS is empty or `projects/$ARGUMENTS` does not exist:
- List folders under `projects/` (exclude `_template` and `_archive`).
- STOP. Ask which project to validate.

---

## Check 1 — Desktop-managed TMDL files staged

Run:
```
git diff --cached --name-only
```

If the output includes any file matching `*.Report/definition/database.tmdl` or `*.Report/definition/model.tmdl`:

> ⚠️ TMDL WARNING: Desktop-managed file(s) staged:
> <list files>
> These are owned by Power BI Desktop. Revert with:
>   git checkout -- "projects/$ARGUMENTS/*.Report/definition/database.tmdl"
>   git checkout -- "projects/$ARGUMENTS/*.Report/definition/model.tmdl"
> Do not commit these unless the change was intentional (e.g. a manual measure edit via the Bridge).

If none found: `✅ No Desktop-managed TMDL files staged.`

---

## Check 2 — BOM in staged PBIR JSON

Run:
```
git diff --cached --name-only
```

For each staged file matching `projects/$ARGUMENTS/*.Report/**/*.json`, check for a UTF-8 BOM (`\xef\xbb\xbf`) at the start of the file on disk using this Python one-liner per file:

```
python -c "
import sys, pathlib
f = pathlib.Path(sys.argv[1])
print('BOM' if f.read_bytes().startswith(b'\xef\xbb\xbf') else 'OK')
" <filepath>
```

If any file has a BOM:

> ⚠️ BOM WARNING: <N> staged PBIR JSON file(s) have a UTF-8 BOM:
> <list files>
> Strip with the BOM-fix script in HARNESS.md before committing.

If none found: `✅ No BOM detected in staged PBIR JSON files.`

---

## Check 3 — powerbi-report-author validate

Check whether the tool is available:
```
powerbi-report-author --version
```

If available, run:
```
powerbi-report-author validate --report "projects/$ARGUMENTS"
```

Report the full output.

If not available:
> ℹ️ powerbi-report-author not available in this environment — skipping validation.

---

## Summary

After all three checks, print one of:
- `✅ All checks passed — safe to commit.`
- `⚠️ N warning(s) — review before committing.` (list which checks fired)

Do not commit. This command is read-only.
