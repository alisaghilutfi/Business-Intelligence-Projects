# retail-profitability

## Goal

Identify which customer segments, regions, product categories, and discount practices
drive or hurt profit margin — to inform portfolio priorities.

## Metrics / KPIs

- Profit Margin % (Profit / Sales) — primary KPI
- Profit by Segment / Region / Category / Sub-Category
- Discount Impact on Profit (discount band vs avg profit margin)
- Sales and Profit YoY trend (2020 vs 2021)
- Top/bottom 10 products by profit margin

## Grain

One row = one product line on one order.
Natural key: (Order ID, Product ID) — asserted unique in 01_union_and_clean.py.
Surrogate: LineKey (dense integer row index, 1-based).

**Implication:** `[Order Count]` requires `DISTINCTCOUNT(fct_OrderLines[OrderID])` — not
`COUNTROWS` — because a multi-product order spans several rows.

## Data sources

Pavan Lalwani 49-CSV US Superstore dataset, 2020–2021.
Path: projects/retail-profitability/_data/ (gitignored).
Encoding: cp1252. 47 of 49 states after skipping Delaware (empty) and NJ-Copy (duplicate).

## Stakeholders

Portfolio / learning project (no live stakeholder). Decision-maker: Ali Saghi.

## Constraints

No RLS required. No scheduled refresh. Report must answer the top 5 profitability
questions without additional data prep.

---

## Analyst Mindset Kickoff Checklist

Work through these before touching data or building anything.
Source: "Thinking Like an Analyst" — Jon Christiansen (27 episodes)

- [x] **PROBLEM** — What decision does this analysis support? One clear sentence.
- [x] **QUESTION** — What are we actually trying to explain? (outcome vs. drivers)
- [x] **QUESTION TYPE** — Comparison / Relationship / Prediction / Classification?
- [x] **MEASUREMENT** — How are we operationalizing the key concept into data?
- [x] **DATA QUALITY** — Accurate? Complete? Relevant? Consistent? Timely?
- [x] **DATA SOURCE** — Who collected this? What bias might exist?
- [ ] **EXPLORATION** — What patterns, anomalies, trends appear before modeling?
- [ ] **RELATIONSHIPS** — Correlation or causation? Rates vs. totals?
- [ ] **EVIDENCE** — Does this data actually prove what we're claiming?
- [ ] **COMPARISON** — Is this fair? Meaningful? Actionable?
- [ ] **METHOD** — Matching method to problem, or problem to method?
- [ ] **MODEL** — What does this model leave out? What are its blind spots?
- [ ] **AI** — Where does AI add value? What judgment does it still need?
- [ ] **INSIGHT->DECISION** — What should the decision-maker DO with this?
- [ ] **COMMUNICATION** — Can I explain this in plain language? What's the next action?

---

## Problem framing (2026-11-14)

- Decision:        Identify which segments, regions, categories, and discount practices
                   drive or hurt profit margin -- to inform portfolio priorities.
- Decision-maker:  Portfolio reviewer / Ali Saghi (learning project)
- Outcome:         Profit Margin %     Drivers: discount rate, category, segment, region,
                   ship mode, order size
- Question type:   Comparison + Relationship
- Measurement:     Profit Margin % = SUM(Profit) / SUM(Sales).
                   Not measured: returns, cost breakdown, ops costs outside the Profit field.
- Data:            Pavan Lalwani 49-CSV US Superstore dataset, 2020-2021.
                   Known bias/gaps: Delaware empty (skipped), NJ-Copy duplicate (dropped),
                   no returns table, Profit is pre-computed -- discount impact analysis is
                   correlational only (no cost decomposition available).
- Open questions:  None for a portfolio build -- assumptions recorded above.
