---
description: Scaffold a new PBIP project. Runs the Analyst Mindset kickoff checklist before creating any files.
argument-hint: <project-slug e.g. competitor-sales>
---

## Step 0 — Analyst Mindset kickoff checklist

Before creating any files, work through this checklist with the user. Ask each question and wait for a confirmed answer before moving to the next. Do not proceed to Step 1 until all four are confirmed.

1. **Business question:** What is the specific business question this report answers? (One sentence.)
2. **Stakeholder and decision:** Who is the primary stakeholder, and what decision will this report inform?
3. **Data source:** Does the data source exist and is it accessible from this environment? Name it.
4. **Fact grain:** What is the grain of the fact table — one row represents what?

If the user cannot answer any of these, STOP and say:
> "This project is not ready to scaffold. Resolve the open question above before proceeding."

Only after all four are confirmed, proceed to Step 1.

---

## Step 1 — Scaffold

1. Create `projects/$ARGUMENTS/CLAUDE.md` from `_template/CLAUDE.md`
2. Create `projects/$ARGUMENTS/state.md` from `_template/state.md`
3. Create `projects/$ARGUMENTS/decisions.md` from `_template/decisions.md`
4. Create `projects/$ARGUMENTS/docs/validations/` (empty, add .gitkeep)
5. Add the project to the projects table in root `CLAUDE.md`
