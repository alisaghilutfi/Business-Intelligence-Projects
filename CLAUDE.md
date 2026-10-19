# Business-Intelligence-Projects

BI portfolio monorepo. Power BI Desktop / PBIP reports across Finance, Ecommerce, Supply Chain, Healthcare, Competitor Sales, plus Excel and SQL projects.

## Naming conventions

| Prefix | Artefact |
|---|---|
| `projects/<kebab-case>/` | Project metadata (CLAUDE.md, state.md, decisions.md) |
| `PowerBI_<Name>/` | PBIP files (Desktop save path — do not move) |

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

## MCP servers (Claude Code)

- `powerbi-modeling-mcp` — semantic model read/write (tables, measures, DAX, relationships)
- `filesystem` — read/write this repo

## Known gotchas

- PBIP files live at their Desktop save path (`PowerBI_<Name>/`); project metadata lives under `projects/<kebab-case>/`. Claude navigates between both.
- Do not commit `localSettings.json` or `unappliedChanges.json` — they are in `.gitignore`.
- `.pbix` files are binary and cannot be diffed. Convert to PBIP before any model/report work.

## Projects

| Slug | Folder | Format | Status |
|---|---|---|---|
| `finance-analysis` | `PowerBI_Finance_Analysis/` | PBIP ✓ | Registered |
| `competitor-sales` | `PowerBI_Competitor_Sales_Analysis/` | .pbix | Registered |
| `ecommerce-analysis` | `PowerBI_Ecommerce_Analysis/` | .pbix | Registered |
| `healthcare-analysis` | `PowerBI_Healthcare_Analysis/` | .pbix | Registered |
| `supply-chain` | `PowerBI_Supply_Chain_Analysis/` | .pbix | Registered |
| `excel-customer-churn` | `Excel_Customer_Churn_Analysis/` | .xlsx | Registered |
| `sql-nashville-housing` | `SQL_Nashville_Housing/` | .sql | Registered |
| `sql-segmentation-cohorts` | `SQL_Segmentation_Cohorts_Retention/` | .sql | Registered |
