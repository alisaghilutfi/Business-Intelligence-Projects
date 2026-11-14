# Decisions

| Date | Decision | Rationale | Alternatives considered |
|---|---|---|---|
| 2026-11-14 | Star schema: 1 fact + 5 dims | Supports all 5 KPI queries without row-by-row aggregation complexity | Single flat table (rejected: poor model performance, no reusable dims) |
| 2026-11-14 | Surrogate keys as dense-rank integers | Compact, human-readable, no GUID overhead for a local PBIP | GUIDs, natural keys as FK (rejected: verbose, slower relationships) |
| 2026-11-14 | Skip Delaware.csv and NJ-Copy.csv | Delaware is empty; NJ-Copy is an exact duplicate of New Jersey.csv | Include with flag column (rejected: adds noise, no analytical value) |
| 2026-11-14 | Postal Code as 5-digit zero-padded string | Preserves leading zeros (e.g. 01234); nulls -> "00000" sentinel | Integer (rejected: drops leading zeros) |
| 2026-11-14 | Inactive relationship: fct[ShipDateKey] -> dim_Date[DateKey] | Allows USERELATIONSHIP for ship-date analysis without duplicating dim_Date | Separate dim_ShipDate table (rejected: redundant 730-row duplicate) |
| 2026-11-14 | Discount impact analysis is correlational only | Profit is pre-computed; no cost decomposition available to isolate margin erosion vs volume lift | N/A -- analytical constraint, not a design choice |
| 2026-11-14 | Drop (Order ID, Product ID) uniqueness assert; use LineKey as grain key | Source contains split shipments: same order+product across two rows with different quantities and proportional amounts (7 pairs, 14 rows). These are legitimate line items, not duplicates. Natural key (Order ID, Product ID) is insufficient as a uniqueness constraint. | Keep assert and merge split rows (rejected: would misrepresent separate shipment events) |
| 2026-11-14 | Drop 1 exact duplicate row: US-2018-150119 / FUR-CH-10002965 (Ohio, Sales=281.372, Qty=2) | All fields identical -- data entry duplicate confirmed. Removal is reproducible: script drops on exact-row match keep=first. | Flag with a column (rejected: adds noise, row has zero analytical value) |
