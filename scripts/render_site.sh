#!/usr/bin/env bash
set -euo pipefail

if [ ! -f "_quarto.yml" ]; then
  echo "ERROR: _quarto.yml not found. Run this from the repository root."
  exit 1
fi

quarto render
