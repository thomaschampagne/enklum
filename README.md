# 📦 Enklum

<!--toc:start-->
- [📦 Enklum](#📦-enklum)
  - [Build](#build)
  - [Run (Interactive with TTY)](#run-interactive-with-tty)
<!--toc:end-->

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

<!--
# TODOs

## Docker and System
- [ ] Reduce Docker image size: follow [Perplexity guide](https://www.perplexity.ai/search/how-to-reduce-size-of-docker-i-TsULWmUnSVOjoZePAW6jtw)
- [ ] Set a custom hostname for the environment
- [ ] Test mounting a volume to `/home/$user` to persist user data
- [ ] Decide on remote access strategy (SSH server for VS Code or `code-server`)
- [ ] Create a `docker-compose.yml` as a sample
- [ ] Add ssh server access
- [ ] Add entrypoint script that run zellij by default

## CLI and Shell
- [ ] Configure `starship` environment to choose a template preset
- [ ] Add Emacs via `dnf`
- [ ] Add a disk usage analyzer like `ncdu` or `dust`

## Helix Editor
- [ ] Map custom Helix configurations
- [ ] Set up language servers for base runtimes
- [ ] Integrate `yazi` file manager with Helix]
- [ ] Map lazygit editor to helix

## Project and CI/CD
- [ ] Rename project to "enklum" (reference to "enclume" in French)
- [ ] Set up GitHub CI workflows
- [ ] Write a comprehensive README

### Notes
- **JetBrains Mono**: You do not need to install this inside the container. As long as your host terminal or local VS Code uses the font, the container will display it correctly.## Todo
-->
