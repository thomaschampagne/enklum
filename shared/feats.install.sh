#!/bin/bash

set -euo pipefail

FEATURES_FOLDER=""

show_help() {
    cat << 'EOF'
Usage: $0 [--features-folder PATH] [--help]

Options:
  --features-folder PATH   Set features folder path (required)
  --help                   Show this help message
EOF
    exit 0
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --features-folder=*)
            FEATURES_FOLDER="${1#*=}"
            shift
            ;;
        --features-folder)
            FEATURES_FOLDER="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Use --help for usage information" >&2
            exit 1
            ;;
    esac
done

if [ -z "$FEATURES_FOLDER" ]; then
    echo "Error: --features-folder is required" >&2
    echo "Use --help for usage information" >&2
    exit 1
fi

run_feature_installers() {
    local root_folder="${FEATURES_FOLDER:?Usage: run_feature_installers <root_folder>}"
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
        chown "${username}:${username}" "$file"
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
        runuser -u ${ENKLUM_USERNAME} -- bash -c "$script"
    done

    # Drop feature folder
    rm -rf "$FEATURES_FOLDER"
    echo "Feature folder $FEATURES_FOLDER has been deleted"

    # Reshim any packages from mise
    mise reshim
    mise cache clear
}

run_feature_installers
