# Lotusoftware Dashboard Design Skill

**Trigger:** Load this skill whenever you are creating or editing report pages or
visuals for any Lotusoftware project. This includes new pages, new visuals, visual
formatting changes, layout decisions, colour choices, and theme application.

## What This Skill Provides

- `assets/design-system.md` — structured, agent-readable Lotusoftware design system
- `assets/lotusoftware-theme.json` — the validated Power BI theme file (symlinked from the shared theme folder)
- `assets/layouts/` — page composition patterns with design system applied

## Instructions

1. **Before designing or formatting any visual**, read `assets/design-system.md`.
2. **For new report pages**, read the relevant layout pattern in `assets/layouts/`
   that best matches the page purpose (KPI overview, detail drillthrough, etc.).
3. **Apply the theme** by confirming `Lotusoftware Base` is the active theme in the
   target report. Do not override theme colours with manual per-visual colours unless
   a layout pattern explicitly requires it.
4. **For conditional formatting or status flags** that the theme cannot produce,
   refer to the "Model Requirements" section in the relevant layout pattern — those
   measures must exist in the semantic model before the visual can be built.
5. **Never invent brand values.** If a design decision is not covered by
   `design-system.md`, stop and ask the user rather than defaulting to a guess.

## Available Assets

| File | Contents |
|---|---|
| `assets/design-system.md` | Full colour palette, typography, visual container defaults, do's & don'ts |
| `assets/lotusoftware-theme.json` | Validated Power BI theme file — apply via Desktop before authoring |
| `assets/layouts/kpi-overview.md` | KPI summary page pattern (3–6 cards + primary chart) |
| `assets/layouts/trend-analysis.md` | Time-series analysis page pattern |
| `assets/layouts/detail-drillthrough.md` | Drillthrough destination page pattern |
| `references/pbir-examples/` | PBIR visual JSON snippets (populated as examples are collected) |
