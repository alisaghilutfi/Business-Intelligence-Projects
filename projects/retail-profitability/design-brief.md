# retail-profitability — Report Design Brief
ProjectPlanner | 2026-11-15
Methodology: lumio-dashboard-design (/lumio-dashboard-design)
Canvas: 1920×1080 | margin 24px | gutter 16px | 8px grid

## Measures to add (via powerbi-modeling-mcp)

| Measure | DAX | Folder |
|---|---|---|
| Profit Margin% | DIVIDE([Total Profit],[Total Sales],0) | Profit |
| Sales LY | CALCULATE([Total Sales],SAMEPERIODLASTYEAR(dim_Date[Date])) | Sales |
| Profit LY | CALCULATE([Total Profit],SAMEPERIODLASTYEAR(dim_Date[Date])) | Profit |
| Sales YoY$ | [Total Sales]-[Sales LY] | Sales |
| Sales YoY% | DIVIDE([Sales YoY$],[Sales LY],BLANK()) | Sales |
| Profit YoY$ | [Total Profit]-[Profit LY] | Profit |
| Avg Discount | AVERAGE(fct_OrderLines[Discount]) | Sales |
| Order Count | DISTINCTCOUNT(fct_OrderLines[Order ID]) | Volume |
| Orders LY | CALCULATE([Order Count],SAMEPERIODLASTYEAR(dim_Date[Date])) | Volume |
| Unprofitable Sub-Cat Count | COUNTROWS(FILTER(VALUES(dim_Product[Sub-Category]),[Total Profit]<0)) | Profit |
| Unprofitable Sub-Cat Loss | SUMX(FILTER(VALUES(dim_Product[Sub-Category]),[Total Profit]<0),[Total Profit]) | Profit |
| Sales Consumer | CALCULATE([Total Sales],dim_Customer[Segment]="Consumer") | Sales |
| Sales Corporate | CALCULATE([Total Sales],dim_Customer[Segment]="Corporate") | Sales |
| Sales Home Office | CALCULATE([Total Sales],dim_Customer[Segment]="Home Office") | Sales |

## Page 1 — Overview | Layout: Executive Z

| Zone | x | y | w | h | Component | Measures |
|---|---|---|---|---|---|---|
| Sidebar nav | 0 | 0 | 320 | 1080 | — | — |
| Title + filters | 344 | 24 | 1552 | 64 | — | Period slicer + State slicer |
| KPI 1 | 344 | 104 | 376 | 128 | 01 KPI+line | Total Sales / Sales LY |
| KPI 2 | 736 | 104 | 376 | 128 | 03 KPI vs target | Profit Margin% / 15% |
| KPI 3 | 1128 | 104 | 376 | 128 | 01 KPI+line | Total Profit / Profit LY |
| KPI 4 | 1520 | 104 | 376 | 128 | 01 KPI+line | Order Count / Orders LY |
| Main | 344 | 248 | 1024 | 440 | 08 Trend comparison | Sales / Sales LY by month |
| Context | 1384 | 248 | 512 | 440 | 02 KPI+bar | Sales by Category (3 segments) |
| Table | 344 | 704 | 1552 | 352 | 07 Table w/selectors | State, Sales, Profit, Margin%, Orders |

## Page 2 — Sales Analysis | Layout: Main + Insight Rail

| Zone | x | y | w | h | Component | Measures |
|---|---|---|---|---|---|---|
| Icon rail | 0 | 0 | 80 | 1080 | — | — |
| Title + filters | 104 | 24 | 1216 | 64 | — | Period + Category slicer |
| KPI 1 | 104 | 104 | 292 | 128 | 01 KPI+line | Total Sales / Sales LY |
| KPI 2 | 412 | 104 | 292 | 128 | 04 Variance (mini) | Sales YoY% |
| KPI 3 | 720 | 104 | 292 | 128 | 01 KPI+line | Order Count / Orders LY |
| KPI 4 | 1028 | 104 | 292 | 128 | 06 Ranking (mini) | Top category name + % |
| Main | 104 | 248 | 1216 | 400 | 04 Variance bars | Sales YoY$ by Sub-Category |
| Table | 104 | 664 | 1216 | 392 | 07 Table w/selectors | Sub-Cat, Sales, Sales LY, YoY%, Rank |
| Rail: status | 1336 | 24 | 560 | 320 | 03 KPI vs target | Category sales vs LY (3 badges) |
| Rail: ranking | 1336 | 360 | 560 | 376 | 06 Ranking | Top 10 States by Sales |
| Rail: mix | 1336 | 752 | 560 | 304 | 05 Donut+breakdown | Sales by Ship Mode |

## Page 3 — Profitability | Layout: Main + Insight Rail

| Zone | x | y | w | h | Component | Measures |
|---|---|---|---|---|---|---|
| Icon rail | 0 | 0 | 80 | 1080 | — | — |
| Title + filters | 104 | 24 | 1216 | 64 | — | Period + Category slicer |
| KPI 1 | 104 | 104 | 292 | 128 | 03 KPI vs target | Profit Margin% / 15% |
| KPI 2 | 412 | 104 | 292 | 128 | 01 KPI+line | Total Profit / Profit LY |
| KPI 3 | 720 | 104 | 292 | 128 | 04 Variance (mini) | Profit YoY$ |
| KPI 4 | 1028 | 104 | 292 | 128 | 01 KPI+line | Avg Discount / Avg Discount LY |
| Main | 104 | 248 | 1216 | 400 | 04 Variance bars | Profit Margin% by Sub-Category (zero line = breakeven; negative = red) |
| Table | 104 | 664 | 1216 | 392 | 07 Table w/selectors | Sub-Cat, Sales, Profit, Margin%, Avg Discount |
| Rail: alert | 1336 | 24 | 560 | 320 | 10 Insight card | Unprofitable Sub-Cat Count + Loss $ |
| Rail: ranking | 1336 | 360 | 560 | 376 | 06 Ranking | Bottom 10 States by Margin% |
| Rail: discount | 1336 | 752 | 560 | 304 | 05 Donut+breakdown | Avg Discount by Category |

## Page 4 — Customers | Layout: Executive Z Insight variant (no table)

| Zone | x | y | w | h | Component | Measures |
|---|---|---|---|---|---|---|
| Sidebar nav | 0 | 0 | 320 | 1080 | — | — |
| Title + filters | 344 | 24 | 1552 | 64 | — | Period slicer |
| KPI 1 | 344 | 104 | 376 | 128 | 01 KPI+line | Sales Consumer / LY |
| KPI 2 | 736 | 104 | 376 | 128 | 01 KPI+line | Sales Corporate / LY |
| KPI 3 | 1128 | 104 | 376 | 128 | 01 KPI+line | Sales Home Office / LY |
| KPI 4 | 1520 | 104 | 376 | 128 | 03 KPI vs target | Overall Margin% / 15% |
| Main (2/3) | 344 | 248 | 1024 | 808 | 08 Trend comparison | Sales by Segment by quarter, 3 series |
| Action (1/3) | 1384 | 248 | 512 | 808 | 10 Insight card | Segment Margin% comparison + narrative |

## Theme JSON (apply to report)
```json
{"name":"retail-profitability","dataColors":["#1F5BD6","#CBD0D8","#C8372D","#137A49","#E3E6EB"],"background":"#EEF0F3","foreground":"#0E1420","tableAccent":"#1F5BD6"}
```
