#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" as \"$(whoami)\" user"
echo "============================================================"

# TODO Use append to mise .toml ?
# TODO Add these runtime on user defined installs: bun \
# TODO Add these runtime on user defined installs: rust \
# TODO Add these runtime on user defined installs: go \
# TODO Add these runtime on user defined installs: python uv \
# TODO Add these runtime on user defined installs: java@openjdk-25  # TODO Too much space required ?