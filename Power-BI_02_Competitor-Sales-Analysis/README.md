
# Competitor Sales Analysis in Power BI
## Market & Sales Insights Across Manufacturers and Geographies

## 📊 Project Overview
This Power BI project delivers a comprehensive sales and market share analysis for competing manufacturers across multiple regions. Through a structured ETL process, data modeling, and interactive visualization, this case study simulates a real-world business scenario to help stakeholders understand both internal company performance and how it stacks up against competitors.
The analysis empowers business users with actionable insights into product trends, competitor growth, and market penetration using a dynamic Power BI report.


## 🎯 Business Objectives
`Primary Goal:` Analyze and compare sales performance of a manufacturer against its competitors to understand market trends and strategic opportunities.

`Target Audience:` Business analysts, sales managers, marketing strategists, and executive decision-makers.

`Key Questions Addressed:`
- Who are the top competitors generating the most revenue globally and regionally?
- How does our company’s performance compare to others in different markets?
- Which product segments show the most growth over time?
- What are the yearly sales trends and market share shifts?
- Where are our biggest opportunities for market expansion?


## 📋 Dataset Information
### Data Structure

### Fact Table:
`Sales`
- ProductID: Unique identifier for each product
- Date: Sales transaction date
- Zip: ZIP code of transaction location
- Revenue: Total revenue per transaction

### Dimension Tables:
`Product:` Product details

`Manufacturer:` Manufacturer details with logos

`Geography:` Region, city, ZIP, and state data

`Date:` Created dynamically using DAX

### Schema: 
`Snowflake` schema with Sales as the central fact table connected to all dimension tables.


## 🧮 Key Performance Indicators (KPIs)
| Metric | Value/Description |
|----------|--------------------|
| Market Share (Sintec - USA) | 38.22% |
| Market Share (Sintec - Global) | 21.15% |
| Highest Revenue Share (Germany) | Artisans with >50% market share |
| Year-over-Year Growth (2021) | 18.8%|
| Total Manufacturers Analyzed | Multiple across global markets |
| Time Period | Multiple years (includes year-on-year tracking) |


## 📈 Key Insights Discovered
### Revenue & Market Performance
- Sintec has a dominant 38.22% share in the U.S. market and 21.15% globally.
- Artisans leads the German market with over 50% share.
- 2021 saw an 18.8% revenue growth, suggesting strong momentum.

### Product & Segment Trends
- Certain product lines are outperforming others based on geography.
- High-growth markets and underperforming regions are easily identifiable via comparative visualizations.


## 📊 Dashboard Components
The Power BI solution includes three comprehensive reports:
### Competitor Salse Analysis
- Revenue by country and manufacturer
- Revenue and growth percentage over time for manufacturers
- Market share visualized by region and product
- Year-over-year growth comparisons
- Comparison against competitors within product categories

![Competitor Salse Analysis](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_02_Competitor-Sales-Analysis/images/dashboard_01_Competitor-Sales-Analysis.PNG)

### Advanced Insights (AI-Driven Visuals)
- Decomposition Tree for revenue drilldowns
- Key Influencers to detect major factors impacting sales
- Smart Narratives to auto-summarize insights

![AI-Driven Visuals](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_02_Competitor-Sales-Analysis/images/dashboard_02_Advanced-Insights.PNG)


## 🛠️ Technical Implementation
### Tools & Technologies
- Platform: Microsoft Power BI Desktop
- Data Preparation: Power Query Editor for ETL
- Modeling: Snowflake schema with Date table via DAX
- Visual Features: Drill-through, dynamic navigation, AI visuals

### Calculated Measures
- `% Growth = DIVIDE(SUM(Sales[Revenue])-[PY Sales], [PY Sales])`
- `PY Sales = CALCULATE(SUM(Sales[Revenue]), SAMEPERIODLASTYEAR('Date'[Date]))`
- `Sintec Market Share = DIVIDE(Sales[Sintec Revenue], SUM(Sales[Revenue]), 0)`
- `Sintec Revenue = Calculate(SUM(Sales[Revenue]), Manufacturer[ManufacturerID] = 4)`
- `ZipCountry = Sales[Zip] & "," & Sales[Country]`



