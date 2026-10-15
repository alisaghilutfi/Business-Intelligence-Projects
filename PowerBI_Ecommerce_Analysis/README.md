# PowerBI_Ecommerce_Analysis — E-Commerce Performance & Cost Optimisation

**Type:** Business Intelligence · Operations Analytics  
**Stack:** Power BI Desktop · Power Query · Snowflake schema · DAX · What-if parameters · Market basket analysis  
**Data:** Whiskique (fictitious pet supply store) · transaction-level sales and shipping records

---

## Business Problem

Whiskique's operations team needs to know where shipping costs can be reduced without hurting revenue, and its marketing team needs to know which product combinations most reliably drive cross-sell and upsell conversions — two levers that together determine net profitability.

---

## Analytical Question

**Outcome variables:** Net profit and shipping cost per order  
**Drivers under investigation:** Shipped quantity (shipping cost reduction), product affinity (cross-sell), category, state  
**Question types:**
- **Relationship** — how does shipped quantity affect shipping cost? (to size the consolidation opportunity)
- **Comparison** — which categories and states drive the highest and lowest margins?
- **Relationship** — which product pairs are frequently bought together? (to identify cross-sell candidates)

---

## Data

| Table | Description |
|-------|-------------|
| `Sales` (fact) | Transactions: product, quantity, sales, COGS, shipping cost, customer, state |
| `Product` | Product name, category, description |
| `Customer` | Customer ID and attributes |
| `State Mapping` | State-to-region mapping |

**Schema:** Snowflake — Sales as central fact, joined to Product, Customer, and State Mapping dimensions.

**Known limitation:** Customer LTV is calculated as a simple average (`Total Sales / Number of Customers`) — this does not account for purchase frequency or tenure, so high-LTV customers and high-spend one-time customers are treated identically.

---

## Approach

The report is structured around two distinct decision types, each with its own page.

The **Shipping Metrics** page models the cost reduction opportunity: a What-if parameter lets the user set a target quantity threshold, and all shipping measures recalculate dynamically to show the delta between baseline and optimised cost. The rationale is that shipping discounts scale with quantity — so the page is designed to find the quantity break point where consolidation saves money without pushing customers to over-order.

The **Market Basket Analysis** page uses product correlation coefficients to rank product pairs by purchase affinity. This is a Relationship question answered statistically — high correlation identifies which product to surface at checkout for a given basket, not just which products sell well in isolation. The Purchased Count column grounds the correlation in volume so that a high-correlation pair with only 3 purchases doesn't rank above a moderate-correlation pair with 300.

The **Executive Summary** gives the P&L overview: total sales, profit %, and shipping cost by category and state, with KPI cards at the top for leadership-level consumption.

Key measures:
```dax
Profit (Baseline) = Sales[Sales] - Sales[COGS] - [Shipping (Baseline)]

Shipping (Baseline) = SUMX(Sales,
    IF(Sales[Quantity]=1, Sales[Shipping Cost],
       Sales[Shipping Cost] + (((Sales[Quantity])-1) * (Sales[Shipping Cost]*0.7))))

Shipping (What-if) = SUMX(Sales,
    IF(Sales[Quantity]=1, Sales[Shipping Cost],
       Sales[Shipping Cost] + (((Sales[Quantity])-1) * (Sales[Shipping Cost]*[Blended Shipping Cost Factor]))))

Shipping (Difference) = [Shipping (Baseline)] - [Shipping (What-if)]
```

---

## Key Findings

- **Total revenue $1.55M, profit margin 27.50% ($427K)** — healthy baseline, but shipping at $385K represents 25% of revenue and is the primary cost lever available without touching product pricing.
- **Quantity-based consolidation materially reduces shipping cost** — the What-if model shows that moving customers from 1-unit to 2-unit shipments reduces per-order shipping cost by ~30%, with diminishing returns beyond 4 units.
- **Market basket analysis identifies high-affinity product pairs** — the correlation matrix surfaces specific product combinations where cross-sell conversion is statistically likely; these are candidates for a "frequently bought together" prompt at checkout.
- **Regional shipping patterns vary by state** — certain states show disproportionately high shipping costs relative to revenue, suggesting carrier or fulfilment centre inefficiencies worth investigating at the operational level.

---

## Limitations & Caveats

- **Fictitious dataset:** All customer names, products, and transactions are synthetic — findings are directionally illustrative, not empirically validated on real business data.
- **LTV oversimplification:** Average LTV (`Total Sales / Customers`) conflates acquisition cohort, tenure, and purchase frequency. A proper LTV model requires a date dimension and cohort analysis.
- **Correlation ≠ purchase causation:** A high correlation coefficient between two products in the market basket analysis means they appear in the same baskets often — it does not prove that promoting one drives purchase of the other. An A/B test would be needed to confirm the cross-sell effect.
- **Shipping model assumes uniform discount structure:** The Blended Shipping Cost Factor applies a fixed step-down schedule. Real carrier contracts have volume tiers, weight breaks, and destination zone pricing — a more accurate model would need those parameters.

---

## Probable Next Improvements

- **Add a customer cohort analysis page** — segment customers by first-purchase quarter and track retention and LTV per cohort. This turns the LTV number from a single average into an actionable retention metric.
- **Incorporate actual carrier pricing tiers** — replace the Blended Shipping Cost Factor step function with real zone- and weight-based rates to make the What-if model deployable rather than illustrative.
- **Test the top 5 market basket pairs in a controlled promotion** — correlation identifies candidates; a 30-day A/B test on a "customers also bought" prompt would confirm whether the affinity translates to incremental revenue.

---

## Screenshots

![Executive Summary](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_03_Ecommerce-Analysis/images/dashboard_01_Executive_Summary.PNG)

![Shipping Metrics](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_03_Ecommerce-Analysis/images/dashboard_02_Shipping_Metrics.PNG)

![Market Basket Analysis](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_03_Ecommerce-Analysis/images/dashboard_03_Market_Basket_Analysis.PNG)

---

## Skills Demonstrated

- Power BI Desktop — 3-page report with drill-through and dynamic navigation
- Power Query — multi-table ETL, COGS and shipping cost normalisation
- DAX — What-if parameters, blended cost factor, market basket correlation measures, customer LTV
- Data modeling — snowflake schema, four-table join structure
- Scenario planning — interactive quantity threshold modelling
- Market basket analysis — correlation coefficient calculation and ranking
