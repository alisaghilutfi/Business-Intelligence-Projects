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

One row per sales transaction (product × customer × order).

## Data sources

- `Sales` (fact) — Transactions: product, quantity, sales, COGS, shipping cost, customer, state
- `Product` — Product name, category, description
- `Customer` — Customer ID and attributes
- `State Mapping` — State-to-region mapping

## Stakeholders

Operations team (shipping optimisation) and marketing team (cross-sell/upsell).

## Constraints

- Fictitious dataset (Whiskique pet supply) — findings are illustrative, not empirically validated
- LTV is a simple average; does not account for purchase frequency or tenure
- Shipping model assumes uniform discount structure (not real carrier tiers)
- Correlation ≠ causation: cross-sell affinity requires A/B test to confirm incremental revenue effect
