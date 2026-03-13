#!/bin/zsh

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

# Load zshrc
source ~/.zshrc

### Tool Installs ###
# - Mise @see https://mise.jdx.dev/registry.html
# -- Base dev cli tools (Mise)
mise use -g sd ripgrep fzf zoxide starship

# -- Base dev tools (Mise)
mise use -g helix neovim lazygit yazi zellij opencode # TODO Fix zellij config not applied 

# -- Base Runtimes (Mise)
mise use -g \
  node@lts
  # TODO Add these runtime on user defined installs: bun \
  # TODO Add these runtime on user defined installs: rust \
  # TODO Add these runtime on user defined installs: go \
  # TODO Add these runtime on user defined installs: python uv \
  # TODO Add these runtime on user defined installs: java@openjdk-25  # TODO Too much space required ?

# - Base Npm Tools
# -- Tools required for development (npm)
npm install -g npm@latest
npm add -g \
  typescript \
  prettier

### Base Lsp Installs ### (for editors like helix https://github.com/helix-editor/helix/wiki/Language-Server-Configurations)
# - Mise
mise use -g marksman

# - Npm
# -- LSPs JSON, Yaml, TS (npm) 
npm add -g \
  vscode-langservers-extracted \
  yaml-language-server \
  typescript-language-server