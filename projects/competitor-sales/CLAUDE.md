# Competitive Sales Intelligence

## Goal

Identify where Sintec is winning and losing across markets and product segments versus 13 competitors, to inform regional and category investment decisions.

## Metrics / KPIs

- Sintec Revenue (`CALCULATE(SUM(fact_Sales[Revenue]), dim_Manufacturer[ManufacturerID] = 4)`)
- Sintec Market Share (`DIVIDE([Sintec Revenue], SUM(fact_Sales[Revenue]), 0)`)
- PY Sales (`CALCULATE(SUM(fact_Sales[Revenue]), SAMEPERIODLASTYEAR('dim_Date'[Date]))`)
- % Growth (`DIVIDE(SUM(fact_Sales[Revenue]) - [PY Sales], [PY Sales])`)
- Revenue by country, segment, manufacturer, and year

## Grain

One row per sales transaction (`fact_Sales`). Grain: ProductID × Date × Zip × Country.

## Data sources

- `fact_Sales` (CSV) — ~1.8M rows: ProductID, Date, Zip, Units, Revenue, Country (2017–2021)
- `dim_Product` (XLSX) — 2,412 rows: ProductID, name, Segment, Category, ManufacturerID, Price
- `dim_Manufacturer` (XLSX) — 14 rows: ManufacturerID, name, Logo URL
- `dim_Geography` (XLSX) — 176,931 rows: Zip, City, State, Region, District, Country
- `dim_Date` — generated date dimension (2017–2021); marked as official date table

## Stakeholders

Sales leadership and marketing strategists.

## Constraints

- Snowflake schema: fact_Sales → dim_Product → dim_Manufacturer (two-hop join)
- dim_Geography joined via `ZipCountry` composite key (Zip reuse across countries)
- A portion of US Zip codes in fact_Sales are absent from dim_Geography — those rows excluded from region/district breakdowns
- Dataset ends 2021 — momentum conclusions are fragile without 2022+ data
