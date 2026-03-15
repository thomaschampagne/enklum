<pre align="center">
  
██████ ███  ██ ██ ▄█▀ ██     ██  ██ ██▄  ▄██ 
██▄▄   ██ ▀▄██ ████   ██     ██  ██ ██ ▀▀ ██ 
██▄▄▄▄ ██   ██ ██ ▀█▄ ██████ ▀████▀ ██    ██ 
  
A portable Fedora terminal-driven development forge
</pre>

From the French word **"enclume"** for **anvil** is a ready-to-use containerized development environment on Fedora. It provides a terminal-first forge with all the tools developers need to code, debug, and ship without the hassle of setting up a new machine.

## 🛠️ Why ENKLUM?

- **Portable** — Runs anywhere Docker/Podman/K8s/... runs
- **Terminal-first** — ZSH, Starship prompt, Zellij, Helix/Neovim, Yazi, and keyboard-driven tools
- **Batteries included** — Dev tools, network utilities, and monitoring out of the box
- **Extensible** — Add languages and runtimes with a single command via mise

## Why not devcontainers

<!-- TODO Merge with Why ENKLUM? -->

[Dev Containers](https://containers.dev/) (formerly Remote - Containers) are great for project-specific, VS Code / JetBrains centric development environments. ENKLUM takes a different approach:

| Feature | Dev Containers | ENKLUM |
| ------- | --------------- | ------ |
| **Editor/IDE** | Requires VS Code / JetBrains | Works with any editor (Helix, Neovim, Emacs, etc.) |
| **Use case** | Project-specific setup | Personal, cross-project development environment |
| **Tool management** | Per-project `.devcontainer.json` | [mise](https://mise.run/) for global tool versioning |
| **Base image** | You build from scratch each time | Pre-built, customizable base image |
| **Workflow** | Attach to container per project | Run your environment anywhere |

### When to choose ENKLUM

- You prefer terminal-driven workflows (ZSH, Zellij, Helix/Neovim)
- You want a consistent personal environment across machines and projects
- You need a portable dev environment that works with Docker, Podman, or Kubernetes
- You want full control over your toolchain with mise

### When devcontainers make sense

- Your team requires VS Code with standardized project configurations
- The project has specific container requirements checked in with the code
- You need tight VS Code extension integration

## 📋 Prerequisites

### Nerd Font Required

ENKLUM uses [Nerd Fonts](https://www.nerdfonts.com/) for icons and glyphs in the prompt and UI. Install a Nerd Font and configure your terminal to use it.

## 🚀 Quick Start

### Run the Container

```bash
podman run -it --hostname enklum enklum
```

### Build the Image

```bash
./image.build.sh
```

Or with custom options:

```bash
./image.build.sh --image-name my-dev-env --image-tag v1.0
```

### Mount Your Workspace

```bash
podman run -it --hostname enklum -v $(pwd):/workspace enklum
```

## 📦 What's Included

| Category | Package                             | Source | Description               |
| -------- | ----------------------------------- | ------ | ------------------------- |
| Archive  | 7zip                                | dnf    | 7z, zip, tar compression. |
| Archive  | unzip                               | dnf    | ZIP extraction.           |
| Build    | gcc                                 | dnf    | C/C++ compiler.           |
| Cli      | file                                | dnf    | File type detection.      |
| Cli      | fzf                                 | mise   | Fuzzy finder.             |
| Cli      | jq                                  | dnf    | JSON processor.           |
| Cli      | ripgrep                             | mise   | Fast text search.         |
| Cli      | sd                                  | mise   | Modern sed replacement.   |
| Cli      | starship                            | mise   | Customizable prompt.      |
| Cli      | yq                                  | dnf    | YAML processor.           |
| Cli      | zoxide                              | mise   | Smart cd navigation.      |
| Cli      | zsh                                 | dnf    | Advanced shell.           |
| DevTool  | git-core                            | dnf    | Git core tools.           |
| DevTool  | lazygit                             | mise   | Git TUI interface.        |
| DevTool  | opencode                            | mise   | Ai coding agent.          |
| Editors  | emacs                               | dnf    | Extensible editor.        |
| Editors  | helix                               | mise   | Rust modal editor.        |
| Editors  | nano                                | dnf    | Simple terminal editor.   |
| Editors  | neovim                              | mise   | Modern extensible Vim.    |
| Editors  | vim-enhanced                        | dnf    | Vim with scripting.       |
| LSP      | marksman                            | mise   | Markdown language server. |
| LSP      | typescript-language-server          | npm    | TypeScript LSP.           |
| LSP      | vscode-langservers-extracted        | npm    | HTML/CSS/JSON LSPs.       |
| LSP      | yaml-language-server                | npm    | YAML language server.     |
| LSP Dep  | prettier                            | npm    | Code formatter.           |
| LSP Dep  | typescript                          | npm    | TypeScript compiler.      |
| Monitor  | btop                                | dnf    | Resource monitor.         |
| Monitor  | htop                                | dnf    | Process monitor.          |
| Network  | netcat                              | dnf    | Network connections.      |
| Network  | nmap                                | dnf    | Network scanner.          |
| Network  | tcpdump                             | dnf    | Packet analyzer.          |
| Network  | traceroute                          | dnf    | Network route tracing.    |
| Runtime  | node                                | mise   | JavaScript runtime.       |
| System   | dos2unix                            | dnf    | Line ending converter.    |
| System   | ncdu                                | dnf    | Disk usage analyzer.      |
| System   | tree                                | dnf    | Directory tree view.      |
| Terminal | yazi                                | mise   | TUI file manager.         |
| Terminal | zellij                              | mise   | Terminal multiplexer.     |

## 🧰 ENKLUM CLI

ENKLUM includes a built-in CLI tool for common tasks:

```bash
enklum
```

Output:

```bash
Usage:  [OPTION]

Options:
  --update       Update system packages including mise
  --list-pkgs    List available packages & tools
  --help         Show this help message and exit
```

## ⚙️ Customize the Image

### Environment Variables

Copy `.env.sample` to `.env` and customize:

```bash
cp .env.sample .env
```

| Variable | Default | Description |
|----------|---------|-------------|
| `ENKLUM_GIT_USER_NAME` | `Smith Black` | Git user name |
| `ENKLUM_GIT_USER_EMAIL` | <smith@enklum.dev> | Git user email |
| `ENKLUM_DEFAULT_EDITOR` | `hx` | Default editor (`hx`, `nvim`, `emacs`, `nano`, `vi`) |
| `TZ` | Europe/Paris | Timezone |

### Custom Username

The default user is **smith** (paying homage to the blacksmith and anvil heritage). You can change it at build time via `argfile.default.conf`:

```bash
ENKLUM_USERNAME=myuser
ENKLUM_WORKSPACE_DIR=/home/myuser/workspace
```

### Add Languages & Tools with mise

ENKLUM uses [mise](https://mise.run/) to manage runtimes and tools. The default configuration is in `setup/resources/home/.config/mise/config.toml`.

```bash
# Add a new language
mise use -g go@latest
mise use -g rust@latest
mise use -g java@latest
mise use -g bun@latest
mise use -g deno@latest

# Install additional tools
mise install -g terraform
mise install -g kubectl
mise install -g docker
```

### Extend the Base Image

After customizing, copy your mise config to extend the base image:

```dockerfile
FROM enklum:latest

COPY ./mise/config.toml /home/smith/.config/mise/config.toml

USER smith
RUN mise install
```

Then build your custom image:

```bash
podman build -t my-custom-enklum .
```

## 📜 License

MIT License — see [LICENSE](LICENSE) file.

<!--
# Backlog
## Docker and System
- [ ] Test mounting a volume to `/home/$user` to persist user data @P2
- [ ] Create a `docker-compose.yml` as a sample
- [ ] Add ssh server access @P2

## CLI and Shell
- [ ] Configure `starship` environment to choose a template preset @P2
- [ ] Add git-crypt ?
- [ ] Add ohmyposh support (https://ohmyposh.dev/docs/themes) @P2

## Helix Editor
- [x] Map custom Helix configurations
- [ ] Set up language servers for base runtimes
- [ ] Integrate `yazi` file manager with Helix => Open Yazi when opening helix file explorer
- [x] Map lazygit editor to helix

## Project and CI/CD
- [ ] Easy user custom tools & config from base tools+config => Will be improved later with mise env files ? @P1
- [ ] Set up GitHub CI workflows @P1
- [ ] Write a comprehensive README @P1
- [ ] Fix wrong time in container
- [ ] rename zsh script extension as .zsh @P2
- [ ] Once stable recreate bare empty enklum github project

### Notes
- **JetBrains Mono**: You do not need to install this inside the container. As long as your host terminal or local VS Code uses the font, the container will display it correctly.
-->
