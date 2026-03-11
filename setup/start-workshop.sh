#!/bin/bash

# Start the Kubernetes workshop environment (Linux)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"
IMAGE_NAME="k8s-workshop-tools:latest"

echo "Starting Kubernetes Workshop Environment..."
echo ""

# Check if Podman is installed
if ! command -v podman &> /dev/null; then
    echo "❌ Error: Podman is not installed."
    echo "Please install Podman first: https://podman.io/getting-started/installation"
    exit 1
fi

# Check if image exists
if ! podman image exists "$IMAGE_NAME" && ! podman image exists "ghcr.io/rfaes/$IMAGE_NAME"; then
    echo "❌ Error: Workshop image not found."
    echo ""
    echo "Please either:"
    echo "  1. Build it: cd setup && podman build -t $IMAGE_NAME ."
    echo "  2. Pull it: podman pull ghcr.io/rfaes/$IMAGE_NAME"
    exit 1
fi

# Determine which image to use
if podman image exists "$IMAGE_NAME"; then
    USE_IMAGE="$IMAGE_NAME"
else
    USE_IMAGE="ghcr.io/rfaes/$IMAGE_NAME"
fi

echo "Using image: $USE_IMAGE"
echo "Workspace mounted at: $WORKSPACE_DIR"
echo ""
echo "Starting container..."
echo ""

# Run the workshop container
podman run -it --rm \
    --privileged \
    --name k8s-workshop \
    -v "$WORKSPACE_DIR:/workspace:Z" \
    "$USE_IMAGE"

echo ""
echo "Workshop environment exited."
