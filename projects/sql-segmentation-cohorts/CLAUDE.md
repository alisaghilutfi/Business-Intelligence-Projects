# Customer Segmentation, Cohorts & Retention Analytics

## Goal

Answer how customers segment by lifetime value, how cohorts perform in revenue at acquisition time, and how many customers remain active versus churned across cohorts.

## Metrics / KPIs

- Customer LTV per segment (Low / Mid / High Value based on 25th and 75th percentiles)
- Total lifetime value, customer count, and average LTV per segment
- Total customers and revenue by cohort year
- Average revenue per spending customer vs. all customers (including zero-spend)
- Active vs. churned customer count per cohort year
- Retention percentage per cohort year (active = purchased within last 6 months)

## Grain

Customer–order date grain via `cohort_analysis` view (aggregated from transactional data).

## Data sources

- Star-schema transactional database (tool: DBeaver)
- `cohort_analysis` view — derived analytical layer: customer + date grain, net revenue, first purchase date, cohort year, cleaned customer names

## Stakeholders

<!-- TBD -->

## Constraints

- SQL-only project (no Power BI report)
- Churn definition: no purchase in last 6 months — only ~9–10% of customers remain active after 6 months
- Cohort year assigned at first purchase date; cohort grain is annual
- Analysis built on a Gold-layer view pattern — upstream table schema assumed stable
