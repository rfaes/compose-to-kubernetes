#!/bin/bash

echo "Setting up Kubernetes Workshop development environment..."

# Ensure proper permissions
sudo chown -R vscode:vscode /workspace

# Install any additional dependencies from package.json if present
if [ -f "package.json" ]; then
    echo "Installing npm dependencies..."
    npm install
fi

# Setup git safe directory
git config --global --add safe.directory /workspace

# Setup git hooks (if any)
if [ -d ".git/hooks" ]; then
    echo "Setting up git hooks..."
    chmod +x .git/hooks/* 2>/dev/null || true
fi

# Verify all tools are installed
echo ""
echo "Verifying installed tools..."

check_tool() {
    if command -v $1 &> /dev/null; then
        echo "  ✓ $1: $(${1} --version 2>&1 | head -n1)"
    else
        echo "  ✗ $1: Not found"
    fi
}

check_tool kubectl
check_tool helm
check_tool kind
check_tool k9s
check_tool flux
check_tool marp
check_tool markdownlint
check_tool kubeval
check_tool yq
check_tool make

# Create helpful message
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Kubernetes Workshop Dev Container Ready!                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Available commands:"
echo "  make build          - Build workshop container"
echo "  make validate       - Validate all YAML files"
echo "  make test           - Run content validation tests"
echo "  marp part-1/slides.md --pdf             - Export slides to PDF"
echo "  marp part-1/slides.md --watch --server  - Live preview slides"
echo "  markdownlint '**/*.md'                  - Lint markdown files"
echo "  kubectl apply -f <file>                 - Apply Kubernetes manifests"
echo ""
echo "Create a cluster:"
echo "  kind create cluster --config setup/kind/simple.yaml"
echo ""
echo "Happy coding! 🎉"
