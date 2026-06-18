# Finance Analysis

## 📊 Core Pages & Features

**1. Executive Summary**

An high-level analytical landing page designed for C-suite decision-makers following an "F-pattern" structural layout.

`Control Panel Sidebar:` Dynamic temporal filtering (Year) and a field parameter slicer (Metric) that switches the entire page's context across key financial metrics.

`Time-Series Macro Trends:` A modern area chart showcasing monthly performance distributions.

`Categorical Breakdowns:` Slices data seamlessly across Transaction Status, Customer Segment, State, Transaction Type, and Gender.

**2. Transaction Details**

A granular, high-density data ledger optimized for auditing individual transactional operations.

`Smart Drill-Through Wiring:` Allows users to right-click data points on Page 1 and navigate straight into a contextualized ledger view of the underlying records.

`Dynamic Header Titles:` Implements custom DAX string formatting to display active user filters dynamically (e.g., Transaction Details: Retail).

`Conditional Formatting Risk Matrix:` Highlights critical business exceptions by dynamically shading Failed statuses in a soft, warning-red tint.

**3. Monthly State Tooltip**

An advanced custom pop-up window configured to optimize user experience and eliminate drill-through dead-ends.

`Contextual Data Slicing:` Hovering over the monthly trend line triggers an automatic pop-up window showing the top states ranked by active customer density for that exact month.


## 🛠️ Data Engineering & ETL Pipeline
The backend data was thoroughly scrubbed and optimized inside the Power Query engine to ensure rigorous accounting standards:

`Directional Absolute Adjustments:` Transformed negative raw transactional integers into clean, absolute values to prevent calculations from mathematically offsetting top-line revenue processing volumes.

`Data Cleansing & Normalization:` Standardized corrupt text fields and typos (e.g., transforming anomalous variants like M@bile App into clean Mobile App metrics) to ensure 100% aggregation accuracy.

`Visual Truncation Fixes:` Explicitly configured decimal precision rules to match professional banking outputs, mapping micro-fee decimals down to a precise two-decimal float.


## 📐 Key DAX Measures Included
`Total Amount` = SUM(Transactions[Amount])

`PY Amount` = CALCULATE([Total Amount], SAMEPERIODLASTYEAR('Calendar'[Date]))

`YOY Amount` = [Total Amount] - [PY Amount]

`YOY% Amount` = DIVIDE([YOY Amount], [PY Amount])

`Dynamic Month Chart Title` = 
SWITCH(
    SELECTEDVALUE('_Metrics'[_Metrics Order]),
    0, "Total Amount by Month",
    1, "Total Fees by Month",
    2, "Total Tax by Month",
    3, "Total Transactions by Month",
    "Financial Metric by Month" -- Fallback text
)


## 🚀 How to Run the Project
Clone this repository to your local machine.

Open the `.pbix file` inside `Power BI Desktop`.

If data links are broken, navigate to `Power Query Editor`, open the Source settings, and remap the file paths to your local directory workspace.

Click `Refresh` to populate the clean database structures.

