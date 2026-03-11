#!/bin/zsh

# Check if no arguments are passed to the script
if [ $# -eq 0 ]; then
  # Check if the zellij process is running
  pidof zellij > /dev/null || {
      # If zellij is not running, start it in interactive mode without creating a new process group
      exec zellij --interactive --no-process-group
  }
fi

# Default to run whatever the user wanted, e.g. "sh"
exec "$@"