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
