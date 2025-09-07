
# Customer Churn Analysis in Excel
## Telecom Customer Retention Insights for Databel


## 📊 Project Overview
This Excel project analyzes customer churn patterns using real-world telecom data to identify retention opportunities for a fictional telecom company, Databel. The analysis focuses on subscription-based customers, examining factors that impact customer churn rates and developing actionable strategies to reduce customer attrition.


## 🎯 Business Objectives
`Primary Goal:` Uncover actionable insights on customer retention opportunities

`Target Audience:` Customer success managers, marketing teams, and business executives

`Key Questions Addressed:`
- What is the current churn rate and which customers are most at risk?
- What are the primary reasons customers are leaving Databel?
- How do demographic factors influence customer churn behavior?
- Which service plans and usage patterns correlate with higher retention?
- How does customer tenure and contract type affect churn likelihood?


## 📋 Dataset Information
`Source:` Databel telecom customer data

`Population:` Subscription-based telecom customers

`Records:` 6,687 customer records across multiple service categories

`Structure:` Two main datasets - Customer-level data (Databel - Customer) with 29 columns connected to aggregate data (Databel - Aggregate) with 21 columns

`Scope:` Each row in customer data represents one customer account, while aggregate data provides grouped analysis views

### Key Performance Indicators (KPIs)
| Metric | Value | Description |
|----------|----------|----------|
| Total Customers | 6,687 | Total customer accounts analyzed |
| Churned Customers | 1,796 | Customers who terminated service |
| Churn Rate | 26.86% | Percentage of customers who churned |
| Primary Churn Reason | Competitor | Leading cause of customer attrition |


## 📈 Key Data Attributes
`Churn Label:` Customer status indicating "Yes" or "No" for churn

`Churn Category:` Grouped reasons for customer churn (Competitor, Dissatisfaction, etc.)

`Churn Reason:` Specific detailed reason for customer departure

`Age:` Customer age demographic information

`Contract Type:` Month-to-Month, One Year, or Two Year agreements

`Unlimited Data Plan:` Premium unlimited data subscription status

`International Plan:` International calling plan subscription

`Account Length:` Customer tenure in months

`Monthly Charges:` Average monthly billing amount


## 🔍 Key Insights Discovered
### Top Churn Drivers
- **Competitor Activity** - Highest category of churn at 45% of all departures
- **Customer Demographics** - Senior citizens (65+) show significantly higher churn rates
- **Service Plans** - Customers on unlimited data plans exhibit higher churn tendency
- **Contract Terms** - Month-to-month contracts correlate with increased churn risk

### Customer Behavior Patterns
- **Age Segmentation** - Customers under 30 and seniors show distinct churn patterns
- **Usage Consumption** - Data usage levels directly impact retention rates
- **Geographic Factors** - State-level variations in churn rates, especially with international plans
- **Tenure Effect** - Customer churn decreases significantly after the first year


## 📊 Dashboard Components
The Excel solution includes comprehensive analysis across three stages:

### 1: Exploratory Analysis
- Data preparation and duplicate detection
- Churn rate calculation and baseline metrics
- Primary churn reason identification and categorization
- Competitive analysis deep-dive

### 2: Churn Pattern Investigation  
- Demographic analysis with age grouping
- Service plan impact assessment (unlimited data, international plans)
- Contract type and tenure correlation analysis
- Geographic churn rate variations

### 3: Executive Dashboard
- KPI summary with key metrics display
- Churn reason breakdown visualization
- Demographic insights presentation
- Data consumption pattern analysis


## 🛠️ Technical Implementation
### Tools & Technologies
- **Primary Platform:** Microsoft Excel (Advanced Features)
- **Data Source:** CSV format customer records
- **Analysis Type:** Descriptive analytics with predictive insights
- **Visualization:** Interactive charts with drill-down capabilities

### Advanced Excel Features Used
**Data Management:**
- Table formatting for structured data analysis
- Duplicate detection and data validation
- Conditional formatting for pattern identification

**Analysis Functions:**
- Nested IF() formulas for demographic categorization
- PivotTables with calculated fields and custom groupings
- Advanced filtering and data aggregation

**Visualizations:**
- 2D Bar Charts for churn reason analysis
- Line and clustered column combo charts
- Stacked bar charts for multi-dimensional analysis
- Color-coded matrices for geographic insights

### Custom Calculations
Key measures created include:

- **Churned Binary Column:** IF() conversion of churn labels
- **Churn Rate Calculated Field:** Automated percentage calculation
- **Demographics Categories:** Nested IF() for age segmentation  
- **Grouped Consumption:** Data usage tier classification
- **Account Length Groupings:** Tenure-based customer segmentation


## 📈 Dashboard Highlights
The final dashboard provides executive-level insights with:

- **Real-time KPIs** - Total customers, churn count, and churn percentage
- **Root Cause Analysis** - Detailed breakdown of why customers leave
- **Demographic Insights** - Age and gender-based churn patterns  
- **Service Impact Assessment** - How different plans affect retention
- **Geographic Analysis** - State-level churn rate variations
- **Actionable Recommendations** - Data-driven retention strategies


## 💡 Business Impact
This analysis enables Databel to:
- **Identify At-Risk Customers** - Target retention efforts effectively
- **Optimize Service Offerings** - Adjust plans based on churn correlation
- **Improve Customer Segmentation** - Tailor marketing by demographics
- **Enhance Competitive Response** - Address competitor-driven churn
- **Reduce Revenue Loss** - Implement proactive retention strategies

