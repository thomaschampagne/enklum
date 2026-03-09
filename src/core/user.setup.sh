#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

### Configure .bashrc ###
# Zoxide
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
# Mise
echo 'export PATH="$PATH:~/.local/share/mise/shims/"' >> ~/.bashrc

# Git
echo 'git config --global user.name "${GIT_NAME}"' >> ~/.bashrc
echo 'git config --global user.email "${GIT_EMAIL}"' >> ~/.bashrc

# Load bashrc
source ~/.bashrc

### Configure zoxide ###
# TODO add at later stage: zoxide add /${DEFAULT_WORKSPACE_DIR}

### Git config ###
git config --global --add safe.directory '*'
git config --global init.defaultBranch main

### Mise core config ###
mise use -g bun@latest
