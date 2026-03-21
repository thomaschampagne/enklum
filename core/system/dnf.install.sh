#!/bin/bash

set -euo pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" as \"$(whoami)\" user"
echo "============================================================"

### Apply core installs ###
echo "Install base packages"
dnf install -y --setopt=install_weak_deps=False \
  sudo \
  hostname \
  coreutils \
  ncurses \
  libicu \
  util-linux \
  shadow-utils \
  gcc \
  gettext \
  less \
  tree \
  which \
  findutils \
  procps-ng \
  psmisc \
  bind-utils \
  iproute \
  iputils \
  traceroute \
  nmap \
  netcat \
  tcpdump \
  file \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  nano \
  vim \
  emacs \
  tar \
  gzip \
  unzip \
  7zip \
  git-core \
  openssl \
  curl \
  wget \
  jq \
  yq \
  btop \
  ncdu

echo "Removing unnecessary packages..."
dnf autoremove -y

echo "Cleaning up..."
dnf clean all -y

# Install mise globally
curl https://mise.run | MISE_INSTALL_PATH=/usr/local/bin/mise sh