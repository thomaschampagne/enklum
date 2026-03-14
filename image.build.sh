#!/bin/bash

set -e
set -o pipefail

# Defaults
arg_file_path="./argfile.default.conf"
github_token=""
image_name="enklum"
image_tag="latest"

# TODO Add container runtime docker|podman

# Help message
show_help() {
    cat << 'EOF'
Usage: $0 [--image-name NAME] [--image-tag TAG] [--arg-file PATH] [--github-token TOKEN] [--help]

Options:
  --image-name NAME     Set image name (default: enklum)
  --image-tag TAG       Set image tag (default: latest)
  --arg-file PATH       Set arg file path (default: ./argfile.default.conf)
  --github-token TOKEN  Set GitHub token (default: empty)
  --help                Show this help message
EOF
    exit 0
}

# Use external getopt to parse long options
TEMP=$(getopt -o h --long help,image-name:,image-tag:,arg-file:,github-token: -n "$0" -- "$@")

if [ $? != 0 ]; then
    echo "Failed to parse options." >&2
    exit 1
fi

eval set -- "$TEMP"

while true; do
    case "$1" in
        --image-name) image_name="$2"; shift 2 ;;
        --image-tag)  image_tag="$2";  shift 2 ;;
        --arg-file)   arg_file_path="$2"; shift 2 ;;
        --github-token) github_token="$2"; shift 2 ;;
        -h|--help)    show_help ;;
        --)           shift; break ;;
        *)            echo "Internal error!" >&2; exit 1 ;;
    esac
done

# Remove existing container if it exists
podman container exists "$image_name" && podman rm -f "$image_name"

# Build image
podman build \
  --build-arg OCI_BUILD_DATE="$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
  --build-arg-file "$arg_file_path" \
  --env GITHUB_TOKEN="$github_token" \
  -t "$image_name:$image_tag" .
  