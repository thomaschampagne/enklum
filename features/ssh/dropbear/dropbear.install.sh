#!/bin/bash

set -euo pipefail

# Load requirements
source /enklum/feats.require.sh

# Install dropbear
sudo dnf install -y dropbear

# Setup SSH directory and keys as the target user
SSH_DIR="/home/${ENKLUM_USERNAME}/.ssh"
PRIVATE_KEY="${SSH_DIR}/enklum_dropbear"
PUBLIC_KEY="${SSH_DIR}/enklum_dropbear.pub"
AUTHORIZED_KEYS="${SSH_DIR}/authorized_keys"

# Create .ssh directory as root first, then fix ownership
mkdir -p "${SSH_DIR}"

# Generate dropbear-format key pair
dropbearkey -t ed25519 -f "${PRIVATE_KEY}"

# Extract public key in OpenSSH format
dropbearkey -y -f "${PRIVATE_KEY}" | grep "^ssh-" > "${PUBLIC_KEY}"

# Add public key to authorized_keys
cat "${PUBLIC_KEY}" >> "${AUTHORIZED_KEYS}"

# Fix ownership and permissions on all generated files
chown -R ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} "${SSH_DIR}"
chmod 700 "${SSH_DIR}"
chmod 600 "${PRIVATE_KEY}" "${AUTHORIZED_KEYS}"
chmod 644 "${PUBLIC_KEY}"
