#!/bin/zsh

set -e
set -o pipefail

echo "============================================================"
echo "exec \"$(basename "$0")\" script as script as \"$(whoami)\" user"
echo "============================================================"

#### .zshrc setup ####

# - Append starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# - Append zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc\

# - Append bun binaries
echo 'export PATH="$PATH:~/.bun/bin"' >> ~/.zshrc

# - Git default username & email
echo 'git config --global user.name "${GIT_NAME}"' >> ~/.zshrc
echo 'git config --global user.email "${GIT_EMAIL}"' >> ~/.zshrc

# - Load zshrc for next steps
source ~/.zshrc

#### Tools config ####
# Configure zoxide
zoxide add /${DEFAULT_WORKSPACE_DIR}
zoxide add ~/.config

# Configure starship theme w/ "gruvbox"
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Configure Git
git config --global --add safe.directory '*'
git config --global init.defaultBranch main
git config --global core.autocrlf true # Ensure skip LF vs CRLF comparison

# TODO Configure zellij
# zellij options --default-shell zsh --show-startup-tips false
# ~/.config/zellij/config.kdl
cat > ~/.config/zellij/config.kdl << 'EOF'
// Set default shell to zsh
default_shell "zsh"

// Disable startup tips
show_startup_tips false
EOF   
