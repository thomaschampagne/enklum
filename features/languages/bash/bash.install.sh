#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install Runtime
mise use -g node@lts

# Required dependencies
npm install -g npm@latest

# Install JSON LSP
npm install -g bash-language-server@latest

# Force npm cache clean
npm cache clean --force

# TODO Formatter: go install mvdan.cc/sh/v3/cmd/shfmt@latest
# # TODO Helix language config
# if ! grep -q 'name = "bash"' ~/.config/helix/languages.toml 2>/dev/null; then
# cat >> ~/.config/helix/languages.toml << 'EOF'
# [[language]]
# name = "bash"
# file-types = ["sh", "bash"]
# language-servers = ["bash-language-server"]
# formatter = { command = "prettier", args = ["--parser", "bash"] }
# auto-format = true
# EOF
# fi