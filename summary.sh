#!/bin/bash

# Directories to ignore
ignore_dirs=("node_modules" "圖庫" "Pinkoi")

# Specific markdown files to ignore
ignore_md_files=("./DEVNOTE.md" "./SUMMARY.md")

# Recursive function to generate the GitBook summary file
generate_summary() {
    local path="$1"
    local indent="${2:-}"

    # Avoid generating the root layer
    if [[ "$(basename "$path")" != "." ]]; then
        echo "${indent}- $(basename "$path")" >>SUMMARY.md
    fi

    for file in "$path"/*; do
        if [[ -d "$file" && !("${ignore_dirs[@]}" =~ $(basename "$file")) ]]; then
            if [[ "$path" == "." ]]; then
                generate_summary "$file" ""
            else
                generate_summary "$file" "$indent  "
            fi
        elif [[ -f "$file" && $(basename "$file") == *.md ]]; then
            if [[ !("${ignore_md_files[@]}" =~ "$file") ]]; then
                echo "${indent}  - [$(basename "$file" .md)](<./$file>)" >>SUMMARY.md
            fi
        fi
    done
}

# Generate the GitBook summary file
echo "# Summary\n" >SUMMARY.md
generate_summary . ""

# Print a message indicating that the summary file has been generated
echo "GitBook summary file (SUMMARY.md) generated."
