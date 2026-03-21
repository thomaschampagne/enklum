#!/bin/bash

set -e
set -o pipefail

# Ensure mise is loaded in PATH
eval "$(mise activate --shims)"

# Zoxide default config
# - Add workspace root directory
zoxide add /${ENKLUM_WORKSPACE_DIR}
# - Add user config directory
zoxide add ~/.config