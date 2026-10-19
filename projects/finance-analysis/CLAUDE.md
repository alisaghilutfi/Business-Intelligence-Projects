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
