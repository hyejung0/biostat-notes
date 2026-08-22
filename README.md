# Biostatistics Notes

A searchable Quarto website for a personal collection of biostatistics notes. The site supports:

- full-text search across titles, headings, prose, and code;
- browsing by major subject area;
- an alphabetical, filterable title and topic index;
- long technical notes with math, citations, figures, R output, and slide presentations;
- automatic publication to GitHub Pages.

## Project map

```text
.
├── _quarto.yml                 # Site navigation, search, and rendering settings
├── index.qmd                   # Website home page
├── topics.qmd                  # Automatic subject-by-subject listings
├── guide.qmd                   # Maintenance guide shown on the website
├── MAINTENANCE.md              # Compact add/edit/delete checklist
├── notes/                      # Editable note sources (.qmd)
│   ├── Bayesian/
│   ├── Causal_Inference/
│   ├── Clinical_Trials/
│   ├── Measure_Theory/
│   └── Other/
├── references/                 # BibTeX and citation-style files
├── assets/                     # Shared styles, logos, and templates
├── code/                       # Supporting analysis code
├── scripts/                    # Preview and render helpers
├── .github/workflows/          # Automatic GitHub Pages deployment
├── DESCRIPTION                 # R packages installed for local/online rendering
└── _site/                      # Generated website; do not edit or commit
```

## Preview the website

Install [Quarto](https://quarto.org/docs/get-started/) and R. Open `biostat-notes.Rproj` in RStudio, select the **Terminal** tab, and run:

```bash
quarto preview
```

Quarto prints a local URL and refreshes the browser when a source file changes. Stop the preview with `Ctrl+C`.

To build once without starting the preview server:

```bash
quarto render
```

The rendered site is created in `_site/`.

## Add, edit, or delete notes

See [MAINTENANCE.md](MAINTENANCE.md) for the compact checklist or `guide.qmd` for the complete guide that also appears on the website.

Every note should have at least this metadata:

```yaml
---
title: "Descriptive Note Title"
author: "Hyejung Lee"
date: 2026-08-22
description: >
  One or two sentences explaining what the note contains.
categories:
  - causal-inference
  - clinical-trial
---
```

Save the file under the appropriate `notes/<Subject>/` folder. Navigation, topic listings, the title index, and the full-text search index update automatically on the next render.

## R package dependencies

GitHub renders the site on a clean computer. It installs the packages listed under `Imports` in `DESCRIPTION`; it cannot see packages that happen to be installed on your own computer.

The current site requires `data.table`, `ggplot2`, `knitr`, `rmarkdown`, and `tibble`. The `rmarkdown` package is a site-wide rendering dependency and should remain in `DESCRIPTION`. It does **not** need a `library(rmarkdown)` call inside individual notes.

Whenever an R code chunk uses a new package:

1. Add the package name under `Imports` in `DESCRIPTION`.
2. Use either `library(packageName)` or `packageName::function()` in the note.
3. Install it locally if necessary with `install.packages("packageName")`.
4. Run `quarto render` before committing and pushing.

For example, if a note uses `survival::coxph()`, add `survival` to `DESCRIPTION`:

```text
Imports:
    data.table,
    ggplot2,
    knitr,
    rmarkdown,
    survival,
    tibble
```

Keep the final package without a trailing comma. The GitHub Actions workflow reads this file automatically; do not add separate package-install commands to the workflow for ordinary R dependencies.

## Publish with GitHub Pages

### 1. Create the GitHub repository

1. Sign in at [github.com](https://github.com) and choose **New repository**.
2. Give it a name such as `biostat-notes`.
3. Do not initialize it with a README, because this project already has one.
4. Create the repository and copy the HTTPS repository address.

### 2. Connect and push this project

From the Terminal at this project root, run the commands GitHub shows under **push an existing repository from the command line**. They will look like:

```bash
git init
git add .
git commit -m "Create searchable biostatistics notes website"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/biostat-notes.git
git push -u origin main
```

If the project is already a Git repository, do not repeat `git init`; check `git status` and add the GitHub remote if needed.

### 3. Turn on GitHub Pages

1. Open the repository on GitHub.
2. Select **Settings**, then **Pages**.
3. Under **Build and deployment**, choose **GitHub Actions** as the source.
4. Open the **Actions** tab. The workflow named **Render and deploy Quarto site** should be running.
5. If the first workflow run started before Pages was enabled, open that run and choose **Re-run all jobs**.
6. When it finishes, return to **Settings → Pages** to find the website URL. A project repository normally uses `https://YOUR-USERNAME.github.io/biostat-notes/`.

### 4. Publish future changes

```bash
git add .
git commit -m "Update notes"
git push
```

Each push to `main` or `master` rebuilds and republishes the website. Do not commit `_site/`; the workflow creates it.

## How search works

Quarto builds a local `search.json` file during every render. No search service, account, API key, or database is required. Use the search control in the navigation bar—or press `/`—to search the full contents of every rendered note. The **All notes** page has a second, narrower filter for titles, categories, and summaries.

## Troubleshooting

- **A new note is missing:** confirm it ends in `.qmd`, is inside one of the five subject folders, has a `title`, and `quarto render` completes.
- **An image is missing:** use a path relative to the note and commit the image along with the note.
- **A citation fails:** confirm the bibliography and CSL paths are relative to the note's folder.
- **GitHub reports “there is no package called …”:** add that package under `Imports` in `DESCRIPTION`, render locally, commit both files, and push again. A `library(...)` call loads a package but does not install it.
- **GitHub Actions fails:** open the failed run, expand the red step, fix the first reported render or package error locally, and push again.
- **A deleted note remains online:** confirm the deletion was committed and the newest Actions run completed successfully.

The website's **Managing notes** page contains the everyday workflow in a shorter, nontechnical form.
