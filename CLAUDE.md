# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A set of **Quarto extensions** (not an R package, not a website) providing HVL-branded output in two formats, sharing one brand definition. Consumed via `quarto use template` / `quarto add julienvollering/quarto-hvl`.

There is no build step, no test suite, and no linter. The only "build" is rendering the two demo documents:

```bash
quarto render presentation.qmd   # revealjs deck -> presentation.html
quarto render report.qmd         # typst report  -> report.pdf
```

Both contain executable `{r}` chunks, so rendering needs R with `ggplot2`/`tidyverse` and `yaml`. The first Typst render also needs network access to fetch Google Fonts.

Useful while debugging:

```bash
quarto render report.qmd -M keep-typ:true              # inspect generated report.typ
quarto typst compile report.typ out{n}.png --format png \
  --font-path .quarto/typst/fonts                      # visual check without a PDF viewer
```

**Do not add `--to typst` to that first command.** It overrides the format in the
front matter with base Typst, which silently drops every `hvl-report` default —
you end up debugging a `.typ` that the extension never touched.

## Architecture

Three extensions, each with a distinct job:

- **`_extensions/hvl-brand/`** — `brand.yml` plus the logo assets. The single source of truth for HVL colours, fonts and logos. Its `_extension.yml` contributes `metadata.project.brand`, which is what makes the brand apply project-wide rather than only to one format. It must be its own extension directory: a *format* extension's metadata contribution activates only with that format, and the brand has to reach both revealjs and typst.
- **`_extensions/hvl/`** — the `hvl-revealjs` format. `_extension.yml` declares defaults for every deck; `hvl-theme.scss` holds the entire visual design in Quarto's two-section SCSS format (`scss:defaults` for variables, `scss:rules` for CSS and custom classes).
- **`_extensions/hvl-report/`** — the `hvl-report-typst` format. Brand supplies everything it can; what is left in `_extension.yml` is a short `include-in-header: text:` block of Typst show rules for the two things brand.yml has no vocabulary for — caption styling and vertical rhythm — plus `toc: false`, `linestretch` and `papersize: a4` (Typst's own default is us-letter). Still no `.typ` template: rules go inline in the YAML. Margins are left at Quarto's `1.25in`, which on A4 gives a 5.77in measure. A title page and running headers remain out of scope; those would mean a real template.

`report.qmd`'s body is a fixed scaffold — title page, abstract, contents, foreword, then numbered sections — with the demo content living in the numbered sections. The abstract and foreword are `{.unnumbered}` headings and the contents list is a raw `#outline()` block, because `toc: true` renders the outline inside `article()` between the title block and the body, where nothing can be placed ahead of it. That is why `toc: false` is an extension default rather than a document setting: turn it on and the document gets two outlines.

`presentation.qmd` and `report.qmd` are both the user-facing starters *and* the living demos, named for the artifact each produces. `presentation.qmd` exercises every custom class and layout; when adding a class to the SCSS, add a demonstrating slide, a README table row, and an entry in the `<!-- CHEATSHEET -->` block at the bottom of the file.

Note that **neither is named `template.qmd`, and that is deliberate.** `template.qmd` is a magic filename: `quarto use template` renames it to match the directory the user chose, which in a two-starter repo would rename one file and leave the other, producing exactly the asymmetry the current names avoid. The cost is that `quarto use template` no longer renames anything — users get `presentation.qmd` and `report.qmd` verbatim, which is the intent.

Backgrounds are deliberately **not** styled in SCSS. RevealJS full-bleed backgrounds must come from Quarto attributes (`{background-color=...}`, `title-slide-attributes:`); the `.section-slide` / `.dark-slide` classes only restyle the *text* on top. Keep that split.

## Gotchas

- **The report format is `hvl-report-typst`, and a wrong name fails silently.** Quarto builds the name from the extension *directory*, so `hvl-report` + `typst`. `format: hvl-typst` — which the README and `report.qmd` both carried until this was caught — does not error: Quarto drops the unknown `hvl-` prefix and renders plain unstyled Typst, so the document still builds and simply ignores every extension default. If a change to `_extension.yml` seems to have no effect, check the format name first, then confirm with `quarto render report.qmd` and look for your options in the echoed `pandoc`/`metadata` block.
- **`brand-logo-images` is the way to name a brand asset from raw Typst.** Quarto emits the whole `logo.images` mapping into the `.typ` as a dictionary with paths already resolved for wherever the brand extension sits, e.g. `image("/" + brand-logo-images.hvl-mark.path)` (leading slash = project-root-relative). This is install-independent, which a hardcoded path is not, and it is why the V mark is registered in `brand.yml` as `hvl-mark` even though nothing sets `logo: hvl-mark`. The dictionary is defined near the top of the emitted file, before the body, so it is in scope for raw blocks — but *not* for `include-in-header`, which lands earlier still.
- **`include-in-header` lands *above* `brand-color`, not below it.** Quarto inserts it before the block that defines `brand-color` and `brand-logo-images`, so a rule in `_extensions/hvl-report/_extension.yml` that names either fails the render with `unknown variable: brand-color`. Write the hex out there, or move the rule into the document body where both are in scope.
- **Typst show rules for spacing go on the `block`, not the element.** `above`/`below` are fields of the block a heading or figure lays itself out in, so it is `#show heading: set block(above: 2em, below: 1em)`. Paragraph spacing is `#set par(spacing:)`; line spacing comes from Quarto's `linestretch`, which multiplies Typst's 0.65em default leading and is passed into `article()`. Setting leading directly at top level does not survive — `article()` sets `par.leading` inside the document show rule and wins.
- **The palette is duplicated in `brand.yml` and `hvl-theme.scss`, by necessity.** It looks like the SCSS should alias brand's `$brand-<name>` variables, and that was tried. Those variables are only defined for SCSS layers emitted *after* brand, which requires brand to outrank the theme in `theme:` — and then brand also wins on shared variables and silently replaces the theme's font stacks. So `theme: [brand, hvl-theme.scss]` stays (brand lowest priority) and both files carry the hex codes. **Change one, change the other.** Font families are duplicated for the same reason: the SCSS `@import` loads them for revealjs, `brand.yml` loads them for typst.
- **Brand typography leaks into the deck.** `typography.base` reaches revealjs as well as typst. Setting `line-height` there loosened every slide from 1.3 to 1.5; it was removed for that reason. Before adding anything under `typography.base`, diff the compiled deck CSS (`presentation_files/libs/revealjs/dist/theme/quarto-*.css`) against a pre-change render — a `git worktree` at the previous commit is the reliable way to get a baseline.
- **`headings.family` is `DM Sans 9pt`, not `DM Sans`.** DM Sans is a variable font with an optical-size axis and Google serves static instances whose internal family name carries the size. Typst matches that internal name and warns `unknown font family: dm sans` otherwise ([quarto-cli#11947](https://github.com/quarto-dev/quarto-cli/issues/11947)). Check `.quarto/typst/available-fonts.json` for the names Typst actually sees. The deck is unaffected — CSS resolves the variable font as plain `DM Sans`.
- **Typst font cache lives at `.quarto/typst/fonts/`**, not the `.quarto/typst-font-cache` path the Quarto docs name. `quarto typst fonts` does *not* look there, so it will report the brand fonts as missing even when renders succeed — don't trust it as a diagnostic.
- **`brand.yml` `typography.fonts` must be an array**, not a mapping keyed by font name, whatever the reference docs show. A mapping fails brand validation outright.
- **Extension paths differ between this repo and an install.** In-repo assets are at `_extensions/hvl-brand/`; after a GitHub install they land at `_extensions/julienvollering/hvl-brand/` (the org is part of the path), and after a local-path install at `_extensions/hvl-brand/`. Prefer the `{{< brand logo <name> >}}` shortcode over a written path — it resolves to wherever the brand actually lives, in every case. Wrap it in `::: {.brand-logo}` to size it; the shortcode emits a bare `<img>` and the sources are ~2000px wide. `report.qmd` uses named resources (`logo: hvl-en`) for the same reason, its R chunk globs both locations, and its raw Typst reads paths out of `brand-logo-images` (see above). **The one place this can't be done is `title-slide-attributes.data-background-image`** — YAML values aren't shortcode-expanded, so that path stays hardcoded to the GitHub-installed location and silently shows no background when rendered from a clone.
- **Bilingual is a manual swap.** `lang: en` vs `lang: nb` does not change the logo. Decks need it changed in `title-slide-attributes` and on the closing slide; reports need the `logo:` key, and also the hand-written `#outline(title: ...)` — nothing localises that string. Commented alternatives sit next to each occurrence — keep that pattern. The V mark is language-neutral and needs no swap.
- **`HVLStyleGuideDictionary.R`** holds the full brand spec (PMS/CMYK/RGB/hex, official font families and their usage rules, including the Arial/Georgia *office* fonts prescribed for MS Office output). It is a lookup table, not part of any extension — nothing sources it, and it ships to users only because the README points at it. Note commit `5ed57ef` had removed it and it was deliberately restored; `brand.yml` is the machine-readable source of truth, this file is the human reference behind it.
- **docx is not supported by brand.yml** (only `html`, `dashboard`, `revealjs`, `typst`). Word output would need a hand-built `reference-doc:`, which shares nothing with the brand file.
