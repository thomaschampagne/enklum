#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Run remote installer
curl -s https://ohmyposh.dev/install.sh | bash -s

# Configure shell
echo -e '\n# Append Oh My Posh configuration' >> ~/.zshrc
# - Append oh-my-to PATH
echo 'export PATH=$PATH:/home/smith/.local/bin' >> ~/.zshrc
# - Append to .zshrc
echo 'eval "$(oh-my-posh init zsh)"' >> ~/.zshrc