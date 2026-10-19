# E-Commerce Performance & Cost Optimisation

## Goal

Identify where shipping costs can be reduced without hurting revenue, and which product combinations most reliably drive cross-sell and upsell conversions, to improve net profitability for Whiskique.

## Metrics / KPIs

- Total Sales ($1.55M baseline)
- Profit Margin % (27.50% baseline)
- Shipping (Baseline) — tiered shipping cost model
- Shipping (What-if) — dynamic cost under blended shipping cost factor parameter
- Shipping (Difference) — cost reduction from consolidation
- Profit (Baseline)
- Customer LTV (`Total Sales / Number of Customers`)
- Product correlation coefficients for market basket analysis

## Grain

One row per line item sold (`fact_Sales`). Grain: Stock Code × Invoice No × Transaction Date.

## Data sources

- `fact_Sales` — ~500K rows: product, quantity, sales, COGS, shipping cost, customer, invoice (Dec 2020–Dec 2021)
- `dim_Product` — Stock code, description, category, weight, landed cost, shipping cost per 1K miles
- `dim_Customer` — Customer ID, order city, state, postal code, lat/lon
- `dim_State_Mapping` — State-to-region lookup; M:M with dim_Customer on Order State (intentional BothDirections)
- `fact_Invoice_Totals` — Invoice-level totals (Invoice No, total quantity, total sales)
- `fact_Market_Baskets` — Calculated duplicate of fact_Sales for basket analysis; M:M with fact_Sales on Invoice No (intentional BothDirections)
- `dim_Date` — Generated date dimension (2020-01-01 to 2021-12-31); marked as official date table

## Stakeholders

Operations team (shipping optimisation) and marketing team (cross-sell/upsell).

## Constraints

- Fictitious dataset (Whiskique pet supply) — findings are illustrative, not empirically validated
- LTV is a simple average; does not account for purchase frequency or tenure
- Shipping model assumes uniform discount structure (not real carrier tiers)
- Correlation ≠ causation: cross-sell affinity requires A/B test to confirm incremental revenue effect
