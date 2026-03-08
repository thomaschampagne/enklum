# 📦 Kajko

> **The ultimate portable forge for terminal-driven developers.**

**Kajko** (from *Kaji* 鍛冶 / Forge + *Hako* 箱 / Box) is a zero-compromise, polyglot development container. It provides a heavily customized, terminal-first environment powered by Neovim and [mise](https://github.com/jdx/mise) for seamless toolchain management.

Whether you write Rust, Go, Java, .NET, TypeScript, or all of the above, Kajko gives you a reproducible, blazing-fast workspace right out of the box.

---

## ✨ Features

- **Terminal-First Workflow:** Pre-configured with Neovim, `jq`, `curl`, and `elinks`.
- **Toolchain Magic with `mise`:** Instantly install and manage Bun, Deno, and language runtimes (Rust, Go, Java, .NET, Node/TS) without polluting the system.
- **Polyglot LSPs:** All Language Server Protocols are ready to serve your Neovim setup.
- **Docker-in-Docker (DinD):** Full Docker daemon support inside your devcontainer.
- **Customizable at Build:** Easily tweak the `.mise.toml` to match your exact project requirements before building the container.

## 🚀 Getting Started

### Prerequisites
- [Docker](https://www.docker.com/) / Docker Desktop
- [Visual Studio Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) (or any CLI devcontainer implementation like `devcontainer-cli`).

### Usage

1. **Clone the repository or add it to your project:**
   Copy the `.devcontainer` folder into the root of your existing project.

2. **Customize your tools (Optional):**
   Edit the `.mise.toml` file to add, remove, or pin specific versions of your favorite tools and languages.

3. **Reopen in Container:**
   Open the command palette in VS Code (`Ctrl+Shift+P` / `Cmd+Shift+P`) and select **Dev Containers: Reopen in Container**.

4. **Start Coding:**
   Once built, type `nvim` in the terminal and enjoy your new forge!

## 📁 Repository Structure

```text
kajko/
├── .devcontainer/
│   ├── devcontainer.json   # Main devcontainer configuration
│   └── Dockerfile          # Base OS and core system dependencies
├── .config/
│   └── nvim/               # Pre-baked Neovim configuration
├── .mise.toml              # Toolchain definition (Bun, Deno, Rust, Go, etc.)
└── README.md

 
---

# Doc

## Build
podman build -t fedora-dev .

## Run (Interactive with TTY)
podman run -it --rm -v $(pwd):/home/dev/workspace fedora-dev

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
