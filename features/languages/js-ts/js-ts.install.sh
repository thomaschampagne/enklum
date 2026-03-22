#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Require node install
require_feature "../../runtimes/node-lts/node-lts.install.sh"

# Required dependencies
npm install -g \
  typescript@latest \
  typescript-language-server@latest \
  prettier@latest

# Force npm cache clean
npm cache clean --force


# DAP config ---
mise use -g 'github:microsoft/vscode-js-debug[asset_pattern=js-debug-dap-v*.tar.gz]'
# ---

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

