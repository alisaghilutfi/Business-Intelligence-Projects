# Lotusoftware Design System

Source: `Lotusoftware_Base_Theme.json` — `Lotusoftware Base` theme.
Canvas: **1280 × 720 px** (16:9 widescreen).

---

## Colour Palette

### Data Series (in order)
| Slot | Hex | Use |
|---|---|---|
| 1 | `#197278` | Primary teal — default first series, accent bars, KPI accent |
| 2 | `#12239E` | Deep blue |
| 3 | `#E66C37` | Orange |
| 4 | `#15C6F4` | Sky blue |
| 5 | `#744EC2` | Purple |
| 6 | `#D9B300` | Gold |
| 7 | `#6B007B` | Dark purple |
| 8 | `#605E5C` | Neutral grey |

### Semantic / Status Colours
| Token | Hex | Use |
|---|---|---|
| `good` | `#107C41` | Positive KPI status, on-target |
| `bad` | `#C50F1F` | Negative KPI status, off-target |
| `neutral` | `#605E5C` | Neutral / no-data status |
| `accent` | `#0F6C74` | Interactive accent (slightly darker teal) |
| `hyperlink` | `#0078D4` | Links |
| `null` | `#FF7F48` | Null / missing data indicator |

### Foreground / Text
| Token | Hex | Use |
|---|---|---|
| `foreground` | `#242424` | Primary text, axis labels |
| `foregroundNeutralSecondary` | `#616161` | Secondary labels, subtitles, axis titles |
| `foregroundNeutralTertiary` | `#BDBDBD` | Disabled / placeholder text |
| `foregroundLight` | `#FFFFFF` | Text on dark backgrounds |
| `disabledText` | `#B3B3B3` | Disabled controls |

### Backgrounds
| Token | Hex | Use |
|---|---|---|
| Page background | `#F5F5F5` | Report page canvas |
| `background` (visual) | `#FFFFFF` | Visual card background |
| `secondaryBackground` | `#FAFAFA` | Alternating table rows, input fields |
| `backgroundLight` | `#F3F2F1` | Table headers, filter cards, section fills |
| `backgroundNeutral` | `#C8C6C4` | Neutral fills |
| `backgroundDark` | `#E1DFDD` | Visual borders, outspace |
| `shapeStroke` | `#D1D1D1` | Border / divider lines |
| Gridlines | `#EDEBE9` | Chart value-axis gridlines, table lines |

---

## Typography

All fonts: **Segoe UI** family (with system fallbacks `helvetica, arial, sans-serif`).

| Class | Font | Size (pt) | Weight | Colour | Use |
|---|---|---|---|---|---|
| Callout | Segoe UI Semibold | 30 pt | Semibold | `#242424` | Large KPI numbers |
| Title | Segoe UI Semibold | 14 pt | Semibold | `#242424` | Visual titles |
| Header | Segoe UI Semibold | 12 pt | Semibold | `#242424` | Section headers |
| Label | Segoe UI | 10 pt | Regular | `#616161` | Axis labels, data labels, table body |
| Card value | Segoe UI Semibold | 28 pt | Semibold | `#242424` | New card visual value |
| Card label | Segoe UI | 11 pt | Regular | `#616161` | New card visual label |
| Slicer header | Segoe UI Semibold | 11 pt | Semibold | `#242424` | Slicer headers |

> **Note:** Power BI theme font sizes are in **points**. Conversion: px × 0.75 = pt.

---

## Visual Container Defaults (applied to all visuals via `*.*`)

| Property | Value |
|---|---|
| Background | `#FFFFFF`, 0% transparency |
| Border | 1 px, radius **8 px**, colour `#E1DFDD` |
| Drop shadow | Outer, 90°, distance 1, blur 4, spread 0, black at 88% transparency |
| Padding | Left 12 px · Top 10 px · Right 12 px · Bottom 12 px |
| Word wrap | Enabled |
| Visual title | Shown, Segoe UI Semibold 14 pt, left-aligned, `#242424` |
| Subtitle | Hidden by default |
| Divider | Hidden by default |

---

## Chart Conventions

| Property | Value |
|---|---|
| Category axis gridlines | **Off** |
| Value axis gridlines | On, solid, `#EDEBE9`, 1 px |
| Axis title | Hidden (use visual title instead) |
| Axis label font | Segoe UI 10 pt, `#616161` |
| Legend position | Bottom, no title |
| Line stroke width | 2 px |
| Responsive | Enabled on all chart types |
| Marker | Off (line charts) |

---

## Specific Visual Overrides

### New Card (`cardVisual`)
- Value: Segoe UI Semibold 28 pt, `#242424`
- Label: below value, Segoe UI 11 pt, `#616161`
- Accent bar: teal `#197278`, 3 px width
- Rounded rectangle: 8 px curve
- Divider: `#EDEBE9`, 1 px solid
- Vertical spacing: 4 px

### Legacy Card (`card`)
- Value: Segoe UI Semibold 28 pt
- Category label: Segoe UI 11 pt, `#616161`

### KPI Visual
- Indicator: Segoe UI Semibold 28 pt
- Trendline: shown, 20% transparency
- Goal distance: shown, 10 pt
- Status colours: good `#107C41`, bad `#C50F1F`, neutral `#605E5C`

### Table / Matrix
- Header: Segoe UI Semibold 10 pt, background `#F3F2F1`
- Body: Segoe UI 10 pt, alternating `#FFFFFF` / `#FAFAFA`
- Totals: Segoe UI Semibold 10 pt, background `#F3F2F1`
- Horizontal gridlines only, `#EDEBE9`, no vertical lines
- Row padding: 4 px

### Slicer
- Mode: **Dropdown** by default
- No border, no background, no shadow on the container
- Slider accent: teal `#197278`
- Header: Segoe UI Semibold 11 pt

### Decorative Elements (shapes, images, buttons, textboxes)
- No border, no background, no drop shadow, no visual header
- Shapes: `keepLayerOrder: true`

### Filled Map
- Default colour: `#197278`

### Donut Chart
- Inner radius: 60%
- Legend: bottom, no title

---

## Do's and Don'ts

### Do
- Use the 8-colour data series in order — do not skip slots
- Use `good` / `bad` / `neutral` tokens for all status indicators
- Use `#197278` teal as the single-series default for bars and gauges
- Keep visual titles concise — they sit in 14 pt Semibold at the top of each card
- Apply 8 px border radius consistently — do not mix with sharp corners
- Use the new Card visual (`cardVisual`) for KPIs, not the legacy `card`

### Don't
- Do not override theme colours with manual per-visual hex values unless a layout pattern explicitly requires it
- Do not show axis titles — use the visual title instead
- Do not show subtitles — they are off by default
- Do not add category axis gridlines
- Do not use bold in body text (tables, labels) — semibold is reserved for headers and callouts
- Do not deviate from 1280 × 720 px canvas size
