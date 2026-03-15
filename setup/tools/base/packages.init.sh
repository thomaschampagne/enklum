#!/bin/zsh

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" as \"$(whoami)\" user"
echo "============================================================"

# Install default mise configuration
mise install

# Clear cache
mise cache clear

# Assert mise working properly setup
mise doctor