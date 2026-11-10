---
description: Scaffold a new PBIP project. Runs the Analyst Mindset kickoff checklist before creating any files.
argument-hint: <project-slug e.g. competitor-sales>
---

## Step 0 — Kickoff

Before creating any files:

1. Load the analyst-mindset skill and run its kickoff (five framing questions). Wait for
   the user to confirm the Problem framing block.
2. Then confirm two scaffold questions, one at a time:
   - **Data source:** Does the data source exist and is it accessible from this
     environment? Name it.
   - **Fact grain:** What is the grain of the fact table? One row represents what?

If the user cannot answer a question and does not waive it, STOP and say:
> "This project is not ready to scaffold. Resolve the open question above before proceeding."

Only after all of this is confirmed, proceed to Step 1.

---

## Step 1 — Scaffold

1. Create `projects/$ARGUMENTS/CLAUDE.md` from `_template/CLAUDE.md`
2. Create `projects/$ARGUMENTS/state.md` from `_template/state.md`
3. Create `projects/$ARGUMENTS/decisions.md` from `_template/decisions.md`
4. Create `projects/$ARGUMENTS/docs/validations/` (empty, add .gitkeep)
5. Add the project to the projects table in root `CLAUDE.md`
6. Write the confirmed Problem framing block, the data source and the fact grain into
   `projects/$ARGUMENTS/CLAUDE.md`, in its kickoff checklist section.
