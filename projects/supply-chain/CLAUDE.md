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

One row per supplier quote (part × supplier × volume).

## Data sources

- `Quotes` (fact) — Supplier quotes: part, supplier, unit cost, volume, non-recurring expenses, yield rate
- `Internal_Mfg_Resource_Estimates` — Internal cost per unit, existing capacity, machine unit capacity, machine fixed cost
- `Product_Dimension` — Part number and product attributes
- `Yield_Rate` — Yield rate dimension for quality-adjusted cost calculation

## Stakeholders

Widgetmakers Inc procurement team.

## Constraints

- Fictitious data (Widgetmakers Inc) — decision logic transfers; specific numbers do not
- Non-recurring expenses treated as fully upfront (not amortised over contract term) — overstates cost disadvantage of high-setup Buy options at low volumes
- No demand uncertainty modelled — volume is a known input via What-if parameter
- Yield rate applied to Buy scenario only; Make scenario does not yet adjust for internal scrap rates
