#!/usr/bin/env bash
set -euo pipefail

if [ ! -f "_quarto.yml" ]; then
  echo "ERROR: _quarto.yml not found. Run this from the repository root."
  exit 1
fi

if [ "$#" -ne 1 ]; then
  echo "Usage: ./scripts/preview_note.sh path/to/note.qmd"
  exit 1
fi

note_path="$1"

if [ ! -f "$note_path" ] || [[ "$note_path" != *.qmd ]]; then
  echo "ERROR: '$note_path' is not an existing .qmd file."
  exit 1
fi

echo "Previewing one document: $note_path"
quarto preview "$note_path"
