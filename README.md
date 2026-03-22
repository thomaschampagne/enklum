<pre align="center" style="color: lawngreen; background-color: black">

|\ | \  / | |    
| \|  \/  | |___ 

A Portable Terminal Development Environment
</pre>

# NVIL: Portable Terminal-Driven Development Environment

NVIL (from the word **Anvil**) is a ready-to-use containerized development environment built on Fedora. It provides a terminal-first development workspace with pre-configured tools, so you can start coding immediately without setting up a new machine.

## ✨ Key Features

- **Portable** - Runs anywhere Docker, Podman, or Kubernetes runs
- **Terminal-first** - ZSH, Zellij, Helix/Neovim, Yazi, and keyboard-driven tools
- **Batteries included** - Dev tools, network utilities, and monitoring out of the box
- **Extensible** - Add languages and runtimes with a single command via [mise](https://mise.jdx.dev/)

## 🎯 Why Use NVIL?

### For developers who want

- Terminal-driven workflows (ZSH, Zellij, Helix/Neovim, Lazygit, ...)
- A consistent personal dev environment across machines and per projects build from a flavor build from `ghcr.io/thomaschampagne/enklum-core` image.
- A portable dev environment that works with Docker, Podman, or Kubernetes
- Full control over their toolchain with `fedora` with [mise](https://mise.jdx.dev/) included.

### How it compares to Dev Containers

| | Dev Containers | NVIL |
| --- | --- | --- |
| **Editor** | Requires VS Code / JetBrains | Works any modal editor |
| **Scope** | Per-project configuration | Per-project, cross-project or personal environment |
| **Tool management** | `.devcontainer.json` per project | Full control with `dnf` & `mise` |
| **Base image** | Built from scratch each time | Pre-built, customizable image |
| **Workflow** | Attach to container per project | Your environment, anywhere |

## 🚀 Getting Started

### Prerequisites

1. **Container runtime** - Install [Podman](https://podman.io/) or [Docker](https://www.docker.com/)
2. **Nerd Font** - Install a [Nerd Font](https://www.nerdfonts.com/) and configure your terminal to use it (required for icons)

### Option 1: Quick Start with Compose

- Copy the environment file:

```bash
cp .env.sample .env
```

- Start and connect:

```bash
podman compose -f ./sample.compose.yaml down  # Stop any existing containers
podman compose -f ./sample.compose.yaml up -d # Start the environment
podman exec -it enklum-full zsh -ic zellij    # Connect via Zellij. 
```

### Option 2: Use the Shell Function (Recommended)

Add the `enklum` function to your shell profile for easier management:

**Bash (~/.bashrc):**

```bash
enklum() {
  local compose_file="./sample.compose.yaml"
  local service_name="enklum-full"
  local connect_cmd="zsh -ic zellij"
  local reset=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        echo "Usage: enklum [options]"
        echo "  -r, --reset        Reset: stop containers before starting"
        echo "  -p, --compose      Compose file path (default: ./sample.compose.yaml)"
        echo "  -s, --service       Service name (default: enklum-full)"
        echo "  -c, --cmd           Connect command (default: 'zsh -ic zellij')"
        echo "  -h, --help          Show this help"
        return 0
        ;;
      -r|--reset) reset=true; shift ;;
      -p|--compose) compose_file="$2"; shift 2 ;;
      -s|--service) service_name="$2"; shift 2 ;;
      -c|--cmd) connect_cmd="$2"; shift 2 ;;
      *) shift ;;
    esac
  done

  if $reset; then
    echo ">> Stopping containers..."
    podman compose -f "$compose_file" down || return 1
  fi
  echo ">> Starting $compose_file..."
  podman compose -f "$compose_file" up -d || return 1
  echo ">> Connecting to $service_name..."
  podman exec -it "$service_name" $connect_cmd
}
```

**PowerShell (~/.config/powershell/Microsoft.PowerShell_profile.ps1):**

```powershell
function enklum {
  param(
    [switch]$Reset,
    [switch]$Help,
    [string]$ComposeFile = "./sample.compose.yaml",
    [string]$ServiceName = "enklum-full",
    [string]$ConnectCmd = "zsh -ic zellij"
  )
  
  if ($Help) {
    Write-Host "Usage: enklum [options]"
    Write-Host "  -r, --reset        Reset: stop containers before starting"
    Write-Host "  -p, --compose      Compose file path (default: ./sample.compose.yaml)"
    Write-Host "  -s, --service       Service name (default: enklum-full)"
    Write-Host "  -c, --cmd           Connect command (default: 'zsh -ic zellij')"
    Write-Host "  -h, --help          Show this help"
    return
  }
  
  if ($Reset) {
    Write-Host ">> Stopping containers..." -ForegroundColor Yellow
    podman compose -f $ComposeFile down
    if ($LASTEXITCODE -ne 0) { return 1 }
  }
  
  Write-Host ">> Starting $ComposeFile..." -ForegroundColor Green
  podman compose -f $ComposeFile up -d
  
  if ($LASTEXITCODE -ne 0) { return 1 }
  Write-Host ">> Connecting to $ServiceName..." -ForegroundColor Cyan
  Invoke-Expression "podman exec -it $ServiceName $ConnectCmd"
}
```

Then use:

```bash
enklum              # Start and connect
enklum -r           # Reset (stop existing) and connect
enklum -h           # Show help
```

### Option 3: Run a Standalone Container

Mount your workspace directly:

```bash
podman run -it --hostname enklum -v $(pwd):/workspace ghcr.io/thomaschampagne/enklum-full:latest
```

## 📦 What's Included

### Core Packages

"NVIL core" comes pre-configured with a comprehensive set of tools:

| Category | Package | Description |
|----------|---------|-------------|
| **Code Editors** | Helix, Neovim, Emacs (Vim, Nano) | Multiple terminal editors to choose from |
| **Terminal** | ZSH, Zellij, Yazi | Shell, multiplexer, and file manager |
| **CLI Tools** | fzf, ripgrep, jq, yq, sd, zoxide | Modern command-line utilities |
| **Dev Tools** | Git, Lazygit | Version control and runtime |
| **AI Tools** | opencode | AI coding agent |
| **LSP** | Markdown | Language servers for IDE features |
| **Monitoring** | btop | Resource and process monitoring |
| **Network** | nmap, netcat, tcpdump, traceroute | Network diagnostics |
| **Archive** | 7zip, unzip, tar, gzip | Compression utilities |
| **Build** | gcc | C/C++ compiler |

For a complete list, run `enklum --list-pkgs` inside the container.

### Full Packages

## 🧰 NVIL CLI

Inside the container, use the built-in CLI for common tasks:

```bash
enklum --help
```

```text
Usage: enklum [OPTION]

Options:
  --update       Update system packages including mise
  --list-pkgs    List available packages & tools
  --help         Show this help message and exit
```

## ⚙️ Customization

### Environment Variables

Copy `.env.sample` to `.env` and customize:

```bash
cp .env.sample .env
```

| Variable | Default | Description |
|----------|---------|-------------|
| `NVIL_GIT_USER_NAME` | `Smith Black` | Git user name |
| `NVIL_GIT_USER_EMAIL` | `smith@enklum.dev` | Git user email |
| `NVIL_DEFAULT_EDITOR` | `nvim` | Default editor (`hx`, `nvim`, `emacs`, `nano`, `vi`) |
| `TZ` | `Europe/Paris` | Timezone |

### Custom Username

The default user is **smith** (paying homage to the blacksmith and anvil heritage). Change it at build time via `args-build-file.default.conf`:

```bash
NVIL_USERNAME=myuser
NVIL_WORKSPACE_DIR=/workspace
```

### Build a Custom Image

Create a custom Dockerfile to add features:

```dockerfile
FROM ghcr.io/thomaschampagne/enklum-core:latest

# Copy wanted features
COPY ./features/oh-my-posh ~/.feats/oh-my-posh
COPY ./features/go ~/.feats/go

RUN bash /enklum/feats.install.sh --features-folder ~/.feats
```

Build it:

```bash
./image.build.sh
# Or with custom options:
./image.build.sh --image-name my-dev-env --image-tag v1.0
```

## 📜 License

MIT License - see [LICENSE](LICENSE) file.

<!--
# Backlog

## Triage

TODO Rename to "NVIL" for anvil? or NKLM or EKLM ?? => NVIL best ATM

| Nom  | Prononciation EN (facile ?)           | Prononciation FR | Lien avec "enclume"  |
| ---- | ------------------------------------- | ---------------- | -------------------- |
| eklm | "eck-lum" (moyen, "lm" dur) github    | "e-kelm"         | Direct d'"enklum"    |
| nklm | "nick-lum" (difficile, cluster "nkl") | "en-kelm"        | Indirect             |
| nvil | "an-vil" (très facile) github         | "en-vil"         | "Anvil" = enclume EN |

# TODO Install mise tools inside system and not under home ? to get mise tools integrity linked to each image build ???

# TODO DAP
- typescript

# TODO Formatter
- css + scss
- html

# TODO LSP
- dockerfile	✓	✓		docker-langserver => npm install -g dockerfile-language-server-nodejs
- docker-compose	✓	✓	✓	docker-compose-langserver, yaml-language-server
- dot file
- ---
- clang
- rust
- python + uv

## Bugs
- [ ] Lazygit hunk cpy (ctlr-o) trigger error tried "sudo dnf install xclip wl-clipboard xsel" but still fails

## Docker and System
- [x] Test mounting a volume to `/home/$user` to persist user data
- [ ] Create a `docker-compose.yml` as a sample
- [ ] Add ssh server access with dropbear @P2
- [ ] Add brew to the toolchain

## CLI and Shell
- [ ] Configure `ohmyposh` environment to choose a template preset @P2
- [ ] Add git-crypt ?
- [ ] Add starship support feature

## Helix Editor
- [x] Map custom Helix configurations
- [x] Set up language servers for base runtimes
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
