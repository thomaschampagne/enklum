#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

# Installs 
# @see https://mise.jdx.dev/registry.html

# - Base dev cli tools
mise use -g sd ripgrep fzf zoxide starship && \

# - Base dev tools
mise use -g helix neovim lazygit yazi zellij opencode && \
    
# - Runtimes
mise use -g \
  bun \
  node@lts \
  rust \
  go \
  python uv
  # java@openjdk-25  # TODO Too much space required ?

# Npm tools required for development
npm install -g npm@latest
npm add -g prettier

# LSPs for terminal editors (e.g. Helix)
# - Markdown
mise use -g marksman

# - JSON, Yaml, TS
npm add -g \
  vscode-json-language-server \
  yaml-language-server \
  typescript-language-server

# TODO LSP w/ helix health + formatter + debug OK
# mise use -g marksman
# bun add -g typescript-language-server
