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

## Notes from original README

**Problem statement:** Answer how customers segment by lifetime value, how cohorts perform in revenue at acquisition time, and how many customers remain active vs. churned across cohorts. End-to-end SQL analysis on a star-schema transactional database using DBeaver.

**Architecture:** Five SQL scripts + one view definition, operating on a star-schema database via DBeaver. Gold-layer analytical view (`cohort_analysis`) as the transformation layer — aggregates transactions to customer–date grain, derives first purchase date, assigns cohort year, cleans customer names.

**Script structure:**
- `VIEW_Cohort_Analysis.sql` — defines the `cohort_analysis` Gold-layer view; run first
- `Q1_Customer_Segmentation.sql` — LTV-based segmentation using 25th/75th percentile breakpoints → Low / Mid / High Value segments
- `Q2_Cohort_Analysis.sql` — Part A: cohort revenue performance (customers and revenue by cohort year); Part B: spending behavior comparison (average revenue per spending customer vs. all customers including zero-spend via LEFT JOIN)
- `Q3_Customer_Retention.sql` — active vs. churned classification (active = purchased within last 6 months); retention % by cohort year using window functions
- `Optimized_Queries.sql` — consolidated optimised versions of Q1–Q3

**Key design decisions:**
- Gold-layer view pattern — avoids duplicating business logic across queries; mimics modern data platform architecture.
- Percentile-based segmentation (25th/75th) — industry-standard approach; avoids arbitrary hard-coded thresholds.
- LEFT JOIN in Q2 Part B — deliberately includes zero-spend customers in the denominator to surface the inactive customer population; average revenue per spending customer is more than double the all-customer average.
- Window functions (`ROW_NUMBER`, `MAX`) for retention logic — identifies each customer's most recent purchase without subquery nesting.

**Key findings:**
- High-value customers represent a smaller segment but contribute the majority of lifetime revenue.
- Average revenue per spending customer is more than double the overall customer average — large inactive customer base.
- Customer churn remains consistently high across cohorts; only ~9–10% of customers remain active after 6 months.

**How to use:** Connect DBeaver to the star-schema database, run `VIEW_Cohort_Analysis.sql` first to create the analytical view, then run Q1–Q3 in sequence (or use `Optimized_Queries.sql` for the consolidated version).
