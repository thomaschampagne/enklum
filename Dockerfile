FROM fedora:latest

# Metadata
LABEL maintainer="Engineer"
LABEL description="Fedora dev env: Helix, Yazi, Node.js LTS"

# 1. Install system dependencies, Node.js LTS, and Helix
# Yazi is available in Fedora official repos or via Copr/Cargo as of 2026

# TODO Run dnf copr enable jdxcode/mise

# TODO Run dnf install mise

RUN dnf copr enable lihaohong/yazi -y
RUN dnf update -y && \
    dnf install -y \
    dos2unix \
    vim \
    nano \
    helix \
    gettext \
    openssl \
    curl \
    jq \
    yq \
    nodejs \
    npm \
    btop htop \
    yazi \
    git \
    ncurses \
    file \
    && dnf clean all

# 2. Terminal Color Support (True Color / 24-bit)
# Critical for Helix and Yazi UI rendering
ENV TERM=xterm-256color
ENV COLORTERM=truecolor
ENV LANG=en_US.UTF-8

# 3. Create 'dev' user (UID 1000 is standard for host-container mapping)
RUN useradd -m -s /bin/bash dev
USER dev
WORKDIR /home/dev

# 4. Minimal Helix configuration for a better out-of-the-box experience
RUN mkdir -p /home/dev/.config/helix && \
    echo -e '[editor]\ntrue-color = true\nmouse = true\n\n[theme]\nname = "catppuccin_mocha"' > /home/dev/.config/helix/config.toml

# Default command: opens Yazi (great entry point to navigate and then hx files)
CMD ["bash"]
# CMD ["yazi"]
