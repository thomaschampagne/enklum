#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install Runtime
mise use -g node@lts

# Required dependencies
npm install -g \
  typescript@latest \
  typescript-language-server@latest \
  prettier@latest

# Force npm cache clean
npm cache clean --force

# Helix language config
if ! grep -q 'name = "typescript"' ~/.config/helix/languages.toml 2>/dev/null; then
cat >> ~/.config/helix/languages.toml << 'EOF'
[[language]]
name = "typescript"
language-servers = ["typescript-language-server"]
formatter = { command = "prettier", args = ["--parser", "typescript"] }
auto-format = true

[[language]]
name = "javascript"
language-servers = ["typescript-language-server"]
formatter = { command = "prettier", args = ["--parser", "typescript"] }
auto-format = true
EOF
fi