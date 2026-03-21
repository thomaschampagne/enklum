#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Require node install
require_feature "../../runtimes/node-lts/node-lts.install.sh"

# Install YAML LSP
npm install -g yaml-language-server@latest

# Force npm cache clean
npm cache clean --force