#!/bin/bash

set -euo pipefail

# ---- CONFIGURATION ----

# Option 1: Read from CSV file (one path per line or comma-separated)
CSV_FILE="paths-to-remove.csv"

# Option 2: Hardcoded list (use this OR the CSV method, not both)
# Uncomment and edit if you prefer to hardcode paths
# PATHS_TO_REMOVE=(
#   "secrets/api-key.txt"
#   "config/old-config.json"
#   "scripts/debug.sh"
# )

# Initialize the array to avoid "unbound variable" errors
PATHS_TO_REMOVE=()

# ---- FUNCTIONS ----

check_dependencies() {
  if ! command -v git-filter-repo &> /dev/null; then
    echo "Error: git-filter-repo is not installed. Please install it:"
    echo "https://github.com/newren/git-filter-repo"
    exit 1
  fi
}

verify_git_repo() {
  if ! git rev-parse --is-inside-work-tree &> /dev/null; then
    echo "Error: This script must be run inside a Git repository."
    exit 1
  fi
}

load_paths() {
  if [ -f "$CSV_FILE" ]; then
    echo "Reading paths from CSV: $CSV_FILE"
    IFS=$'\n' read -d '' -r -a PATHS_TO_REMOVE < <(
      tr ',' '\n' < "$CSV_FILE" | sed '/^\s*$/d' | sed 's/^[[:space:]]*//' && printf '\0'
    )
  elif [ ${#PATHS_TO_REMOVE[@]} -eq 0 ]; then
    echo "Error: No paths provided. Either define PATHS_TO_REMOVE in the script or use a CSV file."
    exit 1
  fi
}

remove_paths() {
  echo "The following paths will be removed from Git history:"
  for path in "${PATHS_TO_REMOVE[@]}"; do
    echo "  - $path"
  done

  read -p "Are you sure you want to proceed? This will rewrite history. (yes/no): " confirm
  if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 0
  fi

  git filter-repo $(for path in "${PATHS_TO_REMOVE[@]}"; do echo "--path $path"; done) --invert-paths

  echo "Done. Remember to force-push the updated repo:"
  echo "  git push origin --force --all"
  echo "  git push origin --force --tags"
}

# ---- MAIN ----

check_dependencies
verify_git_repo
load_paths
remove_paths
