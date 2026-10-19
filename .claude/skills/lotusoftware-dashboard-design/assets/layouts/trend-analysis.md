# Layout Pattern: Trend Analysis

**Purpose:** Time-series analysis page. Shows how one or more measures evolve over time,
with period-over-period comparison and optional breakdown by dimension. Answers
"how is this changing, and what is driving it?"

**Canvas:** 1280 × 720 px

---

## Zone Map

```
┌─────────────────────────────────────────────────────────────────┐
│  HEADER BAR  (page title · date slicer · dimension slicer)      │
│                                                H: 60 px          │
├────────────────────────────────────┬────────────────────────────┤
│                                    │   SUMMARY CARD 1           │
│   PRIMARY TREND CHART              │   SUMMARY CARD 2           │
│   (line or combo)                  │   SUMMARY CARD 3           │
│                        H: ~420 px  │                            │
├────────────────────────────────────┤   H: ~420 px               │
│   SECONDARY BREAKDOWN CHART        │                            │
│   (bar — same time period)         │                            │
│                        H: ~180 px  │                            │
└────────────────────────────────────┴────────────────────────────┘
```

**Column split:** primary area 68% / summary column 32%.
**Margins:** 16 px. **Gutters:** 8 px.

---

## Visual Specifications

### Header Bar
- Page title: textbox, Segoe UI Semibold 14 pt, `#242424`
- Date slicer: dropdown, teal slider, no border/shadow
- Dimension slicer (optional): dropdown, same style

### Primary Trend Chart (line or line+column combo)
- Type: `lineChart` or `lineStackedColumnComboChart`
- X-axis: date hierarchy (Year → Quarter → Month)
- Primary Y: actual/current period measure — teal `#197278`
- Secondary Y (combo only): plan/target measure — `#12239E`
- Line stroke: 2 px solid, no markers
- No axis titles; value axis gridlines `#EDEBE9`
- Legend: bottom

### Summary Cards (new Card visual — `cardVisual`)
- 3 cards stacked in right column
- Each shows: current period value + comparison delta
- Accent bar: colour-coded via conditional formatting (good/bad/neutral)
- Value: 28 pt Semibold; label: 11 pt regular

### Secondary Breakdown Chart (bar)
- Type: `clusteredBarChart` or `barChart`
- Shows same measure split by a key dimension (e.g. region, product, category)
- Single series → teal `#197278`
- No axis titles; category axis no gridlines

---

## Model Requirements

| Requirement | Why needed |
|---|---|
| Current period measure | Primary trend line |
| Prior period / target measure | Comparison line or column |
| Period-over-period % measure (e.g. `MoM%`, `YoY%`) | Summary card delta |
| Date dimension with Year/Quarter/Month hierarchy | X-axis drill |
| At least one breakdown dimension | Secondary bar chart |
| KPI status measure (1 / 0 / −1) | Summary card conditional accent colour |

---

## Do's and Don'ts

- **Do** start the Y-axis at zero for bar charts; for line charts, let Power BI auto-scale
- **Do** use the combo chart when showing Actual vs Plan — columns for Actual, line for Plan
- **Don't** show more than 3 series on the primary trend line — add a breakdown chart instead
- **Don't** use area charts when series overlap — use lines
- **Don't** use a secondary Y-axis unless the two measures have fundamentally different scales
