#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install Runtime
mise use -g node@lts

# Required dependencies
npm install -g npm@latest

# Force npm cache clean
npm cache clean --force
