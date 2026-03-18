#!/bin/bash

set -e
set -o pipefail

# Base Cli Tools
mise use -g \
  sd@latest \
  ripgrep@latest \
  fzf@latest \
  zoxide@latest

# Base Tools
mise use -g \
  helix@latest \
  neovim@latest \
  lazygit@latest \
  just@latest \
  yazi@latest \
  zellij@latest \
  opencode@latest

# LSP
mise use -g marksman@latest

# Clear cache
mise cache clear

# Assert mise working properly setup
# mise doctor