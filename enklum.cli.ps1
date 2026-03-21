param(
    [string]$container_name = "enklum",
    [string]$image_name = "enklum",
    [string]$image_tag = "latest",
    [string]$username = "smith",
    [string]$home_volume_path_or_name = "$image_name-$container_name-home"
)

# TODO Add container runtime docker|podman params to force run with --runner=(podman|docker). If no params given use podman by default then fallback on docker. If podman choosen & available prompt user to start default podman machine if not
# TODO Add --stop --start --reset --kill params that act on the container state
# TODO Add parameters --zsh (cmd: zsh) & --zellij (cmd: zsh -ic "zellij"). Default is --zellij and execute cmd in container accordingly
# TODO Add --local-workspace=$(pwd) param
# TODO Add an helper to user

# Check if container is running
$containerRunning = podman ps --noheading --format "{{.Names}}" | Select-String -Pattern "^$image_name$"

if ($containerRunning) {
    Write-Host "Container $image_name already exists."
} else {
    Write-Host "Creating a $image_name container"
    podman run -dit `
        --name $container_name `
        --hostname $container_name `
        --env-file .env.sample `
        --workdir /workspace `
        --volume "$(pwd):/workspace:delegated" `
        --network=host `
        --cap-add=NET_RAW `
        "$image_name`:$image_tag"
}

# --volume "${home_volume_path_or_name}:/home/${username}:delegated" 

Write-Host "Connecting to $container_name."
podman exec -it $container_name zsh -ic "zellij"
# podman exec -it $container_name zsh

# TODO Create same script above for bash once ps1 script is finished
# TODO Update readme.md according ps1 & sh cli scripts created and todo above done

# # Stop execution on any error (like set -e)
# $ErrorActionPreference = 'Stop'
# $PSNativeCommandUseErrorActionPreference = $true

# # Remove existing container if it exists
# podman rm -f enklum

# # Build the container
# $Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
# podman build `
#   --build-arg OCI_BUILD_DATE=$Date `
#   --build-arg-file args-build-file.default.conf `
#   -t enklum:dev .

# # Run the container
# podman run -dit `
#   --name enklum `
#   --hostname enklum `
#   --env-file .env.sample `
#   --workdir /workspace `
#   --volume "${pwd}:/workspace:delegated" `
#   --network=host `
#   --cap-add=NET_RAW `
#   enklum:dev

# # Attach to the container
# ## Only zsh # TODO Doc it
# # podman exec -it enklum zsh
# ## OR Directly zellij # TODO Doc it
# podman exec -it enklum zsh -ic "zellij"
