# Make-or-Buy Decision Support

## Goal

Determine, for each part number and production volume, whether Widgetmakers Inc should manufacture internally or buy from one of four external suppliers — and identify the volume break-even point where the recommendation switches.

## Metrics / KPIs

- Full Cost (`Quotes[Extended Cost] + Quotes[Non_recurring_expenses]`)
- Buy Scenario Full Cost — minimum full cost across suppliers at scenario volume
- Make Scenario Full Cost — internal manufacturing cost at scenario volume
- Make vs Buy decision flag
- Cost Avoidance (`ABS([Make Scenario Full Cost] - [Buy Scenario Full Cost])`)
- Capital Investment Required (Make)

## Grain

One row per supplier quote (`fact_Quotes`). Grain: Part_Number × Supplier × Volume tier.

## Data sources

- `fact_Quotes` — Supplier quotes: part, supplier, unit cost, volume, non-recurring expenses, yield rate
- `fact_Mfg_Estimates` — Internal cost per unit, existing capacity, machine unit capacity, machine fixed cost
- `dim_Product` — Part number, part name, and project assignment
- `dim_Yield_Rate` — Supplier yield rates for quality-adjusted cost calculation

## Stakeholders

Widgetmakers Inc procurement team.

## Constraints

- Fictitious data (Widgetmakers Inc) — decision logic transfers; specific numbers do not
- Non-recurring expenses treated as fully upfront (not amortised over contract term) — overstates cost disadvantage of high-setup Buy options at low volumes
- No demand uncertainty modelled — volume is a known input via What-if parameter
- Yield rate applied to Buy scenario only; Make scenario does not yet adjust for internal scrap rates
- **No temporal dimension** — this model contains no date or time columns; time intelligence measures are not applicable

## Notes from original README

**Problem statement:** Widgetmakers' procurement team needs to decide, for each part number and production volume, whether to manufacture internally or buy from one of four external suppliers — and the answer changes as volume scales. The wrong decision at any volume point means unnecessary capital investment or avoidable unit cost premium.

**Architecture:** Snowflake schema. `fact_Quotes` as central fact joined to `fact_Mfg_Estimates`, `dim_Product`, and `dim_Yield_Rate`. Fictitious Widgetmakers Inc dataset.

**Key design decisions:**
- What-if parameter (Scenario Volume) — all cost measures recalculate dynamically; cost curves plotted across volume range making break-even points visible without manual calculation.
- Three-page decision progression: Supplier Selection (fixed-volume cheapest supplier) → Scenario Analysis (volume-varying cost curves) → Make vs. Buy (full cost comparison with capital investment visibility). Mirrors the actual procurement analyst workflow.
- `Buy Scenario Full Cost` uses `MINX + FILTER` on Quotes — selects minimum full cost supplier at scenario volume, not just unit cost; extends cost breakdown to show whether advantage is from unit price or setup cost (two different negotiation levers).
- Capital Investment Required (Make) calculation exposed on Make vs. Buy page — prevents "Make looks cheaper" conclusion from hiding machine investment payback period.
- Yield rate applied to Buy scenario only (quality-adjusted cost = unit cost / yield rate); Make scenario does not yet adjust for internal scrap rates — documented asymmetry.

**Key findings:**
- Widgetmakers Inc is the lowest-cost Buy option across most part numbers and volumes — unit cost advantage compounds at higher volumes.
- Make becomes preferable above a volume threshold specific to each part — break-even is not uniform; high-machine-capacity parts reach Make viability at lower volumes.
- Non-recurring expenses vary significantly between suppliers — extended cost alone is a misleading comparison metric at low volumes.
- Capital investment requirements are material — payback period calculation requires a demand forecast not present in this dataset.

**Probable next improvements:** Payback period calculation on Make vs. Buy page; demand uncertainty via second What-if parameter (low/base/high); supplier risk score dimension.
