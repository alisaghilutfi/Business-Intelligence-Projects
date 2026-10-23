# Project State — finance-analysis

**Status:** active — PBIP present

## Blockers
- Broken visual field references — X-axis and other fields reference `(Calendar) Month Name` which no longer exists; date table was renamed from `Calendar` to `dim_Date` during Oct 2026 hygiene pass but PBIR visual JSON `"Entity"` and `"queryRef"` references were not updated. Fix: find-and-replace `Calendar` → `dim_Date` across all `.Report/**/*.json` files, then BOM-strip pass.

## In Progress
- Nothing active

## Completed
- Full model hygiene pass (2026-10-19)
- PBIP consolidated into project folder (2026-10-23)
