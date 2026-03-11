#!/bin/zsh

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

#### .zshrc setup ####

# - Append Mise shims activation...
# echo 'eval "$(mise activate --shims)"' >> ~/.zshrc

# - Append starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# - Append zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

# - Git default username & email
echo 'git config --global user.name "${GIT_NAME}"' >> ~/.zshrc
echo 'git config --global user.email "${GIT_EMAIL}"' >> ~/.zshrc

# - Append bun binaries
echo 'export PATH="$PATH:~/.bun/bin"' >> ~/.zshrc

# - Load zshrc for next steps
source ~/.zshrc

#### Tools config ####
# Configure zoxide
zoxide add /${DEFAULT_WORKSPACE_DIR}
zoxide add ~/.config

# Configure starship theme w/ "gruvbox"
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Configure Git
git config --global --add safe.directory '*'
git config --global init.defaultBranch main
