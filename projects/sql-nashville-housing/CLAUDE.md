# Nashville Housing Data Cleaning & Transformation

## Goal

Prepare raw Nashville housing transaction data for downstream analytics through a full data cleaning and transformation workflow in SQL Server.

## Metrics / KPIs

<!-- TBD — this is a data preparation project, not a reporting project; output is a cleaned table, not KPIs -->

## Grain

One row per property sale transaction (`PortfolioProject.dbo.NashvilleHousing`).

## Data sources

- `NashvilleHousing` table in `PortfolioProject` database (Microsoft SQL Server) — property sales in Nashville: addresses, sale dates, ownership details, transaction metadata

## Stakeholders

<!-- TBD -->

## Constraints

- T-SQL / SQL Server (SSMS 21) only — not portable to other dialects without modification
- All transformations are performed in-place on the source table (schema modification via `ALTER TABLE`)
- No raw data file included in repo — dataset must be imported into SQL Server before running scripts
