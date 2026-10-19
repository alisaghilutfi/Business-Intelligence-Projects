# Financial Transactions Dashboard

## Goal

Answer how transaction volumes, fees, and taxes trend across segments and geographies at the macro level, and where operational exceptions (failed transactions, anomalous fee patterns) warrant investigation.

## Metrics / KPIs

- Total Amount (`SUM(Transactions[Amount])`)
- Total Fees
- Total Tax
- Total Transactions
- PY Amount (`CALCULATE([Total Amount], SAMEPERIODLASTYEAR('Calendar'[Date]))`)
- YOY Amount and YOY% Amount
- Dynamic metric switcher via `_Metrics` field parameter

## Grain

One row per financial transaction (Transaction ID).

## Data sources

- `Transactions` — Transaction ID, amount, fees, tax, status, segment, state, transaction type, gender, date (FinSight fictitious dataset)
- `Calendar` — generated date dimension for time intelligence

## Stakeholders

FinSight finance leadership (C-suite) and operations team.

## Constraints

- Negative transaction amounts converted to absolute values — reversals cannot be distinguished without a transaction-type filter
- Decimal precision fixed to two places
- Calendar table is generated; gaps in transaction dates will silently affect YoY measures
