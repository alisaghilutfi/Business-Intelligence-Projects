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
