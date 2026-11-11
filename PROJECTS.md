# Implementation Plan — Business-Intelligence-Projects

Tracks cross-repo wave deliverables. Repo-local items only; dev-environment items tracked in that repo's PROJECTS.md.

---

## Wave 3 — PBIP Git Hooks

| ID | Item | Status | Commit / PR |
|---|---|---|---|
| B5 | Deploy PBIP pre-commit hook to dev-environment | Complete | `9ffe10a` (dev-environment main) |
| E2 | Deploy PBIP pre-commit hook to Business-Intelligence-Projects | Complete | PR #9 → `d33d9a1` (chore/wave3-pbip-hook → main) |
| E2 fix | TMDL guard changed from block to warn; /validate aligned | Complete | PR #12 |

Wave 3 complete: 2026-11-10.

Hook guards: warns on modified `database.tmdl`/`model.tmdl` (added files pass), blocks `localSettings.json`/`unappliedChanges.json`, warns on BOM in Report JSON, blocks secrets (SP client secrets, SAS tokens, bearer tokens, plaintext passwords).

---

*Last updated: 2026-11-11*
