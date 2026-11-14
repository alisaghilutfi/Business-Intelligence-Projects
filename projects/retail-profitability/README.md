# Retail Profitability

Power BI report answering: **What drives profitability across customer segments, regions,
and product categories in US retail?**

## KPIs

- Profit Margin % (primary)
- Profit by Segment / Region / Category / Sub-Category
- Discount impact on margin (correlational)
- Sales and Profit YoY (2018–2021)
- Top/bottom 10 products by profit margin

## Data

Pavan Lalwani US Superstore dataset — 47 US state CSV files, 9,887 order lines, 2018-2021.
Star schema: 1 fact table + 5 dimensions. See [CONTEXT.md](CONTEXT.md) for full data
dictionary, quality issues resolved, and analytical limits.

## Structure

```
retail-profitability/
  scripts/                        Python ingestion scripts
    01_union_and_clean.py         Unions CSVs, cleans, splits into star schema
  rpt_RetailProfitability/        PBIP report (Power BI Desktop)
  CLAUDE.md                       Project rules and analyst mindset framing
  CONTEXT.md                      Data dictionary, ERD, quality notes
  decisions.md                    Dated design decisions
  state.md                        Current status and next actions
  _data/                          Raw source CSVs (gitignored)
  _output/                        Processed dim/fact CSVs (gitignored)
```

## Running the ingestion script

```powershell
cd projects\retail-profitability
python -I scripts\01_union_and_clean.py
```

Expects source CSVs in `_data\`. Writes 6 CSV files to `_output\`.
