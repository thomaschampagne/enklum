# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory      # Append to history instead of overwriting
setopt sharehistory       # Share history across multiple open terminals
setopt histignorealldups  # Ignore duplicated commands

# vim mode. Uncomment below to enable
# bindkey -v
# bindkey -M viins 'jj' vi-cmd-mode
# bindkey -M viins 'jk' vi-cmd-mode
# bindkey -M viins '^[[3~' delete-char
# bindkey -M vicmd '^[[3~' delete-char
# bindkey -M viins '^R' history-incremental-search-backward
# bindkey -M vicmd '^R' history-incremental-search-backward

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dev/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Loading Fedora Native Plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ll='ls -lFh'
alias la='ls -lAFh'

# Default PATH
eval "$(mise activate --shims)" # Will export mise shim to PATH

