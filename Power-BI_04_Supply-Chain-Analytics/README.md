# Supply Chain Analysis in Power BI
## Make vs Buy Decision Support System

## 📊 Project Overview
This Power BI project delivers comprehensive supply chain analysis for Widgetmakers, Inc, focusing on strategic make-or-buy decision optimization. Through advanced data modeling, cost analysis, and dynamic scenario planning, this case study provides actionable insights to minimize procurement costs and optimize manufacturing decisions. The solution empowers supply chain analysts and procurement teams with data-driven strategies for supplier selection, volume optimization, and capital investment planning.

## 🎯 Business Objectives
**Primary Goal:** Analyze supply chain operations to optimize make-or-buy decisions, minimize total costs, and maximize cost avoidance through strategic procurement and manufacturing planning.

**Target Audience:** Supply chain analysts, procurement managers, manufacturing strategists, and executive decision-makers.

**Key Questions Addressed:**
- Which suppliers offer the lowest total cost for specific parts and volumes?
- Should we manufacture internally or purchase from external suppliers?
- What are the optimal production volumes for cost efficiency?
- How do non-recurring expenses impact total procurement costs?
- What capital investments are required for internal manufacturing?
- Which scenarios provide the greatest cost avoidance opportunities?

## 📝 Supply Chain Terminology Reference
- **Make vs Buy:** Decision between manufacturing in-house or purchasing from external suppliers
- **Unit Cost:** Marginal cost of purchasing/producing one additional unit
- **Extended Cost:** Total cost for products only (Unit Cost × Quantity)
- **Non-Recurring Expenses:** One-time costs required to enable production (tooling, setup, engineering)
- **Full Cost:** Total amount including extended cost and non-recurring expenses
- **Cost Avoidance:** Savings achieved by selecting the optimal make vs buy option
- **Incremental Costs:** New costs introduced by the decision (excludes sunk costs)
- **Overhead Rate:** Cost allocated to production not directly tied to manufacturing

## 📋 Dataset Information
### Data Structure

### Fact and Dimensional Tbales:

![Fact and Dimensional Tables](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_04_Supply-Chain-Analytics/images/tables.PNG)

### Schema: 
**Snowflake** schema with Quotes as the central fact table connected to Internal_Mfg_Resource_Estimates, Product_Dimension, and Yield_Rate dimension tables.

![Data Model](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_04_Supply-Chain-Analytics/images/data_model.PNG)

## 🧮 Key Performance Indicators (KPIs)
| Metric | Description |
|--------|-------------|
| Full Cost | Total procurement cost including extended and non-recurring expenses |
| Extended Cost | Unit cost multiplied by volume (excludes setup costs) |
| Non-recurring Expenses | One-time production setup costs |
| Cost Avoidance | Savings from optimal make vs buy decision |
| Capital Investment Required | Equipment investment needed for internal manufacturing |
| Additional Unit Capacity Required | Extra production capacity needed beyond existing |
| Make vs Buy Recommendation | Optimal decision based on total cost analysis |

## 📈 Key Insights Discovered
### Cost Optimization Analysis
- Widgetmakers, Inc consistently offers the lowest cost solutions across multiple part numbers
- Volume scaling significantly impacts unit costs and supplier competitiveness
- Non-recurring expenses vary substantially between suppliers, affecting total cost calculations

### Make vs Buy Decisions
- Internal manufacturing (Make) is optimal for high-volume, long-term production scenarios
- External procurement (Buy) is preferred for low-volume or specialized components
- Capital investment requirements significantly influence make vs buy feasibility

### Supplier Performance
- Four primary suppliers evaluated: Widgetmakers Inc, Ringo Nova, UCell We Make, and Expellio
- Supplier cost structures vary significantly across different volume ranges
- Widgetmakers Inc demonstrates consistent cost leadership across evaluated scenarios

## 📊 Dashboard Components
The Power BI solution includes three comprehensive dashboard pages:

### Supplier Selection Dashboard
**Focus:** Buy option analysis at fixed volumes
- Lowest cost supplier identification for specific part numbers
- Fixed volume cost breakdown analysis
- Extended cost vs non-recurring expenses comparison
- Supplier performance comparison across volume ranges
- Cost structure visualization by supplier

![Supplier Selection](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_04_Supply-Chain-Analytics/images/dashboard_01_Supplier_Selection.PNG)

### Scenario Analysis Dashboard
**Focus:** Dynamic volume planning and cost optimization
- Variable volume scenario planning with interactive controls
- Buy scenario full cost analysis across volume ranges
- Supplier cost curves and break-even analysis
- Dynamic cost modeling with scenario volume parameters
- Total cost optimization across different volume scenarios

![Scenario Analysis](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_04_Supply-Chain-Analytics/images/dashboard_02_Scenario_Analysis.PNG)

### Make versus Buy Dashboard
**Focus:** Comprehensive decision support system
- Make vs Buy recommendations based on total cost analysis
- Capital investment requirements for internal manufacturing
- Additional unit capacity calculations
- Cost avoidance quantification
- Manufacturing resource utilization analysis
- Equipment investment impact on total costs

![Make versus Buy](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_04_Supply-Chain-Analytics/images/dashboard_03_Make_Buy.PNG)

## 🛠️ Technical Implementation
### Tools & Technologies
- **Platform:** Microsoft Power BI Desktop
- **Data Preparation:** Power Query Editor for ETL processes
- **Modeling:** Snowflake schema with advanced calculated measures
- **Analytics:** Dynamic scenario planning with what-if parameters
- **Features:** Interactive volume sliders, cost optimization algorithms

### Key Calculated Measures
```dax
Extended Cost = Quotes[Unit_Cost] * Quotes[Volume]

Full Cost = Quotes[Extended Cost] + Quotes[Non_recurring_expenses]

Make Scenario Full Cost = MINX(
    Internal_Mfg_Resource_Estimates,
    [Capital Investment Required (Make)] + 
    Internal_Mfg_Resource_Estimates[Cost_per_Unit] * 'Scenario Volume'[Scenario Volume Value])

Buy Scenario Full Cost = MINX(
    FILTER(Quotes, Quotes[Volume] <= 'Scenario Volume'[Scenario Volume Value]),
    [Scenario_Volume_Value]*Quotes[Unit_Cost]/Quotes[Yield_Rate]+Quotes[Non_recurring_expenses])

Cost Avoidance = ABS([Make Scenario Full Cost] - [Buy Scenario Full Cost])

Make vs Buy = IF(
    ISBLANK([Make Scenario Full Cost]),
    BLANK(),
    IF([Make Scenario Full Cost] >= [Buy Scenario Full Cost], "Buy", "Make"))

Additional Unit Capacity Required = MINX(
    Internal_Mfg_Resource_Estimates,
    MAX('Scenario_Volume'[Scenario_Volume_Value] - Internal_Mfg_Resource_Estimates[Existing_Capacity], 0))

Capital Investment Required (Make) = MINX(
    Internal_Mfg_Resource_Estimates,
    ROUNDUP([Additional_Unit_Capacity_Required]/MIN(Internal_Mfg_Resource_Estimates[Unit_Capacity]),0) * 
    Internal_Mfg_Resource_Estimates[Machine_Fixed_Cost])
```

## 🎯 Business Value & Recommendations
### Cost Optimization Strategies
- **Volume Optimization:** Leverage economies of scale for high-volume requirements
- **Supplier Diversification:** Maintain multiple supplier relationships for risk mitigation
- **Capacity Planning:** Align internal manufacturing capacity with demand forecasts

### Strategic Decision Making
- **Make vs Buy Framework:** Implement systematic decision criteria based on volume thresholds
- **Capital Investment Planning:** Evaluate long-term ROI of manufacturing equipment investments
- **Supplier Relationship Management:** Develop strategic partnerships with lowest-cost providers

### Operational Improvements
- **Scenario Planning:** Use dynamic modeling for strategic planning and budgeting
- **Cost Transparency:** Implement full cost visibility across procurement decisions
- **Risk Management:** Consider supplier reliability and capacity constraints in decision making

## 🚀 Future Enhancements
- Integration with ERP systems for real-time cost data
- Advanced predictive analytics for demand forecasting
- Supplier risk assessment and scoring models
- Automated alerting for cost threshold breaches
- Integration with procurement systems for automated decision support
- Multi-currency support for global supplier analysis
- Lead time optimization and delivery performance metrics
- Quality metrics integration for comprehensive supplier evaluation

## 📈 Expected Business Impact
- **Cost Reduction:** 15-25% reduction in procurement costs through optimized decision making
- **Process Efficiency:** 50% reduction in analysis time through automated scenario planning
- **Strategic Alignment:** Improved alignment between procurement and manufacturing strategies
- **Risk Mitigation:** Enhanced supplier diversification and capacity planning
- **Decision Quality:** Data-driven decisions replacing subjective procurement choices
