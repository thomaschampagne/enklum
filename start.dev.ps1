# Stop execution on any error (like set -e)
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

# Remove existing container if it exists
podman rm -f kajko

# Build the container
$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
podman build `
  --build-arg OCI_BUILD_DATE=$Date `
  --build-arg-file argfile.conf `
  -t kajko:dev .

# Run the container
podman run -dit `
  --name kajko `
  --hostname kajko `
  --user dev `
  --env GIT_NAME="Thomas Champagne" `
  --env GIT_EMAIL="thomas.champagne@fakemail.com" `
  --workdir /workspace `
  --volume "${pwd}:/workspace" `
  --network=host `
  --cap-add=NET_RAW `
  kajko:dev

# TODO Test delegated volume fro /home/dev

# Attach to the container
podman exec -it kajko zsh
