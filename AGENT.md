# ENKLUM Codebase Summary for AI Agents

## Project Overview

ENKLUM (from French "enclume" meaning anvil) is a portable, terminal-first development environment built on Fedora Linux. It provides a containerized development forge with essential tools for coding, debugging, and shipping software without local machine setup.

## Key Architectural Components

### 1. Core Structure

- **Base Image**: `core/core.Dockerfile` - Fedora-minimal based image with essential tools
- **Flavors**: `flavors/` directory - Different variants (full, full-next) extending the core
- **Features**: `features/` directory - Modular components (languages, runtimes, frameworks, etc.)
- **Shared**: `shared/` directory - Common scripts and utilities
- **CLI**: Built-in command-line tool for system management

### 2. Container Build Process

- Uses BuildKit/Docker Buildx with GitHub Actions CI
- Multi-stage build approach:
  1. Core image creation with system packages
  2. Feature installation via `feats.install.sh`
  3. User configuration and cleanup
- Args handled through `args-build-file.default.conf`
- Image tagging follows YYYY.MM.DD format

### 3. Modular Feature System

- Features organized in `features/` by category:
  - `cli/` - Shell enhancers (oh-my-posh)
  - `devops/` - DevOps tools (not shown in sample)
  - `frameworks/` - Web frameworks (React, Angular placeholders)
  - `languages/` - Programming language support
  - `runtimes/` - Language runtimes (Node, Bun, Go)
- Each feature contains:
  - `.install.sh` script for installation
  - Configuration files as needed
  - Dependency declarations

### 4. Tool Management

- **mise** for global version management of developer tools
- DNF for system-level Fedora packages
- Clear separation between system packages and developer tools

### 5. User Experience

- Terminal-first approach with:
  - ZSH as default shell
  - Zellij for terminal multiplexing
  - Helix/Neovim as primary editors
  - Yazi for TUI file management
  - OhMyPosh for customizable prompt
- Pre-configured language servers for LSP support
- Git user configuration pre-set

## Important Files and Their Purposes

### Dockerfiles

- `core/core.Dockerfile` - Base image with Fedora system setup
- `flavors/full.Dockerfile` - Complete development environment

### Scripts

- `image.build.sh` - Main image building script with argument parsing
- `shared/feats.install.sh` - Installs all feature components
- `shared/feats.require.sh` - Helper for feature dependencies
- `shared/cmd/entrypoint.sh` - Container entrypoint (keeps container alive)
- `shared/cmd/enklum` - CLI tool for system updates and package listing

### Configuration

- `args-build-file.default.conf` - Build arguments (username, workspace dir, etc.)
- `.env.sample` - Environment variable template
- Core system configs in `core/system/` and `core/tools/`

### Workspace

- Default workspace directory: `/workspace`
- User home: `/home/${ENKLUM_USERNAME}` (default: smith)

<!-- 
TODO Must fall in README. Then update here as-well
## Development Workflow

1. **Setup**:

   ```bash
   cp .env.sample .env  # Optional: customize environment
   ./image.build.sh     # Build the image
   ```

2. **Usage**:

   ```bash
   # Using provided shell function
   enklum              # Start with defaults
   enklum -r           # Reset (recreate) containers
   enklum -p custom.yaml  # Use custom compose file
   ```

3. **Customization**:
   - Modify `.env` for environment variables
   - Edit `args-build-file.default.conf` for build arguments
   - Create custom Dockerfile extending from `ghcr.io/thomaschampagne/enklum-core:latest`
   - Add features via `feats.install.sh --features-folder /path/to/features` -->

## CI/CD Pipeline

GitHub Actions workflow (`.github/workflows/image.yaml`):

- Builds and pushes both core and full flavors to GHCR
- Supports multi-platform (`linux/amd64`, `linux/arm64`)
- Triggered on push to main branch or manual dispatch
- Uses conventional naming: `ghcr.io/<owner>/enklum-{core|full}:<date>`

## Dependencies and Requirements

### Host Requirements

- Docker or Podman
- Nerd Font for proper icon display in terminal
- Basic shell (Bash/Zsh) for helper functions

### Container Components

- **OS**: Fedora Linux (minimal base)
- **Shell**: ZSH with Oh-My-Posh (optional)
- **Terminal Multiplexer**: Zellij
- **Editors**: Helix (default), Neovim, Vim, Emacs, Nano
- **File Manager**: Yazi (TUI)
- **Prompt**: Starship
- **Version Management**: mise
- **Package Manager**: DNF (Fedora)
- **Git**: Pre-configured with default user
- **Languages**: Node.js (LTS), Bun, Go, etc. (via mise)
- **LSP Servers**: TypeScript, JSON, YAML, Markdown, etc.
- **Tools**: Git, lazygit, fzf, ripgrep, fd, jq, yq, sd, zoxide, etc.
- **Monitoring**: btop, ncdu, tree
- **Network**: netcat, nmap, tcpdump, traceroute
- **Archives**: zip, unzip, 7zip, tar
- **Build**: gcc, make, just.

## Extensibility Patterns

### Adding New Features

1. Create directory under `features/` (e.g., `features/myfeature/`)
2. Add `myfeature.install.sh` with installation logic
3. Reference in flavor Dockerfile:

   ```dockerfile
   COPY --parents --chown=${ENKLUM_USERNAME}:${ENKLUM_USERNAME} \
     ./features/myfeature \
     /home/${ENKLUM_USERNAME}/.tmp/
   ```

4. The `feats.install.sh` script will automatically discover and run `.install.sh` files

### Overriding Defaults

- Environment variables in `.env` or build args
- Custom configuration files copied to appropriate locations
- mise configurations for tool versions
- Shell configuration in `core/res/home/.zshrc`

## Design Principles

1. **Immutability**: Base image is rebuilt rather than patched
2. **Modularity**: Features can be added/removed independently
3. **Reproducibility**: Fixed build dates and versions
4. **User Consistency**: Same environment across machines
5. **Terminal Optimization**: Keyboard-driven, minimal GUI dependencies
6. **Security**: Non-root user by default, minimal attack surface

## Known Limitations (from TODO comments in codebase)

- LazyGit hunk copy functionality issues
- Potential SSH server addition
- Oh-My-Posh template configuration
- File extension standardization (.zsh for Zsh scripts)
- Comprehensive LSP coverage (CSS, SCSS, HTML formatters)
- Debug Adapter Protocol support for more languages

## Summary

ENKLUM provides a sophisticated, modular development environment that emphasizes:

- Terminal efficiency and keyboard-driven workflows
- Reproducible builds with clear versioning
- Extensibility through modular feature system
- Consistency across development machines
- Portability across container platforms

The codebase demonstrates solid DevOps practices with clear separation of concerns, automated builds, and thoughtful organization making it easy for contributors to understand and extend.
