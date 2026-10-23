# Hospital Efficiency Benchmarking

## Goal

Identify which New York hospitals are statistical outliers in length of stay and cost for elective hip replacement surgery, and understand what patient and facility factors explain the variance.

## Metrics / KPIs

- Average LOS Days (`AVERAGE(fact_Hospital_Discharges[length_of_stay])`)
- Average Cost per Discharge (`SUM(fact_Hospital_Discharges[total_costs]) / [Total Discharges]`)
- % Var Average LOS Days vs. state average (2.65 days)
- % Var Average Cost per Discharge vs. state average ($20,910)
- Breakdowns by illness severity, mortality risk, age group, discharge disposition, geography

## Grain

One row per inpatient stay (`fact_Hospital_Discharges`). Grain: individual patient discharge.

## Data sources

- `fact_Hospital_Discharges` — 26,286 rows: facility, LOS, cost, age group, diagnosis, severity, mortality risk, disposition (New York State 2016, elective hip replacements only)
- `dim_Surgical_Program` — 151 rows: one row per hospital, total discharges, surgeon count

## Stakeholders

Healthcare administrators and policy makers.

## Constraints

- 2016 data only — methodology transfers; hospital rankings do not reflect current performance
- Elective procedures only — findings are not generalisable to other procedure types or emergency admissions
- Text-based join on `facility_name` — susceptible to name inconsistencies between tables
- Descriptive analysis only — causal conclusions require a controlled study design
- NYC hospitals show structurally higher costs independent of case mix (labour/facility markets)
- **`discharge_year` is an integer (value: 2016 only)** — there is no date column in this dataset; time intelligence measures are not applicable

## Notes from original README

**Problem statement:** Healthcare administrators and policy makers need to identify which New York hospitals are statistical outliers in LOS and cost for elective hip replacement surgery, and understand what patient and facility factors explain the variance — so underperforming hospitals have a concrete starting point for operational review.

**Architecture:** Two-table model. `fact_Hospital_Discharges` (26,286 rows, one row per inpatient stay) joined to `dim_Surgical_Program` (151 rows, one row per hospital) via `facility_name` text join. NY State 2016, elective hip replacements only.

**Key design decisions:**
- Three-page benchmarking structure: LOS Comparison → Cost Comparison → Hospital Profile drill-down — mirrors the workflow a healthcare administrator actually follows: identify outliers, then profile worst performers.
- State averages hardcoded as constants (LOS: 2.65 days, Cost: $20,910) — no date dimension means no time intelligence; ALL-context DAX used for state baseline measures.
- NYC geographic split surfaced explicitly on Cost Comparison page — NYC hospitals show structurally higher costs from labour/real-estate markets, not inefficiency; conflating without geographic context produces misleading recommendations.
- Severity and mortality risk breakdowns on both comparison pages — key analytical question is whether high LOS/cost is explained by sicker patient mix or operational inefficiency; these dimensions enable that decomposition.
- Text-based join on `facility_name` — documented risk; any hospital with name inconsistency drops silently from profile analysis.

**Key findings:**
- Illness severity is the dominant driver of both LOS and cost — any hospital comparison not controlling for severity mix is comparing unlike populations.
- NYC hospitals show structurally higher costs independent of case mix — state-wide benchmark without geographic segmentation will systematically mislabel NYC hospitals as underperformers.
- Discharge to skilled nursing facilities increases LOS — clinically expected; LOS benchmarks should account for discharge destination.
- Surgical programme size shows weak correlation with efficiency — volume-outcome relationships in elective surgery are more complex than a simple size effect.

**Probable next improvements:** Case-mix adjusted benchmark (expected vs. actual LOS/cost); multi-year data (2017–2023); surgeon-level breakdown.
