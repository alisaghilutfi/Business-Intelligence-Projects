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

## Notes from original README

**Problem statement:** Prepare raw Nashville housing transaction data for downstream analytics through a full data cleaning and transformation workflow in SQL Server. Demonstrates real-world SQL techniques expected from data analysts.

**Architecture:** Single SQL script (`SQL_Nashville_Housing.sql`) operating on `PortfolioProject.dbo.NashvilleHousing` table in Microsoft SQL Server. All transformations applied in-place. T-SQL / SSMS 21 only.

**Key transformations performed:**
- Data quality assessment and NULL value handling
- Address standardisation — property and owner address parsing and normalisation
- Date format standardisation (`SaleDate` column)
- Self-join for address enrichment — populate NULL `PropertyAddress` values using `ParcelID` matches from other rows
- `SoldAsVacant` field normalisation — Y/N to Yes/No
- Deduplication using `ROW_NUMBER()` window function partitioned by key columns
- Unused column removal via `ALTER TABLE ... DROP COLUMN`

**Key skills demonstrated:** Self-joins for data enrichment; `ROW_NUMBER()` window functions; schema evolution with `ALTER TABLE`; string parsing (`SUBSTRING`, `CHARINDEX`, `PARSENAME`); date conversion; modular, readable SQL script structure.

**How to use:** Import the Nashville Housing dataset (CSV provided in `docs/data/`) into SQL Server as `PortfolioProject.dbo.NashvilleHousing`, then execute `SQL_Nashville_Housing.sql` sequentially.
