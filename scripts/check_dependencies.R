#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
description_path <- if (length(args) >= 1L) args[[1L]] else "DESCRIPTION"

if (!file.exists(description_path)) {
  stop("Cannot find ", description_path, ". Run this script from the project root.",
       call. = FALSE)
}

description <- tryCatch(
  read.dcf(description_path),
  error = function(error) {
    stop("DESCRIPTION is not valid DCF: ", conditionMessage(error), call. = FALSE)
  }
)

validate_field <- function(field) {
  if (!field %in% colnames(description)) {
    return(character())
  }

  value <- description[1L, field]
  if (is.na(value) || !nzchar(trimws(value))) {
    return(character())
  }

  if (grepl(",[[:space:]]*$", value)) {
    stop(
      field, " ends with a comma. The final package in the field must not have a comma.",
      call. = FALSE
    )
  }

  references <- trimws(strsplit(value, ",", fixed = TRUE)[[1L]])
  valid_reference <- grepl(
    "^[A-Za-z][A-Za-z0-9.]*([[:space:]]*\\([^()]+\\))?$",
    references
  )

  if (any(!valid_reference)) {
    invalid <- references[!valid_reference]
    stop(
      "Invalid ", field, " package declaration: '",
      paste(invalid, collapse = "', '"), "'. ",
      "This often means a comma is missing between two package names. ",
      "Put one package on each line, add a comma after every package except the last, ",
      "and then run this check again.",
      call. = FALSE
    )
  }

  packages <- sub("[[:space:]]*\\(.*$", "", references)
  duplicates <- unique(packages[duplicated(packages)])
  if (length(duplicates) > 0L) {
    stop(
      "Duplicate package declaration in ", field, ": ",
      paste(duplicates, collapse = ", "), ".",
      call. = FALSE
    )
  }

  packages
}

imports <- validate_field("Imports")
suggests <- validate_field("Suggests")

cat("DESCRIPTION dependency declarations are valid.\n")
if (length(imports) > 0L) {
  cat("Imports: ", paste(imports, collapse = ", "), "\n", sep = "")
}
if (length(suggests) > 0L) {
  cat("Suggests: ", paste(suggests, collapse = ", "), "\n", sep = "")
}
