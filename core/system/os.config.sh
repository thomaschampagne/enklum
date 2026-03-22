#!/bin/bash

set -euo pipefail

### Assert Envs Properly set ###
: "${ENKLUM_USERNAME:?Environment variable ENKLUM_USERNAME is not set}"
: "${ENKLUM_WORKSPACE_DIR:?Environment variable ENKLUM_WORKSPACE_DIR is not set}"

# Create the main user
useradd -m -d /home/${ENKLUM_USERNAME} -s /bin/zsh -G wheel ${ENKLUM_USERNAME}

# Add workspace dir
mkdir -p ${ENKLUM_WORKSPACE_DIR}
chown -R ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} ${ENKLUM_WORKSPACE_DIR}

# Delete user password & allow to execute sudo without a password
passwd -d ${ENKLUM_USERNAME}
echo "${ENKLUM_USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${ENKLUM_USERNAME}
chmod 0440 /etc/sudoers.d/${ENKLUM_USERNAME}

