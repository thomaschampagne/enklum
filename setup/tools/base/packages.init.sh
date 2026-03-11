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
mise use -g helix neovim lazygit yazi zellij opencode

# -- Runtimes (Mise)
mise use -g \
  bun \
  node@lts \
  rust \
  go \
  python uv
  # java@openjdk-25  # TODO Too much space required ?

# - Npm 
# -- Tools required for development (npm)
npm install -g npm@latest
npm add -g prettier

### Lsp Installs ### (for editors like helix https://github.com/helix-editor/helix/wiki/Language-Server-Configurations)
# - Mise
mise use -g marksman

# - Npm
# -- LSPs JSON, Yaml, TS (npm) 
npm add -g \
  vscode-langservers-extracted \
  yaml-language-server \
  typescript-language-server