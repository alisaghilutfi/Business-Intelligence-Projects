# Implementation Plan — Business-Intelligence-Projects

Tracks cross-repo wave deliverables. Repo-local items only; dev-environment items tracked in that repo's PROJECTS.md.

---

## Wave 3 — PBIP Git Hooks

| ID | Item | Status | Commit / PR |
|---|---|---|---|
| B5 | Deploy PBIP pre-commit hook to dev-environment | Complete | `9ffe10a` (dev-environment main) |
| E2 | Deploy PBIP pre-commit hook to Business-Intelligence-Projects | Complete | PR #9 → `d33d9a1` (chore/wave3-pbip-hook → main) |

Wave 3 complete: 2026-11-10.

Hook guards: blocks `database.tmdl`/`model.tmdl`, blocks `localSettings.json`/`unappliedChanges.json`, warns on BOM in Report JSON, blocks secrets (SP client secrets, SAS tokens, bearer tokens, plaintext passwords).

---

*Last updated: 2026-11-10*
