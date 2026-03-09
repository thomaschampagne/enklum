# 📦 Kajko TODO Rename to Takua ???


> **The ultimate portable forge for terminal-driven developers.**

**Kajko** (from *Kaji* 鍛冶 / Forge + *Hako* 箱 / Box) is a zero-compromise, polyglot development container. It provides a heavily customized, terminal-first environment powered by Neovim and [mise](https://github.com/jdx/mise) for seamless toolchain management.

Whether you write Rust, Go, Java, .NET, TypeScript, or all of the above, Kajko gives you a reproducible, blazing-fast workspace right out of the box.

<!-- ---

## ✨ Features

- **Terminal-First Workflow:** Pre-configured with Neovim, `jq`, `curl`, and `elinks`.
- **Toolchain Magic with `mise`:** Instantly install and manage Bun, Deno, and language runtimes (Rust, Go, Java, .NET, Node/TS) without polluting the system.
- **Polyglot LSPs:** All Language Server Protocols are ready to serve your Neovim setup.
- **Docker-in-Docker (DinD):** Full Docker daemon support inside your devcontainer.
- **Customizable at Build:** Easily tweak the `.mise.toml` to match your exact project requirements before building the container.

## 🚀 Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) / Podman
 -->
 
---

## Build

podman build -t kajko .

## Run (Interactive with TTY)

podman run -it --hostname my-kajko -u kajko -v ${pwd}:/home/kajko/workspace kajko
<!-- podman run -it --hostname my-kajko kajko -->
<!-- podman run -it -v $(pwd):/home/dev/workspace kajko -->

## IDEAS Todo

- Jetbrain Mono

- programs:
  - neovim
  - opencode
  - yazy => helix
  - fd, fzf, others usefull
  - lazygit
  - zellij
  - jq + yq
  - check minikit
  - list here : https://yazi-rs.github.io/docs/installation/#copr
  - ripgrep
  
- set an hostname
- drop dev user password for sudos ok
- runtimes
  - bunjs
  - node
  - java
  - rust
  - golang
  - python

- helix
  - map custom configs
  - languages
    - ..
    - ...

- git config:
  - dont break git ending

- doc:
  - run on networks host for ports
