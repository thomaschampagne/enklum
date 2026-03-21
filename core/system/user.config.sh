#!/bin/bash

set -euo pipefail

# Configure Git
git config --global --add safe.directory '*'
git config --global init.defaultBranch main
git config --global core.autocrlf true # Ensure skip LF vs CRLF comparison