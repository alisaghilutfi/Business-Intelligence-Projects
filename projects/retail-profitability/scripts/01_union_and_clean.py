"""
Retail Profitability — ingestion and star-schema split.
Input:  projects/retail-profitability/_data/*.csv  (cp1252, one file per US state)
Output: projects/retail-profitability/_output/     (6 CSV files, UTF-8)
"""

import pathlib
import sys
import pandas as pd

ROOT = pathlib.Path(__file__).resolve().parents[1]
DATA_DIR = ROOT / "_data"
OUT_DIR = ROOT / "_output"
OUT_DIR.mkdir(exist_ok=True)

SKIP = {"delaware.csv", "new jersey - copy.csv"}

# ---------------------------------------------------------------------------
# 1. Load and union
# ---------------------------------------------------------------------------
frames = []
skipped = []

for csv_path in sorted(DATA_DIR.glob("*.csv")):
    if csv_path.name.lower() in SKIP:
        skipped.append(csv_path.name)
        continue
    df = pd.read_csv(csv_path, encoding="cp1252", dtype=str)
    df["source_state"] = csv_path.stem
    frames.append(df)

print(f"Skipped ({len(skipped)}): {skipped}")
print(f"Loaded {len(frames)} files")

raw = pd.concat(frames, ignore_index=True)
print(f"Raw rows after union: {len(raw):,}")

# ---------------------------------------------------------------------------
# 2. Clean
# ---------------------------------------------------------------------------
drop_cols = [c for c in ["Country/Region", "Net Profit", "source_state", "Row ID"]
             if c in raw.columns]
raw.drop(columns=drop_cols, inplace=True)

# Postal Code -> zero-padded 5-digit string
raw["Postal Code"] = (
    raw["Postal Code"]
    .fillna("0")
    .astype(str)
    .str.strip()
    .str.replace(r"\.0$", "", regex=True)
    .str.zfill(5)
)
raw.loc[raw["Postal Code"] == "00000", "Postal Code"] = "00000"  # explicit sentinel

raw["Discount"] = pd.to_numeric(raw["Discount"], errors="coerce").astype("float64")
raw["Quantity"] = pd.to_numeric(raw["Quantity"], errors="coerce").astype("Int64")
raw["Sales"] = pd.to_numeric(raw["Sales"], errors="coerce").astype("float64")
raw["Profit"] = pd.to_numeric(raw["Profit"], errors="coerce").astype("float64")
raw["Order Date"] = pd.to_datetime(raw["Order Date"], infer_datetime_format=True)
raw["Ship Date"] = pd.to_datetime(raw["Ship Date"], infer_datetime_format=True)

# ---------------------------------------------------------------------------
# 3. Remove exact duplicates; log split-shipment rows
# ---------------------------------------------------------------------------
# Exact duplicates (all columns identical): drop, keep first, log identifiers.
exact_dupes = raw.duplicated(keep="first")
if exact_dupes.any():
    dropped = raw[exact_dupes][["Order ID", "Product ID", "Sales", "Quantity"]].copy()
    print(f"Dropped {len(dropped)} exact duplicate row(s):")
    print(dropped.to_string(index=False))
    raw = raw[~exact_dupes].reset_index(drop=True)

# Split shipments: same (Order ID, Product ID) but different quantities/amounts.
# These are legitimate separate line items. Log them as a data quality observation.
split_mask = raw.duplicated(subset=["Order ID", "Product ID"], keep=False)
if split_mask.any():
    n_pairs = raw[split_mask].groupby(["Order ID", "Product ID"]).ngroups
    print(f"Split-shipment observation: {split_mask.sum()} rows across {n_pairs} "
          f"(Order ID, Product ID) pairs — retained as distinct line items.")

# ---------------------------------------------------------------------------
# 4. Surrogate keys
# ---------------------------------------------------------------------------
raw["LineKey"] = range(1, len(raw) + 1)

raw["CustomerKey"] = raw["Customer ID"].rank(method="dense").astype(int)
raw["ProductKey"] = raw["Product ID"].rank(method="dense").astype(int)
raw["GeoKey"] = raw["Postal Code"].rank(method="dense").astype(int)
raw["ShipModeKey"] = raw["Ship Mode"].rank(method="dense").astype(int)
raw["OrderDateKey"] = raw["Order Date"].dt.strftime("%Y%m%d").astype(int)
raw["ShipDateKey"] = raw["Ship Date"].dt.strftime("%Y%m%d").astype(int)

# ---------------------------------------------------------------------------
# 5. Split into output tables
# ---------------------------------------------------------------------------

fct = raw[[
    "LineKey", "Order ID", "CustomerKey", "ProductKey", "GeoKey",
    "OrderDateKey", "ShipDateKey", "ShipModeKey",
    "Sales", "Quantity", "Discount", "Profit"
]].rename(columns={"Order ID": "OrderID"})

dim_customer = (
    raw[["CustomerKey", "Customer ID", "Customer Name", "Segment"]]
    .drop_duplicates(subset=["Customer ID"])
    .rename(columns={"Customer ID": "CustomerID", "Customer Name": "CustomerName"})
    .sort_values("CustomerKey")
    .reset_index(drop=True)
)

dim_product = (
    raw[["ProductKey", "Product ID", "Product Name", "Category", "Sub-Category"]]
    .drop_duplicates(subset=["Product ID"])
    .rename(columns={
        "Product ID": "ProductID",
        "Product Name": "ProductName",
        "Sub-Category": "SubCategory",
    })
    .sort_values("ProductKey")
    .reset_index(drop=True)
)

dim_geography = (
    raw[["GeoKey", "Postal Code", "City", "State", "Region"]]
    .drop_duplicates(subset=["Postal Code"])
    .rename(columns={"Postal Code": "PostalCode"})
    .sort_values("GeoKey")
    .reset_index(drop=True)
)

# Date spine: min(Order Date) to max(Ship Date)
min_date = raw["Order Date"].min()
max_date = raw["Ship Date"].max()
date_range = pd.date_range(start=min_date, end=max_date, freq="D")

dim_date = pd.DataFrame({"Date": date_range})
dim_date["DateKey"] = dim_date["Date"].dt.strftime("%Y%m%d").astype(int)
dim_date["Year"] = dim_date["Date"].dt.year
dim_date["Quarter"] = dim_date["Date"].dt.quarter
dim_date["MonthNum"] = dim_date["Date"].dt.month
dim_date["MonthName"] = dim_date["Date"].dt.strftime("%B")
dim_date["WeekNum"] = dim_date["Date"].dt.isocalendar().week.astype(int)
dim_date["DayOfWeek"] = dim_date["Date"].dt.dayofweek + 1  # Mon=1
dim_date["IsWeekend"] = dim_date["DayOfWeek"].isin([6, 7])
dim_date = dim_date[[
    "DateKey", "Date", "Year", "Quarter", "MonthNum", "MonthName",
    "WeekNum", "DayOfWeek", "IsWeekend"
]]

dim_shipmode = (
    raw[["ShipModeKey", "Ship Mode"]]
    .rename(columns={"Ship Mode": "ShipMode"})
    .drop_duplicates()
    .sort_values("ShipModeKey")
    .reset_index(drop=True)
)

# ---------------------------------------------------------------------------
# 6. Write output
# ---------------------------------------------------------------------------
outputs = {
    "fct_OrderLines.csv": fct,
    "dim_Customer.csv": dim_customer,
    "dim_Product.csv": dim_product,
    "dim_Geography.csv": dim_geography,
    "dim_Date.csv": dim_date,
    "dim_ShipMode.csv": dim_shipmode,
}

print("\n--- Output row counts ---")
for fname, df in outputs.items():
    path = OUT_DIR / fname
    df.to_csv(path, index=False, encoding="utf-8")
    print(f"  {fname:<30} {len(df):>7,} rows")

# ---------------------------------------------------------------------------
# 7. Data quality warnings
# ---------------------------------------------------------------------------
print("\n--- Data quality warnings ---")
warnings = 0
for col in ["Sales", "Quantity", "Discount", "Profit", "Order Date", "Ship Date"]:
    n = fct[col].isna().sum() if col in fct.columns else raw[col].isna().sum()
    if n > 0:
        print(f"  WARNING: {col} has {n} null(s) in fct_OrderLines")
        warnings += 1

zero_postal = (dim_geography["PostalCode"] == "00000").sum()
if zero_postal:
    print(f"  WARNING: {zero_postal} row(s) in dim_Geography with PostalCode sentinel '00000'")
    warnings += 1

if dim_shipmode.shape[0] != 4:
    print(f"  WARNING: dim_ShipMode has {dim_shipmode.shape[0]} rows (expected 4)")
    warnings += 1

if warnings == 0:
    print("  None.")

print("\nDone.")
