# PowerBI_Competitor_Sales_Analysis — Competitive Sales Intelligence

**Type:** Business Intelligence · Competitive Analysis  
**Stack:** Power BI Desktop · Power Query · Snowflake schema · DAX · AI visuals (Decomposition Tree, Key Influencers, Smart Narrative)  
**Data:** ~1.8M sales transactions · 6 countries · 14 manufacturers · 2014–2021

---

## Business Problem

Sales leadership needs to know where Sintec is winning, where it is losing, and which markets and product segments represent the clearest growth opportunity — before committing to a regional or category investment decision.

---

## Analytical Question

**Outcome variable:** Sintec revenue and market share  
**Drivers under investigation:** geography (country, region), product segment, manufacturer, and time  
**Question type:** Comparison (Sintec vs. 13 competitors) with a Relationship layer (which geography and segment combinations drive share gains)

The analysis does not attempt to predict future share — it establishes the factual baseline a strategist would need before modelling forward scenarios.

---

## Data

| Source | Description | Rows |
|--------|-------------|------|
| `Sales` (CSV) | Transactions: ProductID, Date, Zip, Units, Revenue, Country | ~1.8M |
| `Product` (XLSX) | ProductID, Product name, Segment, Category, ManufacturerID, Price | 2,412 |
| `Manufacturer` (XLSX) | ManufacturerID, Manufacturer name, Logo URL | 14 |
| `Geography` (XLSX) | Zip, City, State, Region, District, Country | 176,931 |
| `Date` | Generated via DAX | — |

**Schema:** Snowflake — Sales as central fact table, joined to Product (via ProductID), then Product to Manufacturer (via ManufacturerID). Geography joined via a `ZipCountry` composite key to handle Zip reuse across countries.

**Known limitation:** A portion of US Zip codes in Sales are absent from the Geography dimension — these rows are included in revenue totals but cannot be attributed to a specific US region or district.

[![Data Model](https://github.com/alisaghilutfi/Business-Intelligence-Projects/raw/main/PowerBI_Competitor_Sales_Analysis/images/data-model.PNG)](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Competitor_Sales_Analysis/images/data-model.PNG)

---

## Approach

The report is structured around one central comparison: Sintec against each of its 13 competitors, sliced by the dimensions that a sales or marketing strategist would actually act on — country, product segment, and year.

The **Competitor Sales Analysis** page answers the baseline questions: who leads where, and has that changed over time. Revenue by country and manufacturer, year-over-year growth rates, and market share by region give the factual picture without interpretation.

The **Advanced Insights** page goes one layer deeper using Power BI AI visuals. The Decomposition Tree lets a user drill into any revenue figure and decompose it by any combination of dimensions — this replaces the need to build a separate pivot analysis for every hypothesis. The Key Influencers visual identifies which variables statistically associate with high or low Sintec revenue, surfacing patterns that a static chart would obscure.

Key measures:

```dax
PY Sales = CALCULATE(SUM(Sales[Revenue]), SAMEPERIODLASTYEAR('Date'[Date]))
% Growth = DIVIDE(SUM(Sales[Revenue]) - [PY Sales], [PY Sales])
Sintec Revenue = CALCULATE(SUM(Sales[Revenue]), Manufacturer[ManufacturerID] = 4)
Sintec Market Share = DIVIDE([Sintec Revenue], SUM(Sales[Revenue]), 0)
ZipCountry = Sales[Zip] & "," & Sales[Country]
```

---

## Key Findings

- **Sintec leads the US market** with 38.22% share — well ahead of the next competitor. This is the position worth defending; any US-targeted campaign has an outsized effect on the overall number.
- **Sintec's global share is 21.15%** — the gap between US and global share indicates significant untapped potential in the other five markets, or a structural disadvantage outside the US.
- **Artisans dominates Germany** with over 50% share. Germany is not a near-term Sintec expansion candidate without a differentiated product or pricing play.
- **2021 showed 18.8% YoY revenue growth** — the strongest year in the dataset. Whether this is a trend or a post-period anomaly requires the next year's data to confirm.
- **Segment and geography interact**: the Decomposition Tree reveals that the same product segment performs differently by country, meaning a single global segment strategy would be blunt — regional targeting is warranted.

---

## Limitations & Caveats

- **No unit economics:** Revenue is the only financial metric. Without margin data, a high-revenue segment could be low-profit — the report cannot distinguish between these.
- **Zip code coverage gap:** US rows with unmatched Zips are included in national revenue totals but excluded from region/district-level breakdowns. The magnitude of this gap should be quantified before any region-level investment decision is made.
- **Static snapshot:** The dataset ends in 2021. The 18.8% growth finding cannot be extrapolated without 2022+ data. Momentum conclusions are fragile.
- **Correlation is not causation:** The Key Influencers visual identifies associations, not drivers. A variable that correlates with high Sintec revenue may be a proxy for an unmeasured factor.

---

## Screenshots

[![Competitor Sales Analysis](https://github.com/alisaghilutfi/Business-Intelligence-Projects/raw/main/PowerBI_Competitor_Sales_Analysis/images/dashboard_01_Competitor-Sales-Analysis.PNG)](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Competitor_Sales_Analysis/images/dashboard_01_Competitor-Sales-Analysis.PNG)

[![Advanced Insights](https://github.com/alisaghilutfi/Business-Intelligence-Projects/raw/main/PowerBI_Competitor_Sales_Analysis/images/dashboard_02_Advanced-Insights.PNG)](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Competitor_Sales_Analysis/images/dashboard_02_Advanced-Insights.PNG)

---

## Skills Demonstrated

- Power BI Desktop — multi-page report design with drill-through and dynamic navigation
- Power Query — multi-source ETL (CSV + XLSX), composite key construction, Geography metadata row handling
- DAX — time intelligence (SAMEPERIODLASTYEAR), market share calculation, composite key column
- Data modeling — snowflake schema, two-hop join path (Sales → Product → Manufacturer)
- AI visuals — Decomposition Tree, Key Influencers, Smart Narrative

---

## Probable Next Improvements

- **Extend to 2022–2024 data** — the 18.8% growth finding in 2021 is the most actionable number in the report, but it cannot be interpreted without knowing whether growth continued, slowed, or reversed post-2021. One additional year of data would confirm whether this is a trend or a peak.
- **Add a margin layer to the revenue analysis** — Sintec's 38.22% US market share is compelling, but share of revenue is not share of profit. If Sintec's US dominance is built on a low-price strategy, the strategic picture changes substantially. A gross margin column per product would reframe the "where to invest" question.
- **Build a Fabric version with live refresh** — the current model is a static .pbix. Migrating to Microsoft Fabric with a medallion lakehouse and a DirectLake semantic model would enable weekly data refreshes and a Fabric Data Agent for natural language querying — both already implemented in the [Fabric-Analytics-Projects](https://github.com/alisaghilutfi/Fabric-Analytics-Projects) companion repo.
