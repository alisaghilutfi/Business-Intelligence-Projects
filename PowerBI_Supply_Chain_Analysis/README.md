# PowerBI_Supply_Chain_Analysis — Make-or-Buy Decision Support

**Type:** Business Intelligence · Operations Analytics · Scenario Planning  
**Stack:** Power BI Desktop · Power Query · Snowflake schema · DAX · What-if parameters  
**Data:** Widgetmakers Inc (fictitious) · supplier quotes · internal manufacturing cost estimates

---

## Business Problem

Widgetmakers' procurement team needs to decide, for each part number and production volume, whether to manufacture internally or buy from one of four external suppliers — and the answer changes as volume scales. The wrong decision at any volume point means either unnecessary capital investment or avoidable unit cost premium.

---

## Analytical Question

**Outcome variable:** Total procurement cost (full cost = extended cost + non-recurring expenses)  
**Drivers under investigation:** Supplier, volume, capital investment required, non-recurring setup costs, yield rate  
**Question type:** **Comparison** (Make vs. four Buy options at each volume) with a **Prediction** layer (at what volume does the Make option break even against the cheapest Buy option?)

---

## Data

| Table | Description |
|-------|-------------|
| `Quotes` (fact) | Supplier quotes: part, supplier, unit cost, volume, non-recurring expenses, yield rate |
| `Internal_Mfg_Resource_Estimates` | Internal cost per unit, existing capacity, machine unit capacity, machine fixed cost |
| `Product_Dimension` | Part number and product attributes |
| `Yield_Rate` | Yield rate dimension for quality-adjusted cost calculation |

**Schema:** Snowflake — Quotes as central fact, joined to the three dimension tables.

**Known limitation:** The model treats all non-recurring expenses as fully sunk at volume = 1. In practice, setup costs are often amortised over a contract period — the full cost measure overstates the cost disadvantage of low-volume Buy options with high setup fees.

---

## Approach

The report is structured around the decision progression a procurement analyst actually follows: first, identify the cheapest supplier at a fixed volume; then, understand how cost changes as volume varies; finally, make the Make vs. Buy call with full capital investment visibility.

The **Supplier Selection** page answers the fixed-volume question: given a specific part at a specific quantity, which supplier is cheapest and why? The cost breakdown (extended vs. non-recurring) shows whether a supplier's advantage comes from a lower unit price or lower setup costs — two very different negotiation levers.

The **Scenario Analysis** page introduces the volume dimension via a What-if parameter. All cost measures recalculate dynamically, so the analyst can find the exact volume at which a supplier transitions from cheapest to most expensive. Cost curves are plotted across the range, making break-even points visible without manual calculation.

The **Make vs. Buy** page completes the decision: for any scenario volume, it shows whether Make or Buy minimises full cost, quantifies the cost avoidance, and calculates the capital investment and additional unit capacity required if Make is selected. This prevents the "Make looks cheaper" conclusion from hiding a machine investment that takes three years to recoup.

Key measures:
```dax
Full Cost = Quotes[Extended Cost] + Quotes[Non_recurring_expenses]

Buy Scenario Full Cost = MINX(
    FILTER(Quotes, Quotes[Volume] <= 'Scenario Volume'[Scenario Volume Value]),
    [Scenario_Volume_Value]*Quotes[Unit_Cost]/Quotes[Yield_Rate] + Quotes[Non_recurring_expenses])

Make vs Buy = IF(ISBLANK([Make Scenario Full Cost]), BLANK(),
    IF([Make Scenario Full Cost] >= [Buy Scenario Full Cost], "Buy", "Make"))

Cost Avoidance = ABS([Make Scenario Full Cost] - [Buy Scenario Full Cost])

Capital Investment Required (Make) = MINX(
    Internal_Mfg_Resource_Estimates,
    ROUNDUP([Additional_Unit_Capacity_Required] /
        MIN(Internal_Mfg_Resource_Estimates[Unit_Capacity]), 0) *
    Internal_Mfg_Resource_Estimates[Machine_Fixed_Cost])
```

---

## Key Findings

- **Widgetmakers Inc is the lowest-cost Buy option across most part numbers and volumes evaluated** — its unit cost advantage compounds at higher volumes where non-recurring expenses are amortised, making it the default Buy recommendation unless a specific part has unusually high setup costs at that supplier.
- **Make becomes preferable above a volume threshold specific to each part** — the break-even point is not uniform; high-machine-capacity parts reach Make viability at lower volumes than low-capacity parts.
- **Non-recurring expenses vary significantly between suppliers** — for low-volume orders, a supplier with a lower unit cost but high setup fee can be more expensive in total than a higher unit cost supplier with minimal setup. The extended cost alone is a misleading comparison metric.
- **Capital investment requirements are material** — for parts where Make is optimal, the machine investment payback period should be calculated before committing. The dashboard surfaces the investment amount; the payback calculation requires a demand forecast not present in this dataset.

---

## Limitations & Caveats

- **Fictitious data:** Supplier names, costs, and part numbers are synthetic. The decision logic is transferable; the specific numbers are not.
- **Non-recurring expenses treated as fully upfront:** Setup costs are not amortised over a contract term in the current model. This overstates the cost disadvantage of Buy options with high setup fees at low volumes.
- **No demand uncertainty:** The model treats volume as a known input. Real make-or-buy decisions involve demand forecasts with uncertainty ranges — a sensitivity analysis on the volume parameter would strengthen the recommendation.
- **Yield rate applied only to Buy scenario:** The quality-adjusted cost (`Unit_Cost / Yield_Rate`) is applied in the Buy Scenario measure but should also be applied to the Make scenario if internal scrap rates differ from supplier yield rates.

---

## Probable Next Improvements

- **Add a payback period calculation to the Make vs. Buy page** — divide capital investment by annual cost avoidance to show how many years before the Make option breaks even on its machine investment. This is the number that actually drives the capital approval decision.
- **Model demand uncertainty with a second What-if parameter** — a low/base/high volume range would show how the Make vs. Buy recommendation changes under different demand scenarios, converting a point estimate into a risk-aware recommendation.
- **Add a supplier risk score dimension** — sole-source dependency, lead time, and geographic risk are not captured in cost alone. A weighted score column in the supplier dimension would let the analyst trade off cost against supply chain resilience.

---

## Screenshots

![Supplier Selection](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Supply_Chain_Analysis/images/dashboard_01_Supplier_Selection.PNG)

![Scenario Analysis](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Supply_Chain_Analysis/images/dashboard_02_Scenario_Analysis.PNG)

![Make versus Buy](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Supply_Chain_Analysis/images/dashboard_03_Make_Buy.PNG)

---

## Skills Demonstrated

- Power BI Desktop — 3-page decision-support report with interactive scenario controls
- Power Query — multi-table ETL, yield rate integration, cost normalisation
- DAX — What-if parameters, full cost modelling, Make vs. Buy logic, capital investment calculation, cost avoidance quantification
- Data modeling — snowflake schema, four-table join structure
- Scenario planning — dynamic volume threshold analysis with visual cost curves
