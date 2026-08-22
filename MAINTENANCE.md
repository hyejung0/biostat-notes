# Notes Maintenance Checklist

The `.qmd` files under `notes/` are the editable source files. Never edit `_site/`; Quarto deletes and recreates that output.

## Add

1. Create `notes/<Subject>/short-descriptive-name.qmd`.
2. Include `title`, `description`, and `categories` in the YAML header. Add `author`, a literal `date` in `YYYY-MM-DD` form, and bibliography settings when relevant.
3. Put note-specific images or attachments next to the note.
4. Run `quarto preview` and verify the note, listings, and a full-text search.

New notes are discovered automatically by the globs in `_quarto.yml`, `topics.qmd`, and `notes/index.qmd`.

## Modify

1. Edit the source `.qmd` file and its metadata.
2. If the file is renamed, update incoming links that use the old name.
3. Run `quarto render` before publishing.

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
