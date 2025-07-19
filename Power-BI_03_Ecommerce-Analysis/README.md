# Ecommerce Analysis in Power BI
## Pet Supply Store Performance & Optimization Dashboard

## 📊 Project Overview
This Power BI project delivers comprehensive ecommerce performance analysis for Whiskique, a fictitious online pet supply store. Through advanced data modeling, market basket analysis, and interactive visualizations, this case study provides actionable insights to drive sales growth and reduce operational costs. The solution empowers business stakeholders with data-driven strategies for cross-selling, upselling, and shipping cost optimization.


## 🎯 Business Objectives
**Primary Goal:** Analyze ecommerce operations to maximize customer reach, increase sales revenue, and minimize operating costs through data-driven insights.

**Target Audience:** Ecommerce managers, marketing strategists, operations teams, and executive decision-makers.

**Key Questions Addressed:**
- Which products and categories drive the highest sales and profit margins?
- What shipping cost optimization strategies can reduce operational expenses?
- Which products are frequently purchased together (market basket analysis)?
- How can cross-selling and upselling opportunities be identified and leveraged?
- What regional performance patterns exist across different states?
- How can shipping consolidation strategies impact overall profitability?


## 📝 Ecommerce Terminology Reference
- **COGS:** Cost of Goods Sold
- **Landed Cost:** Freight and shipping to warehouse
- **Fulfillment Fees:** Warehouse operations cost
- **Market Basket Analysis:** Products frequently bought together
- **Correlation Coefficient:** Statistical measure of product affinity
- **Cross-sell:** Promote relevant products at point of purchase
- **Upsell:** Promote higher-priced or higher-quantity alternatives


## 📋 Dataset Information
### Data Structure

### Fact and Dimensional Tables:

![Fact and Dimensional Tables](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_03_Ecommerce-Analysis/images/tables.PNG)

### Schema: 
**Snowflake** schema with Sales as the central fact table connected to Product, Customer, and State Mapping dimension tables.

![Data Model](https://github.com/alisaghilutfi/PowerBI-Projects/blob/main/Power-BI_03_Ecommerce-Analysis/images/data_model.PNG)

## 🧮 Key Performance Indicators (KPIs)
| Metric | Value/Description |
|--------|------------------|
| Total Sales | $1.55M |
| Total Profit (Baseline) | $427.34K |
| Profit Percentage | 27.50% |
| Shipping Cost (Baseline) | $385.15K |
| Customer LTV (Average) | Calculated per customer lifetime value |
| Shipping Cost Reduction | Variable based on quantity optimization |
| Market Basket Correlations | Product affinity analysis |

## 📈 Key Insights Discovered
### Revenue & Profitability
- Total revenue of $1.55M with a healthy 27.50% profit margin
- Shipping costs represent a significant operational expense at $385.15K
- Opportunities exist for profit optimization through strategic shipping cost management

### Shipping Cost Optimization
- Quantity-based shipping discounts can reduce costs significantly
- Shipment consolidation strategies show measurable impact on bottom line
- Regional shipping patterns reveal optimization opportunities by state/region

### Market Basket Analysis
- Product correlation analysis reveals cross-selling opportunities
- Frequently purchased together items identified for targeted promotions
- Customer purchase behavior patterns support upselling strategies

## 📊 Dashboard Components
The Power BI solution includes three comprehensive dashboard pages:

### Executive Summary
**Focus:** High-level KPIs and performance overview
- Total Sales by Description and Category
- Profit % by Category
- Total Sales by State
- Key performance metrics dashboard

### Shipping Metrics
**Focus:** Cost reduction strategies and optimization
- Impact of Shipped Quantity on Shipping Cost by Product
- Impact of Shipped Quantity on Shipping Cost (overall)
- Average Quantity by Category
- Shipping Cost by State/Region
- What-if analysis for shipping cost scenarios
- Baseline vs. optimized shipping cost comparisons

### Market Basket Analysis
**Focus:** Growth opportunities and product relationships
- Product correlation matrix
- Cross-selling opportunity identification
- Total Sales and Profit % by Description
- Purchased Count analysis by product
- Product affinity insights for marketing strategies

## 🛠️ Technical Implementation
### Tools & Technologies
- **Platform:** Microsoft Power BI Desktop
- **Data Preparation:** Power Query Editor for ETL processes
- **Modeling:** Snowflake schema with calculated measures
- **Analytics:** Market basket analysis with correlation coefficients
- **Features:** What-if parameters, dynamic shipping cost modeling

### Key Calculated Measures
```dax
Customer LTV (avg) = SUM(Sales[Sales]) / [Number of Customers]

Profit % = SUM(Sales[Profit (Baseline)]) / SUM(Sales[Sales])

Profit (Baseline) = Sales[Sales] - Sales[COGS] - [Shipping (Baseline)]

Shipping (Baseline) = SUMX(Sales,
                           IF(Sales[Quantity]=1,
                              Sales[Shipping Cost],
                              Sales[Shipping Cost]+(((Sales[Quantity])-1)*(Sales[Shipping Cost]*0.7))))

Blended Shipping Cost Factor = IF('What-if quantity'[What-if quantity Value]<=1, 1,
                                  IF('What-if quantity'[What-if quantity Value]<=2, 0.8,
                                     IF('What-if quantity'[What-if quantity Value]<=4, 0.6,
                                        IF('What-if quantity'[What-if quantity Value]<=7, 0.5,
                                           IF('What-if quantity'[What-if quantity Value]<=9,0.4,0.3)))))

Shipping (What-if) = SUMX(Sales,
                          IF(Sales[Quantity]=1,
                             Sales[Shipping Cost],
                             Sales[Shipping Cost]+(((Sales[Quantity])-1)*(Sales[Shipping Cost]*[Blended Shipping Cost Factor]))))

Shipping (Difference) = [Shipping (Baseline)] - [Shipping (What-if)]
```

## 🎯 Business Value & Recommendations
### Cost Optimization Strategies
- **Shipping Consolidation:** Implement quantity-based shipping discounts
- **Regional Analysis:** Optimize shipping routes and partnerships by state
- **Package Optimization:** Consider dimensions and weight for cost reduction

### Revenue Growth Opportunities
- **Cross-selling:** Leverage market basket analysis for product bundling
- **Upselling:** Promote higher-value alternatives based on purchase patterns
- **Customer Segmentation:** Target high-LTV customers with personalized offers

### Operational Improvements
- **Inventory Management:** Align stock levels with demand patterns
- **Marketing Strategy:** Focus on high-profit categories and regions
- **Customer Experience:** Optimize shipping options for customer satisfaction

## 🚀 Future Enhancements
- Real-time data integration for live dashboard updates
- Advanced predictive analytics for demand forecasting
- Customer segmentation analysis with RFM modeling
- Automated alerting for performance threshold monitoring
- Integration with inventory management systems
