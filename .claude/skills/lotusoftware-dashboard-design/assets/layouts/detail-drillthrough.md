# Layout Pattern: Detail Drillthrough

**Purpose:** Destination page for drillthrough navigation from a summary page. Shows
granular detail for a selected dimension member (e.g. a specific product, region,
customer, or employee). Answers "tell me everything about this one thing."

**Canvas:** 1280 × 720 px

---

## Zone Map

```
┌─────────────────────────────────────────────────────────────────┐
│  HEADER BAR  (← Back button · context label · period slicer)   │
│                                                H: 60 px          │
├──────────┬──────────┬──────────┬───────────────────────────────┤
│  KPI 1   │  KPI 2   │  KPI 3   │                               │
│          │          │          │   TREND CHART                  │
│  H:120px │  H:120px │  H:120px │   (selected member over time) │
├──────────┴──────────┴──────────┤                    H: ~280px  │
│                                │                               │
│   DETAIL TABLE                 ├───────────────────────────────┤
│   (row-level breakdown)        │   BREAKDOWN CHART             │
│                                │   (sub-dimension split)       │
│                    H: ~280px   │                    H: ~220px  │
└────────────────────────────────┴───────────────────────────────┘
```

**Column split:** left 55% / right 45%.
**Margins:** 16 px. **Gutters:** 8 px.

---

## Visual Specifications

### Header Bar
- Back button: `actionButton`, Segoe UI 11 pt, teal `#197278` icon/text, no border/shadow
- Context label: textbox showing the drillthrough field value (e.g. "Region: North"), Segoe UI Semibold 14 pt, `#242424`
- Period slicer: dropdown, right-aligned

### KPI Cards (3 max — new Card visual `cardVisual`)
- Same spec as KPI Overview layout
- Show the 3 most important measures for the drilled-to entity
- Accent bar coloured via conditional formatting where applicable

### Trend Chart
- Type: `lineChart`
- Shows the primary measure for the selected member over time
- Single series → teal `#197278`
- X-axis: Month or Week; no axis titles

### Detail Table (`tableEx`)
- Shows row-level data for the selected dimension member
- Columns: key dimensions + primary measures
- Header: `#F3F2F1` background, Segoe UI Semibold 10 pt
- No vertical gridlines; horizontal only `#EDEBE9`
- Totals row shown

### Breakdown Chart
- Type: `clusteredBarChart`
- Splits the primary measure by a sub-dimension (e.g. product category, cost element)
- Single series → teal `#197278`

---

## Drillthrough Setup Requirements

- The page must have a **drillthrough filter** set to the dimension field users drill from
- The **Back button** must use the built-in drillthrough back action (not a bookmark)
- The context label textbox should use a measure like:
  ```dax
  Selected Context = "Selected: " & SELECTEDVALUE('Dimension'[Field], "All")
  ```
- The page should be **hidden** from the page navigation tab strip

---

## Model Requirements

| Requirement | Why needed |
|---|---|
| Primary value measure | KPI cards + trend chart |
| 2 additional summary measures | Remaining KPI cards |
| Date dimension with Month/Week | Trend chart X-axis |
| A sub-dimension for breakdown | Breakdown chart |
| `Selected Context` measure (DAX string) | Context label in header |
| KPI status measure (1 / 0 / −1) | Conditional accent bar colour |

---

## Do's and Don'ts

- **Do** mark this page as hidden — it should only be reached via drillthrough
- **Do** keep the back button prominent — top-left, always visible
- **Do** show the drillthrough context in the header so users know what they're looking at
- **Don't** add a full slicer panel — a single date slicer is sufficient
- **Don't** use cross-filtering between the table and charts — it creates confusion on a detail page
- **Don't** repeat the full KPI overview — 3 headline metrics are enough
