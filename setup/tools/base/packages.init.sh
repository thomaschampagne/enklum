#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

# Mise Installs (@see https://mise.jdx.dev/registry.html)

# - Base dev cli tools
mise use -g sd ripgrep fzf zoxide starship && \

# - Base dev tools
mise use -g helix neovim lazygit yazi zellij && \
    
# Runtimes
mise use -g \
  bun \
  rust \
  go \
  python
  # TODO Add node + java@openjdk-25 \ 

# TODO LSP w/ helix health + formatter + debug OK
# mise use -g marksman
# bun add -g typescript-language-server

# TODO Add ~/.bun/bin to PATH

# TODO Add opencode