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

## Notes from original README

**Problem statement:** Sales leadership needs to know where Sintec is winning, where it is losing, and which markets and product segments represent the clearest growth opportunity — before committing to a regional or category investment decision.

**Architecture:** Snowflake schema. `fact_Sales` as central fact → `dim_Product` (via ProductID) → `dim_Manufacturer` (via ManufacturerID). `dim_Geography` joined via `ZipCountry` composite key to handle Zip reuse across countries. ~1.8M rows, 6 countries, 14 manufacturers, 2014–2021.

**Key design decisions:**
- ZipCountry composite key (`Sales[Zip] & "," & Sales[Country]`) — necessary because Zip codes repeat across countries; a plain Zip join would produce incorrect geographic attributions.
- AI visuals (Decomposition Tree, Key Influencers) on Advanced Insights page — replaces the need to build a separate pivot analysis for every hypothesis; Key Influencers surfaces statistical associations that static charts would obscure.
- Two-page structure: Competitor Sales Analysis (baseline comparison) + Advanced Insights (AI-driven decomposition).

**Key findings:**
- Sintec leads US market with 38.22% share; global share is 21.15% — gap indicates untapped potential in 5 other markets.
- Artisans dominates Germany with >50% share — not a near-term Sintec expansion candidate without a differentiated play.
- 2021 showed 18.8% YoY revenue growth — strongest year in dataset, fragile without 2022+ data to confirm trend vs. peak.
- Segment × geography interaction: same product segment performs differently by country — a single global segment strategy is blunt.

**Probable next improvements:** Extend to 2022–2024 data; add margin layer (revenue share ≠ profit share); build Fabric version with DirectLake and live refresh.
