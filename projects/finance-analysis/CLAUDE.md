# Financial Transactions Dashboard

## Goal

Answer how transaction volumes, fees, and taxes trend across segments and geographies at the macro level, and where operational exceptions (failed transactions, anomalous fee patterns) warrant investigation.

## Metrics / KPIs

- Total Amount (`SUM(fact_Transactions[Amount])`)
- Total Fees
- Total Tax
- Total Transactions
- PY Amount (`CALCULATE([Total Amount], SAMEPERIODLASTYEAR('dim_Date'[Date]))`)
- YOY Amount and YOY% Amount
- Dynamic metric switcher via `_Metrics` field parameter

## Grain

One row per financial transaction (`fact_Transactions`).

## Data sources

- `fact_Transactions` — Transaction ID, amount, fees, tax, status, segment, state, transaction type, gender, date (FinSight fictitious dataset)
- `dim_Customer` — Customer ID, gender, date of birth, city, state, occupation, customer segment, join date
- `dim_Date` — generated date dimension (2023–2026) for time intelligence; marked as official date table

## Stakeholders

FinSight finance leadership (C-suite) and operations team.

## Constraints

- Negative transaction amounts converted to absolute values — reversals cannot be distinguished without a transaction-type filter
- Decimal precision fixed to two places
- `dim_Date` is generated (2023–2026); transactions outside this range produce blank PY and YOY measures

## Notes from original README

**Problem statement:** FinSight's finance leadership needs a single view that answers two questions at different levels of detail — macro trend across segments and geographies (C-suite) and specific operational exceptions (operations team) — without forcing either audience to navigate a report designed for the other.

**Architecture:** Star schema. `fact_Transactions` as central fact joined to `dim_Customer` and `dim_Date`. FinSight fictitious dataset — multi-segment, multi-region.

**Key design decisions:**
- Field parameter (`_Metrics`) drives a metric switcher on the Executive Summary page — four KPI views (Amount, Fees, Tax, Transactions) served from one page without four separate pages. Dynamic chart title reflects the active metric.
- F-pattern layout — KPI cards and metric switcher in top-left zone where executive attention lands first; supporting detail below and to the right.
- Drill-through from Executive Summary to Transaction Details — context filter preserved on landing; dynamic header (`Transaction Details: Retail`) confirms the active filter.
- Monthly State Tooltip — hover on monthly trend line to surface top states by active customer density for that month without navigating away.
- Conditional formatting on failed transactions — warning-red tint makes exceptions scannable in a dense table without pre-filtering.
- Negative amounts converted to absolute values — documented ETL trade-off: prevents offsetting totals but removes reversal signal; distinguish reversals via transaction-type filter.

**Key findings:**
- Field parameter switching materially reduces page count — design pattern worth replicating on any dashboard with multiple KPIs sharing the same dimensional structure.
- Conditional formatting on failed transactions makes exception management practical at scale.
- Drill-through with dynamic titles eliminates the "what slice am I looking at?" problem in dense reports.

**Probable next improvements:** Anomaly detection measure for fees (rolling-average DAX vs. threshold); customer-level drill-through page; extend field parameter to include YoY% metrics.
