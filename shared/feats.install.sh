#!/bin/bash

set -euo pipefail

run_feature_installers() {
    local root_folder="${1:?Usage: run_feature_installers <root_folder>}"
    local username="${ENKLUM_USERNAME:-}"
    local -a scripts=()

    if [ ! -d "$root_folder" ]; then
        echo "Error: Directory '$root_folder' does not exist" >&2
        return 1
    fi

    if [ -z "$username" ]; then
        echo "Error: ENKLUM_USERNAME is not set" >&2
        return 1
    fi

    while IFS= read -r -d '' file; do
        dos2unix -q "$file" 2>/dev/null || true
        sudo chown "${username}:${username}" "$file"
        if [[ "$file" == *.install.sh ]]; then
            scripts+=("$file")
        fi
    done < <(find "$root_folder" -type f -print0)

    if [ ${#scripts[@]} -eq 0 ]; then
        echo "No installer scripts found in '$root_folder'"
        return 0
    fi

    IFS=$'\n' sorted_scripts=($(sort <<<"${scripts[*]}"))
    unset IFS

    for script in "${sorted_scripts[@]}"; do
        echo "Running: $script"
        # bash "$script"
        sudo runuser -u ${ENKLUM_USERNAME} -- bash -c "$script"
    done
}

run_feature_installers /setup/features
