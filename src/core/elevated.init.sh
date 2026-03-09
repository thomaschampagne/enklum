#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

### Assert Envs Properly set ###
: "${SYSTEM_USERNAME:?Environment variable SYSTEM_USERNAME is not set}"
: "${DEFAULT_WORKSPACE_DIR:?Environment variable DEFAULT_WORKSPACE_DIR is not set}"

### Add repos ###
dnf copr enable jdxcode/mise -y # Mise

### Apply Updates ###
echo "Apply updates"
dnf upgrade -y

### Apply core installs ###
    # ripgrep file fzf fd zoxide \ # TODO Load file fzf fd zoxide from mise ?
echo "Install base core packages"
dnf install -y --setopt=install_weak_deps=False \
    hostname coreutils util-linux sudo shadow-utils gettext dos2unix \
    less tree which findutils \
    procps-ng psmisc \
    bind-utils iproute iputils traceroute nmap netcat \
    file \
    nano vim \
    unzip 7zip \
    git-core \
    openssl curl wget \
    jq yq \
    btop htop \
    mise

echo "Removing unnecessary packages..."
dnf autoremove -y

echo "Cleaning up..."
dnf clean all -y

# Create the main user
useradd -m -d /home/${SYSTEM_USERNAME} -s /bin/bash -G wheel ${SYSTEM_USERNAME}

# Add workspace dir
mkdir -p ${DEFAULT_WORKSPACE_DIR}
chown -R ${SYSTEM_USERNAME}:${SYSTEM_USERNAME} ${DEFAULT_WORKSPACE_DIR}

# Allow to execute sudo without a password
echo "${SYSTEM_USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${SYSTEM_USERNAME}
chmod 0440 /etc/sudoers.d/${SYSTEM_USERNAME}

# Configure core
runuser -u ${SYSTEM_USERNAME} -- bash "$(dirname "$0")/user.setup.sh"

echo "============================================================"
echo "END"
echo "============================================================"
