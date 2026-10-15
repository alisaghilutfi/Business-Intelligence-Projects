# PowerBI_Finance_Analysis — Financial Transactions Dashboard

**Type:** Business Intelligence · Finance  
**Stack:** Power BI Desktop · Power Query · DAX · Field parameters · Custom tooltips · Conditional formatting  
**Data:** FinSight (fictitious financial organisation) · multi-segment transaction records · multi-region

---

## Business Problem

FinSight's finance leadership needs a single view that answers two questions at different levels of detail: how are transaction volumes, fees, and taxes trending across segments and geographies at the macro level (C-suite), and where are the specific operational exceptions — failed transactions, anomalous fee patterns — that warrant investigation (operations team)?

One dashboard needs to serve both audiences without forcing either to navigate a report designed for the other.

---

## Analytical Question

**Outcome variables:** Total transaction amount, fees, taxes, transaction count  
**Drivers under investigation:** Transaction status, customer segment, state, transaction type, gender, time (month/year)  
**Question types:**
- **Comparison** — how do transaction metrics compare across segments, regions, and time periods?
- **Relationship** — which combinations of segment, region, and transaction type are associated with high failure rates or fee anomalies?

---

## Data

| Source | Description |
|--------|-------------|
| `Transactions` | Transaction ID, amount, fees, tax, status, segment, state, transaction type, gender, date |
| `Calendar` | Date dimension for time intelligence |

**ETL decisions with analytical consequences:**
- **Negative transaction amounts converted to absolute values** — raw data contained negative integers for certain transaction types. Converting to absolute values prevents these from offsetting revenue totals, but it also means the report cannot distinguish between reversals and genuine charges without a separate transaction-type filter.
- **Data normalisation on text fields** — corrupted entries (e.g., `M@bile App` → `Mobile App`) were standardised. Any uncorrected variants would silently undercount the channel.
- **Decimal precision fixed to two places** — micro-fee decimals were truncated to match standard banking output format.

---

## Approach

The layout follows the **F-pattern** — the most important information (KPI cards and the metric switcher) sits in the top-left zone where executive attention lands first, with supporting detail below and to the right.

The **Executive Summary** uses a field parameter slicer (`_Metrics`) to switch the entire page's context between Total Amount, Total Fees, Total Tax, and Total Transactions in a single click — four views of the same data without four separate pages. The dynamic chart title reflects the active metric so the visual is never unlabelled. The monthly area chart provides the macro trend; the categorical breakdowns (segment, state, transaction type) let the executive slice it without leaving the page.

The **Transaction Details** page serves the operations use case. Drill-through wiring from Page 1 lands the user in a contextualized transaction ledger — the filter from Page 1 is preserved, so the analyst sees exactly the records behind the number they clicked on. Conditional formatting highlights failed transactions in a warning-red tint, making exceptions scannable in a dense table. The dynamic header title (`Transaction Details: Retail`) confirms the active filter so the analyst always knows what subset they're looking at.

The **Monthly State Tooltip** is a micro-optimisation that eliminates a common drill-through dead-end: hovering over any point on the monthly trend line surfaces a pop-up showing the top states by active customer density for that exact month, without requiring navigation away from the trend view.

Key measures:
```dax
Total Amount = SUM(Transactions[Amount])
PY Amount = CALCULATE([Total Amount], SAMEPERIODLASTYEAR('Calendar'[Date]))
YOY Amount = [Total Amount] - [PY Amount]
YOY% Amount = DIVIDE([YOY Amount], [PY Amount])

Dynamic Month Chart Title =
SWITCH(
    SELECTEDVALUE('_Metrics'[_Metrics Order]),
    0, "Total Amount by Month",
    1, "Total Fees by Month",
    2, "Total Tax by Month",
    3, "Total Transactions by Month",
    "Financial Metric by Month"
)
```

---

## Key Findings

- **Field parameter switching significantly reduces page count** — four metric views are served from one page, keeping the report compact without sacrificing analytical depth. This is a design pattern worth replicating on any dashboard with multiple KPIs sharing the same dimensional structure.
- **Conditional formatting on failed transactions makes exception management practical** — in a dense transaction ledger, colour is the only way to make exceptions scannable without pre-filtering; the risk matrix approach prioritises attention without hiding data.
- **Drill-through with dynamic titles eliminates context loss** — the most common complaint in dense Power BI reports is "I don't know what slice I'm looking at"; the dynamic header solves this for the transaction detail use case.

*Note: FinSight is a fictitious organisation. Specific transaction volumes, fee totals, and segment breakdowns are not disclosed here as the dataset is illustrative rather than derived from real financial records.*

---

## Limitations & Caveats

- **No anomaly detection:** The conditional formatting flags known failure statuses — it does not detect statistically unusual fee amounts or transaction patterns. A proper anomaly detection layer would require either Power BI Anomaly Detection on the time series or a DAX measure comparing each transaction to a rolling average threshold.
- **Negative-to-absolute conversion loses reversal signal:** Converting negative amounts to absolute values for cleaner totals removes the ability to identify net revenue impact of reversals without re-introducing the original sign via a transaction type filter. This is a documented trade-off, not an oversight.
- **Calendar table is generated, not provided:** Time intelligence depends on a complete calendar table with no gaps. If the transaction data has date gaps, the YoY measures will silently calculate against incomplete prior-year periods.

---

## Probable Next Improvements

- **Add an anomaly detection measure for fees** — a DAX rolling-average comparison (`Fee vs. 3-month average fee for same segment`) would surface unusual fee patterns without requiring a manual threshold, converting the exception management page from reactive to proactive.
- **Introduce a customer-level drill-through page** — the current report operates at segment and state level; a customer profile page (reachable from the transaction ledger) would let the operations team investigate individual accounts without leaving Power BI.
- **Extend the field parameter to include YoY%** — the current switcher covers totals but not growth rates. Adding `YOY% Amount`, `YOY% Fees`, etc. to the `_Metrics` table would give leadership a growth-rate view on the same page without additional pages or visuals.

---

## Screenshots

*(Screenshots to be added — open the `.pbix` file in Power BI Desktop to view the full report.)*

---

## Skills Demonstrated

- Power BI Desktop — 3-page report with F-pattern layout, drill-through, and custom tooltip
- Power Query — data cleansing (text normalisation, decimal precision), negative value handling
- DAX — time intelligence (SAMEPERIODLASTYEAR, YoY%), field parameters, dynamic titles, SWITCH
- Report design — F-pattern layout, conditional formatting risk matrix, drill-through context preservation
- UX patterns — tooltip-as-mini-dashboard, dynamic labelling, metric switcher
