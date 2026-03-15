#!/bin/zsh

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" as \"$(whoami)\" user"
echo "============================================================"

#### .zshrc setup ####

# - Append starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# - Append zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

# - Git default username & email
echo 'git config --global user.name "${ENKLUM_GIT_USER_NAME}"' >> ~/.zshrc
echo 'git config --global user.email "${ENKLUM_GIT_USER_EMAIL}"' >> ~/.zshrc

# - reload zshrc for next steps
source ~/.zshrc

#### Tools config ####
# Configure zoxide
zoxide add /${ENKLUM_WORKSPACE_DIR}
zoxide add ~/.config

# Configure starship theme w/ "gruvbox"
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Configure Git
git config --global --add safe.directory '*'
git config --global init.defaultBranch main
git config --global core.autocrlf true # Ensure skip LF vs CRLF comparison
