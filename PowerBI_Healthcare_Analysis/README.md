# PowerBI_Healthcare_Analysis — Hospital Efficiency Benchmarking

**Type:** Business Intelligence · Healthcare Analytics  
**Stack:** Power BI Desktop · Power Query · DAX · Benchmarking · Drill-down  
**Data:** New York State hospital discharge records (2016) · 26,286 elective hip replacement cases · 151 hospitals

---

## Business Problem

Healthcare administrators and policy makers need to identify which New York hospitals are statistical outliers in length of stay (LOS) and cost for elective hip replacement surgery, and understand what patient and facility factors explain the variance — so that underperforming hospitals have a concrete starting point for operational review.

---

## Analytical Question

**Outcome variables:** Average length of stay (days) and average cost per discharge ($)  
**Drivers under investigation:** Illness severity, mortality risk, patient age group, discharge disposition, hospital geographic location, surgical programme size  
**Question type:** **Comparison** (hospital vs. state average) with a **Relationship** layer (which patient and facility factors are associated with higher LOS and cost?)

This is a descriptive analysis — it identifies *where* and *what*, not *why* in a causal sense. Conclusions about causation would require a regression model controlling for case mix.

---

## Data

| Table | Description | Rows |
|-------|-------------|------|
| `hospital_discharges` | One row per inpatient stay: facility, LOS, cost, age group, diagnosis, severity, mortality risk, disposition | 26,286 |
| `surgical_program_size_summary` | One row per hospital: total discharges, surgeon count | 151 |

**Join:** `facility_name` (text join — susceptible to name inconsistencies between tables; should be verified before extending the model).

**Scope:** Elective hip replacement only (CCS diagnosis code filtered). Emergency admissions and other procedure types are excluded — findings are not generalisable to other surgical procedures or admission types.

**Known limitation:** The dataset is from 2016. Hospital rankings, cost structures, and care pathways will have changed. This analysis is a methodological demonstration, not a current-year performance assessment.

---

## Approach

The report is structured around the benchmarking workflow a healthcare administrator actually follows: first, identify the outliers; then, profile the worst performers to understand whether the variance is explained by patient mix (severity, age) or by operational factors (programme size, geography).

The **LOS Comparison** page ranks all 151 hospitals against the state average LOS (2.65 days). Outlier hospitals are visually flagged. The key analytical question on this page is whether a hospital's high LOS is driven by a genuinely sicker patient population or by operational inefficiency — the severity and mortality risk breakdowns allow this decomposition.

The **Cost Comparison** page applies the same benchmarking logic to cost per discharge ($20,910 state average). The geographic breakdown (NYC vs. non-NYC) is surfaced explicitly because NYC hospitals show structurally higher costs that are partially explained by real-estate and labour markets rather than inefficiency — conflating these without geographic context would produce misleading recommendations.

The **Hospital Profile** page allows a drill-down into any individual hospital: full metric suite, patient mix, and comparison to state average in one view. This is the page a hospital administrator would use to prepare for a performance review.

Key measures:
```dax
Average LOS Days = AVERAGE(hospital_discharges[length_of_stay])
Average Cost per Discharge = AVERAGE(hospital_discharges[total_costs])
% Var Average LOS Days = DIVIDE([Average LOS Days] - [Average LOS Days_ALL], [Average LOS Days_ALL])
% Var Average Cost per Discharge = DIVIDE([Average Cost per Discharge] - [Average Cost per Discharge_ALL], [Average Cost per Discharge_ALL])
```

---

## Key Findings

- **Illness severity is the dominant driver of both LOS and cost** — extreme severity cases show materially higher LOS and cost than minor severity cases at every hospital. Any hospital comparison that does not control for severity mix is comparing unlike populations.
- **NYC hospitals show structurally higher costs independent of case mix** — the geographic premium is not primarily a severity artefact; it reflects labour and facility cost differences. A state-wide benchmark that does not segment by geography will systematically flag NYC hospitals as underperformers when some of the variance is structural.
- **Discharge disposition to skilled nursing facilities increases LOS** — patients discharged to nursing homes stay longer than those discharged home, which is clinically expected. LOS benchmarks should account for discharge destination to avoid penalising hospitals serving populations with higher post-acute care needs.
- **Surgical programme size shows weak correlation with efficiency** — larger programmes (more discharges per year) do not consistently show lower LOS or costs at the 2016 snapshot level. Volume-outcome relationships in elective surgery are more complex than a simple size effect.

---

## Limitations & Caveats

- **2016 data only:** Ten-year-old data has limited operational relevance. The methodology transfers; the hospital rankings do not.
- **Descriptive, not causal:** The analysis identifies associations between patient factors and outcomes. It does not establish that changing a factor (e.g., reducing severity mix by transferring complex cases) would actually reduce LOS — that requires a controlled study design.
- **Text-based join between tables:** The `facility_name` join is susceptible to inconsistencies. Any hospital that appears in one table but not the other will silently drop from the profile analysis. A facility ID join would be more robust.
- **Elective procedures only:** Hip replacement patients are a select population (scheduled, non-emergency, relatively healthy). Findings do not generalise to emergency admissions, other surgical procedures, or non-surgical care pathways.

---

## Probable Next Improvements

- **Add a case-mix adjusted benchmark** — calculate expected LOS and cost for each hospital based on its actual patient severity and age distribution, then compare actual vs. expected. This converts a raw benchmark into a fair comparison and is the standard methodology in healthcare efficiency analysis.
- **Incorporate multi-year data (2017–2023)** — a single year snapshot cannot distinguish between a hospital that improved and one that deteriorated. Trend lines would make the analysis actionable for current performance management rather than just historically descriptive.
- **Add a surgeon-level breakdown where data permits** — programme size is a facility metric; surgeon volume is often a stronger predictor of outcomes in elective surgery. If surgeon-level identifiers are available in the discharge data, disaggregating the programme size analysis to the surgeon level would significantly sharpen the efficiency insight.

---

## Screenshots

![LOS Comparison](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Healthcare_Analysis/images/dashboard_1_LOS_Comparison.PNG)

![Cost Comparison](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Healthcare_Analysis/images/dashboard_2_Cost_Comparison.PNG)

![Hospital Profile](https://github.com/alisaghilutfi/Business-Intelligence-Projects/blob/main/PowerBI_Healthcare_Analysis/images/dashboard_3_Profile_Hospitals.PNG)

---

## Skills Demonstrated

- Power BI Desktop — 3-page benchmarking report with drill-down to hospital profile
- Power Query — hospital discharge data cleaning, facility name normalisation, scope filtering
- DAX — variance measures (% vs. state average), ALL-context comparisons, dynamic titles
- Data modeling — two-table join, text-key relationship (facility name)
- Benchmarking methodology — state average baseline, outlier identification, case mix decomposition
- Healthcare analytics — LOS and cost analysis, severity and mortality risk breakdowns
