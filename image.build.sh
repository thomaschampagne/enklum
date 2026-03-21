#!/bin/bash

set -euo pipefail

# Defaults
arg_file_path="./argfile.default.conf"
github_token=""
image_name=""
image_tag="latest"
docker_file=""

# Container runtime selection: docker or podman. Defaults to podman if available, otherwise docker.
runner=""

# Help message
show_help() {
    cat << 'EOF'
Usage: $0 [--image-name NAME] [--image-tag TAG] [--arg-file PATH] [--gh-token TOKEN] [--runner RUNNER] [--docker-file FILE] [--help]

Options:
  --image-name NAME     Set image name (default: enklum)
  --image-tag TAG       Set image tag (default: latest)
  --arg-file PATH       Set arg file path (default: ./argfile.default.conf)
  --gh-token TOKEN      Set GitHub token (default: empty)
  --runner RUNNER       Container runner to use (docker or podman). If not specified, uses podman if available, otherwise docker.
  --docker-file FILE    Set Dockerfile path (default: ./core/Dockerfile)
  --help                Show this help message
EOF
    exit 0
}

# Parse arguments manually for better portability
while [[ $# -gt 0 ]]; do
    case "$1" in
        --image-name=*)
            image_name="${1#*=}"
            shift
            ;;
        --image-tag=*)
            image_tag="${1#*=}"
            shift
            ;;
        --arg-file=*)
            arg_file_path="${1#*=}"
            shift
            ;;
        --gh-token=*)
            github_token="${1#*=}"
            shift
            ;;
        --runner=*)
            runner="${1#*=}"
            shift
            ;;
        --docker-file=*)
            docker_file="${1#*=}"
            shift
            ;;
        --image-name)
            image_name="$2"
            shift 2
            ;;
        --image-tag)
            image_tag="$2"
            shift 2
            ;;
        --arg-file)
            arg_file_path="$2"
            shift 2
            ;;
        --gh-token)
            github_token="$2"
            shift 2
            ;;
        --runner)
            runner="$2"
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

# Validate runner selection
if [ -n "$runner" ]; then
    # Check if specified runner exists and is executable
    if ! runner_path=$(type -P "$runner") || [ -z "$runner_path" ]; then
        echo "Error: Specified runner '$runner' not found or not executable. Please install $runner or choose a different runner." >&2
        exit 1
    fi
else
    # Auto-detect runner: prefer podman, fallback to docker
    if runner_path=$(type -P podman) && [ -n "$runner_path" ]; then
        runner="podman"
    elif runner_path=$(type -P docker) && [ -n "$runner_path" ]; then
        runner="docker"
    else
        echo "Error: Neither podman nor docker is installed. Please install one of them." >&2
        exit 1
    fi
fi

echo "Using container runner: $runner"

# Remove existing container if it exists
if $runner container exists "$image_name" > /dev/null 2>&1; then
    echo "Removing existing container: $image_name"
    $runner rm -f "$image_name"
    echo "Container removed."
else
    echo "No existing container found with name: $image_name"
fi

# Build image
echo "Building image: $image_name:$image_tag"
$runner build \
  --build-arg OCI_BUILD_DATE="$(date -u '+%Y-%m-%dT%H:%M:%SZ')" \
  --build-arg-file "$arg_file_path" \
  --env GITHUB_TOKEN="$github_token" \
  -f "$docker_file" \
  -t "$image_name:$image_tag" .
echo "Image built successfully: $image_name:$image_tag"
  