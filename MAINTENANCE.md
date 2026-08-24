# Notes Maintenance Checklist

The `.qmd` files under `notes/` are the editable source files. Never edit `_site/`; Quarto deletes and recreates that output.

## Add

1. Create `notes/<Subject>/short-descriptive-name.qmd`.
2. Include `title`, `description`, and `categories` in the YAML header. Add `author`, a literal `date` in `YYYY-MM-DD` form, and bibliography settings when relevant.
3. Put note-specific images or attachments next to the note.
4. Render just the note while editing with `./scripts/render_note.sh path/to/note.qmd`. Run the full site only for the final navigation and search check.

New notes are discovered automatically by the globs in `_quarto.yml`, `topics.qmd`, and `notes/index.qmd`.

The `categories` list is the note's topic-tag list and drives the left panel on **Browse by topic**. Use `categories` only; do not duplicate it under `tags`. Reuse existing topic spellings so one idea does not split into several filters. The topic panel is rebuilt automatically during a complete site render and is independent of the note's folder name.

## R packages used by notes

GitHub builds on a clean computer and installs only the R packages declared under `Imports` in `DESCRIPTION`. If a note uses a new package with `library(packageName)` or `packageName::function()`, also add `packageName` to `DESCRIPTION`. Loading a package in the note does not install it.

`rmarkdown` is required by the Quarto/R rendering process and must remain in `DESCRIPTION`; individual notes do not need `library(rmarkdown)`.

Put one package on each line in `DESCRIPTION`, with a comma after every package except the final package in the field. For example, if `DiagrammeR` follows `data.table`, the line must be `data.table,`. A missing comma makes R combine two names (such as `tibble DiagrammeR`) into one invalid package reference.

After adding a dependency, run `Rscript scripts/check_dependencies.R`, install the package locally if needed, and render the current note. Run `quarto render` once before pushing. If GitHub reports `there is no package called 'x'`, add `x` to `DESCRIPTION`, commit that change, and push again.

## Modify

1. Edit the source `.qmd` file and its metadata.
2. If the file is renamed, update incoming links that use the old name.
3. Render the changed note while editing, then run `quarto render` once before publishing.

## Delete

1. Remove the source `.qmd` file.
2. Remove note-specific attachments only after confirming they are not shared.
3. Search for and repair links to the deleted file.
4. Render again. Navigation, listings, and search update automatically.

## Publish

```bash
git add .
git commit -m "Update biostatistics notes"
git push
```

GitHub Actions renders the project and publishes `_site/` to GitHub Pages. For first-time GitHub setup and fuller examples, read `README.md` or the website's **Managing notes** page.

## Render commands

- Active RStudio document: `source("scripts/render_current.R")`
- One named note: `./scripts/render_note.sh path/to/note.qmd`
- Live preview of one note: `./scripts/preview_note.sh path/to/note.qmd`
- Complete website: `./scripts/render_site.sh` or `quarto render`

The complete website render is intentionally reserved for final checks and publication.
