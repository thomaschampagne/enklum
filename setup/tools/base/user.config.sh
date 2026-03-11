#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

### Configure .bashrc ###

# - Apppend Mise shims activation...
echo 'eval "$(mise activate --shims)"' >> ~/.bashrc

# - Append starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# - Append zoxide
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc

echo 'git config --global user.name "${GIT_NAME}"' >> ~/.bashrc
echo 'git config --global user.email "${GIT_EMAIL}"' >> ~/.bashrc

# - Load bashrc for next steps
source ~/.bashrc

### Tools config ###
# Configure zoxide
zoxide add /${DEFAULT_WORKSPACE_DIR}
zoxide add ~/.config

# Configure starship theme w/ "gruvbox"
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Configure Git
git config --global --add safe.directory '*'
git config --global init.defaultBranch main