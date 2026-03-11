# Start the Kubernetes workshop environment (Windows PowerShell)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$WorkspaceDir = Split-Path -Parent $ScriptDir
$ImageName = "k8s-workshop-tools:latest"
$RemoteImage = "ghcr.io/rfaes/$ImageName"

Write-Host "Starting Kubernetes Workshop Environment..." -ForegroundColor Green
Write-Host ""

# Check if Podman is installed
if (-not (Get-Command podman -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Podman is not installed." -ForegroundColor Red
    Write-Host "Please install Podman Desktop: https://podman-desktop.io/downloads" -ForegroundColor Yellow
    exit 1
}

# Check if image exists locally or remotely
$LocalImageExists = (podman image exists $ImageName 2>$null; $LASTEXITCODE -eq 0)
$RemoteImageExists = (podman image exists $RemoteImage 2>$null; $LASTEXITCODE -eq 0)

if (-not $LocalImageExists -and -not $RemoteImageExists) {
    Write-Host "Error: Workshop image not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please either:" -ForegroundColor Yellow
    Write-Host "  1. Build it: cd setup; podman build -t $ImageName ." -ForegroundColor Yellow
    Write-Host "  2. Pull it: podman pull $RemoteImage" -ForegroundColor Yellow
    exit 1
}

# Determine which image to use
if ($LocalImageExists) {
    $UseImage = $ImageName
} else {
    $UseImage = $RemoteImage
}

Write-Host "Using image: $UseImage" -ForegroundColor Green
Write-Host "Workspace mounted at: $WorkspaceDir" -ForegroundColor Green
Write-Host ""
Write-Host "Starting container..." -ForegroundColor Cyan
Write-Host ""

# Run the workshop container
podman run -it --rm `
    --privileged `
    --name k8s-workshop `
    -v "${WorkspaceDir}:/workspace" `
    $UseImage

Write-Host ""
Write-Host "Workshop environment exited." -ForegroundColor Cyan
