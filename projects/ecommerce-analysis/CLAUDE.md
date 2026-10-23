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

## Notes from original README

**Problem statement:** Whiskique's operations team needs to know where shipping costs can be reduced without hurting revenue; its marketing team needs to know which product combinations most reliably drive cross-sell and upsell conversions — two levers that together determine net profitability.

**Architecture:** Snowflake schema. `fact_Sales` as central fact joined to `dim_Product`, `dim_Customer`, `dim_State_Mapping`, `fact_Invoice_Totals`, and `fact_Market_Baskets`. ~500K rows, Dec 2020–Dec 2021.

**Key design decisions:**
- What-if parameter (Blended Shipping Cost Factor) on Shipping Metrics page — allows dynamic recalculation of all shipping measures without rebuilding visuals; finds the quantity break-even where consolidation saves money.
- `fact_Market_Baskets` as a calculated duplicate of `fact_Sales` with M:M BothDirections on Invoice No — enables product pair correlation without self-joins; intentional design documented in CLAUDE.md.
- `dim_State_Mapping` M:M BothDirections on Order State — intentional to allow region filtering to flow bidirectionally.
- Three-page structure: Executive Summary (P&L overview), Shipping Metrics (cost optimisation), Market Basket Analysis (cross-sell candidates).

**Key findings:**
- Total revenue $1.55M, profit margin 27.50% ($427K); shipping at $385K = 25% of revenue — primary cost lever.
- Quantity-based consolidation reduces per-order shipping ~30% moving from 1 to 2 units; diminishing returns beyond 4 units.
- Market basket correlation matrix surfaces high-affinity product pairs — candidates for "frequently bought together" prompts.
- Certain states show disproportionately high shipping costs relative to revenue — possible carrier/fulfilment centre inefficiencies.

**Probable next improvements:** Customer cohort analysis page; incorporate actual carrier pricing tiers; A/B test top 5 market basket pairs.
