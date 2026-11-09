---
description: Read-only session-start report for one PBIP project — current status, blockers, and next step. Does not execute anything until you confirm.
argument-hint: <project-slug e.g. competitor-sales>
---

Project: `$ARGUMENTS`

READ-ONLY. Do not open Desktop, run powerbi-report-author, or any execution command. The only shell call allowed is the read-only git log call in step 4.

**Input handling.** If $ARGUMENTS is empty or `projects/$ARGUMENTS` does not exist:
- List folders under `projects/` (exclude `_template` and `_archive`).
- STOP. Ask which project to open.

1. Read `HARNESS.md` in full.
2. Read `projects/$ARGUMENTS/CLAUDE.md` in full.
3. Read `projects/$ARGUMENTS/state.md` in full.
4. Run this read-only git command:
   ```
   git log -1 --date=short --format="%ad %h %s" -- "projects/$ARGUMENTS/"
   ```
   If the last commit date is more than 7 days before today, print:
   `NOTE: Last commit to this project was <date> — state.md may be stale.`
5. Report status in 3–5 bullets covering: current report/model state, what is in progress, what is blocked, what Desktop phase the project is in (design brief / implementation / validation).
6. State the next step from `state.md`. If `state.md` has no next step section, say so.
7. Offer: "Run project-state-reviewer for a full staleness check? (yes/no)"

STOP after the report. Do not execute any step until the user confirms which step to take.
