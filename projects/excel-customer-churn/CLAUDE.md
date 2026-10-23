# Telecom Customer Retention Insights

## Goal

Uncover actionable insights on customer retention opportunities for Databel by identifying which customers are most at risk of churn and what factors drive attrition.

## Metrics / KPIs

- Total Customers: 6,687
- Churned Customers: 1,796
- Churn Rate: 26.86%
- Churn breakdown by reason category (Competitor leading at 45%)
- Churn rate by demographic (age group, gender)
- Churn rate by contract type (Month-to-Month, One Year, Two Year)
- Churn rate by service plan (unlimited data, international plan)
- Churn rate by tenure (account length groupings)
- Geographic churn rate variations by state

## Grain

One row per customer account.

## Data sources

- `Databel - Customer` (CSV) — 6,687 rows, 29 columns: churn label, churn reason, age, contract type, data plan, international plan, account length, monthly charges
- `Databel - Aggregate` — 21 columns: grouped analysis views

## Stakeholders

Customer success managers, marketing teams, and business executives.

## Constraints

- Excel-based analysis (not a Power BI report)
- Fictitious telecom company (Databel) — findings are illustrative
- Analysis is descriptive; predictive churn modelling would require a separate ML layer

## Notes from original README

**Problem statement:** Uncover actionable insights on customer retention opportunities for Databel by identifying which customers are most at risk of churn and what factors drive attrition. Target audience: customer success managers, marketing teams, and business executives.

**Architecture:** Excel-only analysis (no Power BI). Two source datasets connected in Excel: `Databel - Customer` (6,687 rows, 29 columns — customer-level) and `Databel - Aggregate` (21 columns — grouped analysis views). Analysis structured across three stages.

**Key design decisions:**
- Three-stage workbook structure: (1) Exploratory Analysis — data prep, duplicate detection, baseline churn metrics, competitive analysis; (2) Churn Pattern Investigation — demographics, service plan impact, contract/tenure correlation, geographic variations; (3) Executive Dashboard — KPI summary, churn reason breakdown, demographic insights.
- `IF()` formula for Churned Binary column — enables PivotTable aggregation of churn counts.
- Nested `IF()` for age grouping and tenure-based segmentation — industry-standard demographic bucketing approach.
- PivotTables with calculated fields for churn rate — avoids hard-coded numbers; recalculates on data refresh.

**Key findings:**
- Churn rate: 26.86% (1,796 of 6,687 customers); Competitor activity drives 45% of all departures.
- Senior citizens (65+) show significantly higher churn rates than other age groups.
- Month-to-month contracts correlate with highest churn risk; two-year contracts correlate with highest retention.
- Customers on unlimited data plans exhibit higher churn tendency — counterintuitive; warrants further investigation.
- Churn decreases significantly after the first year — acquisition-period retention is the primary intervention window.
- Geographic variation exists at state level, especially among customers with international plans.

**Probable next improvements:** Predictive churn model (ML layer); customer lifetime value calculation; A/B test framework for retention interventions.
