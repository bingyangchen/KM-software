#!/bin/bash

# Recursive function to generate the GitBook summary file
generate_summary() {
  local path="$1"
  local indent="${2:-}"

  # Avoid generating the root layer
  if [[ "$(basename "$path")" != "." ]]; then
    echo "${indent}- $(basename "$path")" >> SUMMARY.md
  fi

  for file in "$path"/*; do
    # Files to ignore
    if [[ "$file" == "./DEV.md" || "$file" == "./SUMMARY.md" ]]; then
      continue
    elif [[ -d "$file" && $(basename "$file") != "node_modules" && $(basename "$file") != "圖庫" ]]; then
      if [[ "$path" == "." ]]; then
        generate_summary "$file" ""
      else
        generate_summary "$file" "$indent  "
      fi
    elif [[ -f "$file" && $(basename "$file") == *.md ]]; then
      echo "${indent}  - [$(basename "$file")](<./$file>)" >> SUMMARY.md
    fi
  done
}





# Generate the GitBook summary file
echo "# Summary\n" > SUMMARY.md
generate_summary . ""

# Print a message indicating that the summary file has been generated
echo "GitBook summary file (SUMMARY.md) generated."