# Competitive Sales Intelligence

## Goal

Identify where Sintec is winning and losing across markets and product segments versus 13 competitors, to inform regional and category investment decisions.

## Metrics / KPIs

- Sintec Revenue (`CALCULATE(SUM(Sales[Revenue]), Manufacturer[ManufacturerID] = 4)`)
- Sintec Market Share (`DIVIDE([Sintec Revenue], SUM(Sales[Revenue]), 0)`)
- PY Sales (`CALCULATE(SUM(Sales[Revenue]), SAMEPERIODLASTYEAR('Date'[Date]))`)
- % Growth (`DIVIDE(SUM(Sales[Revenue]) - [PY Sales], [PY Sales])`)
- Revenue by country, segment, manufacturer, and year

## Grain

One row per sales transaction (ProductID × Date × Zip × Country).

## Data sources

- `Sales` (CSV) — ~1.8M rows: ProductID, Date, Zip, Units, Revenue, Country (2014–2021)
- `Product` (XLSX) — 2,412 rows: ProductID, name, Segment, Category, ManufacturerID, Price
- `Manufacturer` (XLSX) — 14 rows: ManufacturerID, name, Logo URL
- `Geography` (XLSX) — 176,931 rows: Zip, City, State, Region, District, Country
- `Date` — generated via DAX

## Stakeholders

Sales leadership and marketing strategists.

## Constraints

- Snowflake schema: Sales → Product → Manufacturer (two-hop join)
- Geography joined via `ZipCountry` composite key (Zip reuse across countries)
- A portion of US Zip codes in Sales are absent from Geography — those rows excluded from region/district breakdowns
- Dataset ends 2021 — momentum conclusions are fragile without 2022+ data
