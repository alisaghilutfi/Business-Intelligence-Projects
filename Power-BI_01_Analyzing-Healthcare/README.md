# Healthcare Data Analysis in Power BI
## Hospital Efficiency Insights for Elective Hip Replacement Surgery


## 📊 Project Overview
This Power BI project analyzes hospital efficiency metrics using real-world healthcare data to identify optimization opportunities for a fictional consulting company, HealthStat. The analysis focuses on elective hip replacement surgery patients across New York State hospitals, examining factors that impact patient length of stay (LOS) and treatment costs.


## 🎯 Business Objectives
`Primary Goal:` Uncover actionable insights on hospital efficiency opportunities

`Target Audience:` Healthcare administrators, hospital management, and policy makers

`Key Questions Addressed:`
- Which hospitals have the highest cost and LOS relative to state averages?
- What factors most significantly influence patient length of stay and costs?
- How does surgical program size impact efficiency metrics?
- Which hospitals are the biggest outliers in terms of performance?


## 📋 Dataset Information
`Source:` New York State hospital discharge data (2016)

`Population:` Elective hip replacement surgery patients

`Records:` 26,286 total discharges across 151 hospitals

`Structure:` hospital_discharges table with 30 columns is connected to through facility_name column  to surgical_program_size_summary table with 5 columns 

`Scope:` In hospital_discharges table, each row represents one inpatient stay/discharge while in surgical_program_size_summary table, each row represents one hospital total discharges/surgeons

### Key Performance Indicators (KPIs)
| Metric | Value | Description |
|----------|----------|----------|
| Average LOS | 2.65 days | Mean patient length of stay |
| Average Cost | $20,910 | Average cost per discharge |
| Total Hospitals | 151 | NY hospitals performing hip replacement |
| Total Discharges | 26,286 | Total patient cases analyzed |


## 📈 Key Data Attributes
`length_of_stay:` Total days patient stayed in hospital (including surgery and recovery)

`total_costs:` Total financial cost for the entire stay

`facility_id:` Unique hospital identifier

`age_group:` Patient age at discharge

`patient_disposition:` Patient destination/status upon discharge

`ccs_diagnosis_description:` Primary diagnosis code for hospital stay

`apr_severity_of_illness_description:` Illness severity (1-Minor to 4-Extreme)

`apr_risk_of_mortality:` Mortality risk level (1-Minor to 4-Extreme)


## 🔍 Key Insights Discovered
### Top factors increasing average LOS and cost
- Extreme illness severity - Highest impact on both metrics
- Extreme/Major mortality risk - Significant cost and LOS increases
- Geographic location - NYC hospitals show higher costs
- Discharge disposition - Skilled nursing home transfers increase LOS

### Hospital Performance Variability
- Significant variation exists between hospitals in both cost efficiency and LOS
- Larger surgical programs may demonstrate different efficiency patterns
- Geographic and demographic factors play substantial roles in outcomes


## 📊 Dashboard Components
The Power BI solution includes three comprehensive reports:

### LOS Comparison Dashboard
- Hospital-to-hospital length of stay benchmarking
- State average comparisons and outlier identification
- Trend analysis and distribution visualizations
![LOS Comparison Overview](Power-BI_01_Analyzing-Healthcare/images/dashboard_1_LOS_Comparison.png)

### Cost Comparison Dashboard
- Cost per discharge analysis across facilities
- Cost efficiency benchmarking against state averages
- Financial performance outlier detection
![Cost Comparison Overview](Power-BI_01_Analyzing-Healthcare/images/dashboard_2_Cost_Comparison.png)

### Hospital Profile Dashboard
- Individual hospital deep-dive analysis
- Comprehensive facility performance metrics
- Root cause analysis for cost and LOS variations
![Hospital Profile Overview](images/dashboard_3_Profile_Hospitals.png)


## 🛠️ Technical Implementation
### Tools & Technologies
- Primary Platform: Microsoft Power BI Desktop
- Data Source: CSV/Excel format hospital discharge data
- Analysis Type: Descriptive and comparative analytics
- Visualization: Interactive dashboards with drill-down capabilities

### Calculated Measures
Custom DAX measures created for:

- Total surgeons
- Total Hospitals
- Total Discharges
- Average LOS Days
- % Var Average LOS Days 
- Average LOS Days_ALL
- Average Cost per Discharge
- % Var Average Cost per Discharge
- Average Cost per Discharge_ALL
- Title Selected Facility
![Calculated Measures Overview](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_01_Analyzing-Healthcare/images/Calculated_Measures.PNG)


