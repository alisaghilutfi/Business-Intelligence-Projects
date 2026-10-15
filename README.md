# Business Intelligence Projects

Power BI, DAX, and data modeling projects by [Ali Saghi](https://www.linkedin.com/in/ali-saghi-fabric/), DP-600 certified Microsoft Fabric Analytics Engineer and founder of [Lotusoftware](https://lotusoftware.hashnode.dev) — a data analytics consultancy in Vantaa, Finland.

Each project is framed through the **Analyst Mindset** (Jon Christiansen): every README states the business decision the analysis supports, names the outcome variable and question type, documents known data limitations, and ends with honest next-improvement steps. The goal is not to demonstrate that Power BI was used, but to demonstrate that the right question was asked and answered with appropriate rigour.

For end-to-end Microsoft Fabric projects (medallion architecture, PySpark, DirectLake semantic models, Data Agents), see the companion repo: [Fabric-Analytics-Projects](https://github.com/alisaghilutfi/Fabric-Analytics-Projects).

---

## Projects

### PowerBI_Competitor_Sales_Analysis — Competitive Sales Intelligence

**Type:** Business Intelligence · Competitive Analysis  
**Stack:** Power BI · Power Query · Snowflake schema · DAX · AI visuals (Decomposition Tree, Key Influencers)  
**Data:** ~1.8M sales transactions · 6 countries · 14 manufacturers · 2014–2021

Where should Sintec focus product, geography, and pricing strategy to defend and grow market share? Revenue and share are compared across 13 competitors by country and segment, with AI visuals surfacing the drivers a static chart would miss. Sintec leads the US market (38.22% share) but trails globally (21.15%), with Artisans dominating Germany at >50% — pointing to distinct regional strategies rather than a single global play.

---

### PowerBI_Ecommerce_Analysis — E-Commerce Performance & Cost Optimisation

**Type:** Business Intelligence · Operations Analytics  
**Stack:** Power BI · Power Query · Snowflake schema · DAX · What-if parameters · Market basket analysis  
**Data:** Whiskique pet supply store · transaction-level sales and shipping data

Where can Whiskique reduce shipping costs without sacrificing revenue, and which product relationships support a cross-sell programme? Shipping costs ($385K baseline) are modelled against quantity-consolidation scenarios using What-if parameters, and a correlation-based market basket analysis identifies product pairs with the highest affinity scores for targeted promotion.

---

### PowerBI_Supply_Chain_Analysis — Make-or-Buy Decision Support

**Type:** Business Intelligence · Operations Analytics · Scenario Planning  
**Stack:** Power BI · Power Query · Snowflake schema · DAX · What-if parameters  
**Data:** Widgetmakers Inc · supplier quotes · internal manufacturing cost estimates

Should Widgetmakers manufacture a component internally or buy from an external supplier — and at what volume does the answer change? Full cost (extended + non-recurring) is modelled across four suppliers and a range of production volumes, with automated Make vs Buy recommendations and capital investment requirements calculated per scenario.

---

### PowerBI_Finance_Analysis — Financial Transactions Dashboard

**Type:** Business Intelligence · Finance  
**Stack:** Power BI · Power Query · DAX · Field parameters · Custom tooltips · Conditional formatting  
**Data:** FinSight financial transactions · multi-segment, multi-region

How are transaction volumes, fees, and taxes trending across business segments and geographies, and where are the operational exceptions that warrant investigation? An F-pattern Executive Summary with field-parameter metric switching covers the macro view; a drill-through transaction ledger with conditional risk formatting handles the auditing use case; a custom monthly tooltip surfaces state-level density on hover.

---

### PowerBI_Healthcare_Analysis — Hospital Efficiency Benchmarking

**Type:** Business Intelligence · Healthcare Analytics  
**Stack:** Power BI · Power Query · DAX · Benchmarking  
**Data:** New York State hospital discharge data (2016) · 26,286 elective hip replacement cases · 151 hospitals

Which New York hospitals are statistical outliers in length of stay and cost for elective hip replacement, and what patient and facility factors explain the variance? Illness severity and mortality risk are the dominant drivers; NYC hospitals show structurally higher costs independent of case mix; surgical programme size shows a weak efficiency correlation that warrants further investigation before being used as a policy lever.

---

## Skills Demonstrated

| Skill | Projects |
|---|---|
| DAX — time intelligence, market share, scenario measures | All Power BI projects |
| Power Query ETL — multi-source, composite keys, data cleaning | All Power BI projects |
| What-if parameters and scenario modelling | Ecommerce, Supply Chain |
| Market basket analysis (correlation coefficients) | Ecommerce |
| AI visuals (Decomposition Tree, Key Influencers) | Competitor Sales |
| Snowflake schema design | Competitor Sales, Ecommerce, Supply Chain |
| Benchmarking and outlier detection | Healthcare, Finance |
| Field parameters and dynamic titles | Finance |

---

## About Lotusoftware

Lotusoftware is a data analytics consultancy founded by Ali Saghi in Vantaa, Finland, specialising in Microsoft Fabric, Power BI, and agentic analytics systems.

- Blog: [lotusoftware.hashnode.dev](https://lotusoftware.hashnode.dev)
- LinkedIn: [ali-saghi-fabric](https://www.linkedin.com/in/ali-saghi-fabric/)
- GitHub: [alisaghilutfi](https://github.com/alisaghilutfi)
- Fabric projects: [Fabric-Analytics-Projects](https://github.com/alisaghilutfi/Fabric-Analytics-Projects)
