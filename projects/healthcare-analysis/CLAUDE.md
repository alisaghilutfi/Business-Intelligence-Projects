# Hospital Efficiency Benchmarking

## Goal

Identify which New York hospitals are statistical outliers in length of stay and cost for elective hip replacement surgery, and understand what patient and facility factors explain the variance.

## Metrics / KPIs

- Average LOS Days (`AVERAGE(hospital_discharges[length_of_stay])`)
- Average Cost per Discharge (`AVERAGE(hospital_discharges[total_costs])`)
- % Var Average LOS Days vs. state average (2.65 days)
- % Var Average Cost per Discharge vs. state average ($20,910)
- Breakdowns by illness severity, mortality risk, age group, discharge disposition, geography

## Grain

One row per inpatient stay (elective hip replacement discharge).

## Data sources

- `hospital_discharges` — 26,286 rows: facility, LOS, cost, age group, diagnosis, severity, mortality risk, disposition (New York State 2016)
- `surgical_program_size_summary` — 151 rows: one row per hospital, total discharges, surgeon count

## Stakeholders

Healthcare administrators and policy makers.

## Constraints

- 2016 data only — methodology transfers; hospital rankings do not reflect current performance
- Elective procedures only — findings are not generalisable to other procedure types or emergency admissions
- Text-based join on `facility_name` — susceptible to name inconsistencies between tables
- Descriptive analysis only — causal conclusions require a controlled study design
- NYC hospitals show structurally higher costs independent of case mix (labour/facility markets)
