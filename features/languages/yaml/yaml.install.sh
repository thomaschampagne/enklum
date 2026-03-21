#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install Runtime
mise use -g node@lts

# Required dependencies
npm install -g npm@latest

# Install YAML LSP
npm install -g yaml-language-server@latest

# Force npm cache clean
npm cache clean --force