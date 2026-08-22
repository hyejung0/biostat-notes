# Render only the .qmd file currently open in RStudio.

render_current_qmd <- function() {
  if (!requireNamespace("rstudioapi", quietly = TRUE)) {
    stop(
      "The rstudioapi package is required. Install it with ",
      "install.packages(\"rstudioapi\").",
      call. = FALSE
    )
  }

  context <- rstudioapi::getSourceEditorContext()
  document_path <- context$path

  if (!nzchar(document_path) || !grepl("\\.qmd$", document_path, ignore.case = TRUE)) {
    stop("Make a saved .qmd editor tab active, then run this command again.", call. = FALSE)
  }

  document_path <- normalizePath(document_path, winslash = "/", mustWork = TRUE)
  project_root <- dirname(document_path)

  repeat {
    if (file.exists(file.path(project_root, "_quarto.yml"))) {
      break
    }

    parent <- dirname(project_root)
    if (identical(parent, project_root)) {
      stop("No _quarto.yml was found above the active document.", call. = FALSE)
    }
    project_root <- parent
  }

  relative_path <- substring(document_path, nchar(project_root) + 2L)
  quarto_bin <- Sys.which("quarto")

  if (!nzchar(quarto_bin)) {
    stop("Quarto was not found on the system PATH.", call. = FALSE)
  }

  old_directory <- setwd(project_root)
  on.exit(setwd(old_directory), add = TRUE)

  message("Rendering one document: ", relative_path)
  status <- system2(quarto_bin, c("render", shQuote(relative_path)))

  if (!identical(status, 0L)) {
    stop("Quarto render failed for ", relative_path, ".", call. = FALSE)
  }
}

render_current_qmd()
