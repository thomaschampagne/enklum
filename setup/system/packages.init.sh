#!/bin/bash

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

### Add external repos ###
dnf copr enable jdxcode/mise -y # Mise

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
  nano \
  vim \
  unzip \
  7zip \
  git-core \
  openssl \
  curl \
  wget \
  jq \
  yq \
  btop \
  htop \
  mise

# FIXME "clear" command not working
# TODO support zsh later by default 

echo "Removing unnecessary packages..."
dnf autoremove -y

echo "Cleaning up..."
dnf clean all -y