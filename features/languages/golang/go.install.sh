#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install Runtime
mise use -g go@latest

# Required dependencies
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install mvdan.cc/gofumpt@latest

# Clean cache to reduc image size
go clean -cache -modcache -testcache

# Helix language config
if ! grep -q 'name = "go"' ~/.config/helix/languages.toml 2>/dev/null; then
cat >> ~/.config/helix/languages.toml << 'EOF'
[[language]]
name = "go"
auto-format = true
formatter = { command = "gofumpt" }
language-servers = ["gopls"]

[language-server.gopls.config]
gofumpt = true
staticcheck = true
vulncheck = "Imports"
usePlaceholders = true
completeUnimported = true

EOF
fi