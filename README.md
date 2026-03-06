# HVL RevealJS — Quarto Extension

A [Quarto](https://quarto.org) presentation theme for Høgskulen på Vestlandet (HVL) / Western Norway University of Applied Sciences, based on the HVL visual identity guide.

## Quick start

### New presentation

Run this in a terminal to scaffold a new presentation with the extension already installed:

```bash
quarto use template julienvollering/HVL-RevealJS-template
```

This creates `template.qmd` and installs the extension in `_extensions/hvl/`.

### Add to an existing project

```bash
quarto add julienvollering/HVL-RevealJS-template
```

Then set your document format:

```yaml
format:
  hvl-revealjs: default
```

## Usage

Open `template.qmd` and edit the YAML header:

```yaml
title: "Presentation Title"
subtitle: "Subtitle · Course or event name"
author: "Your Name"
institute: "Western Norway University of Applied Sciences"
date: today
```

Render with:

```bash
quarto render template.qmd
```

Or use the Render button in RStudio / VS Code.

## Title slide

The title slide background and logo are set via `title-slide-attributes` in your `.qmd` file:

```yaml
title-slide-attributes:
  data-background-color: "#004357"
  data-background-image: "_extensions/hvl/hvl_logo_en_neg.png"
  data-background-size: "180px"
  data-background-position: "top 1.5em right 1.5em"
```

## Custom classes

| Class | Purpose |
|---|---|
| `.ingress` | Lead sentence in teal DM Sans |
| `.hvl-accent` | Sea-green left-border accent bar |
| `.fact-box` | Highlighted information box |
| `.glass-box` | Semi-transparent overlay for background images |
| `.big-number` | Large teal statistic |
| `.big-label` | Small grey label beneath a big number |
| `.section-slide` | White text for teal section divider slides |
| `.dark-slide` | Teal/white text for dark background slides |
| `.teal` `.blue` `.muted` | Colour helpers |
| `.vcenter` | Vertically centre a column |
| `.small` `.tiny` | Font-size helpers |

Fragment highlight classes (text stays visible; background animates in on click):

```markdown
[phrase]{.fragment .hl-teal}
[phrase]{.fragment .hl-yellow}
```

See `template.qmd` for working examples of all classes and layouts.

## Updating

Re-run `quarto add` to update the extension to the latest version:

```bash
quarto add julienvollering/HVL-RevealJS-template
```

This overwrites `_extensions/hvl/` with the latest theme files. Your `.qmd` files are not affected.
