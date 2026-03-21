#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install Runtime
mise use -g node@lts

# Required dependencies
npm install -g npm@latest

# Install JSON LSP
npm install -g vscode-langservers-extracted@latest

# Force npm cache clean
npm cache clean --force