# Layout Pattern: KPI Overview

**Purpose:** Executive or management summary page. Delivers 3–6 headline KPIs at a
glance, supported by one or two trend/breakdown visuals. Answers "how are we doing
overall?"

**Canvas:** 1280 × 720 px

---

## Zone Map

```
┌─────────────────────────────────────────────────────────────────┐
│  HEADER BAR  (logo · page title · last-refresh date)   H: 60px  │
├──────────┬──────────┬──────────┬──────────┬──────────┬──────────┤
│  KPI 1   │  KPI 2   │  KPI 3   │  KPI 4   │  KPI 5   │  KPI 6  │
│          │          │          │          │          │          │
│          H: 120px   │          │          │          │          │
├──────────┴──────────┴──────────┴──────────┴──────────┴──────────┤
│                                                                   │
│   PRIMARY CHART (trend / mix breakdown)          H: ~460px       │
│                                                                   │
├───────────────────────────────────┬───────────────────────────────┤
│  SLICER ROW  (date / region / etc.)                H: 40px       │
└───────────────────────────────────┴───────────────────────────────┘
```

**Margins:** 16 px page gutter all sides.
**Gutter between visuals:** 8 px.

---

## Visual Specifications

### Header Bar
- Shape: full-width rectangle, fill `#FFFFFF`, no border, no shadow
- Logo: image visual, no border/shadow/header
- Page title: textbox, Segoe UI Semibold 14 pt, `#242424`
- Last refresh: textbox or card, Segoe UI 10 pt, `#616161`

### KPI Cards (new Card visual — `cardVisual`)
- **6 cards max**, equal width, single row
- Value: Segoe UI Semibold 28 pt, `#242424`
- Label: below value, Segoe UI 11 pt, `#616161`
- Accent bar: teal `#197278`, 3 px, left edge
- Border: 1 px, radius 8 px, `#E1DFDD`
- Drop shadow: on (theme default)
- Comparison reference label (if used): 10 pt, `#616161`

### Primary Chart
- Preferred types: **line chart** (trend over time) or **clustered bar/column** (category breakdown)
- No axis titles
- Value axis gridlines: `#EDEBE9`
- Legend: bottom, no title
- Single series → teal `#197278`; multiple series → use data colour order

### Slicer Row
- Dropdown slicers, no container border/shadow
- Header: Segoe UI Semibold 11 pt
- Arranged horizontally, equal spacing

---

## Model Requirements

These measures **must exist** in the semantic model before this layout can be fully built.
The theme cannot produce them — they require DAX.

| Requirement | Why needed |
|---|---|
| A primary value measure (e.g. `Revenue`, `Cost`, `Cases`) | KPI card value |
| A comparison measure (e.g. `Plan`, `Prior Year`, `Target`) | KPI reference value / goal line |
| A variance measure (e.g. `Var Plan`, `Var Plan %`) | KPI comparison delta |
| A KPI status measure (integer: 1=good, 0=neutral, -1=bad) | Conditional accent bar colour via CF |
| A "last refresh" measure or calculated column | Header refresh label |
| Date dimension with at least Year + Month hierarchy | Trend chart axis |

> **Conditional accent bar colour:** the theme sets accent bars to teal by default.
> To colour them good/bad/neutral per row, apply Conditional Formatting on the
> accent bar colour using a status measure that returns 1, 0, or −1 and maps to
> `#107C41`, `#605E5C`, `#C50F1F`.

---

## Do's and Don'ts for This Layout

- **Do** keep KPI labels short (≤ 3 words) — they sit below a 28 pt number in limited height
- **Do** show one comparison value per card (e.g. vs Plan or vs Prior Year — not both)
- **Don't** use more than 6 KPI cards — split to a second row rather than shrinking cards
- **Don't** use pie or donut charts as the primary chart — use bar/line
- **Don't** put a filter pane on this page — use the slicer row instead
