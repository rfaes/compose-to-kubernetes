# Workshop Prerequisites

This document outlines everything you need to prepare before the workshop begins.

## System Requirements

### Minimum Specifications
- **RAM:** 12 GB (16 GB recommended for smooth multi-node clusters)
- **Disk Space:** 20 GB free
- **CPU:** Modern processor with virtualization support (Intel VT-x/AMD-V)
- **OS:** Windows 10/11 with WSL2, or Linux (any modern distribution)

### Why These Requirements?
This workshop uses Podman-in-Podman (nested containers) to create Kubernetes clusters with kind. Each "node" in your cluster runs as a container, requiring more resources than typical development work.

## Required Software

### 1. Podman

**Windows Users:**
1. Download and install [Podman Desktop](https://podman-desktop.io/downloads)
2. Podman Desktop will set up WSL2 automatically if not already installed
3. Verify installation:
   ```powershell
   podman --version
   ```
**Linux Users (Debian/Ubuntu):**
```bash
sudo apt-get update
sudo apt-get install -y podman
podman --version
```

### 2. Git

**Windows:**
- Install [Git for Windows](https://git-scm.com/download/win) or use the one included in Podman Desktop

**Linux:**
```bash
# Fedora/RHEL
sudo dnf install -y git

# Debian/Ubuntu
sudo apt-get install -y git
```

## Pre-Workshop Setup

### Step 1: Clone Workshop Repository

```bash
git clone https://github.com/rfaes/compose-to-kubernetes.git
cd compose-to-kubernetes
```

### Step 2: Build Workshop Environment

You have two options:

#### Option A: Pull Pre-built Image (Recommended)
```bash
# Pull the ready-to-use workshop environment
podman pull ghcr.io/rfaes/k8s-workshop-tools:latest
```

#### Option B: Build Locally
```bash
# Build from Dockerfile (takes 5-10 minutes)
cd setup
podman build -t k8s-workshop-tools:latest .
cd ..
```

### Step 3: Verify Setup

**Linux:**
```bash
cd setup
./verify-setup.sh
```

**Windows (PowerShell):**
```powershell
cd setup
.\verify-setup.ps1
```

This script will:
- Check Podman installation
- Verify the workshop image is available
- Test container execution
- Validate resource availability

### Step 4: Start Workshop Environment (Test Run)

**Linux:**
```bash
./start-workshop.sh
```

**Windows (PowerShell):**
```powershell
.\start-workshop.ps1
```

This launches the workshop container with all tools pre-installed. You should see a bash prompt inside the container.

**Inside the container, test kind:**
```bash
# Set kind to use Podman
export KIND_EXPERIMENTAL_PROVIDER=podman

# Create a test cluster
kind create cluster --name test

# Verify it works
kubectl get nodes

# Clean up
kind delete cluster --name test

# Exit container
exit
```

If all these steps complete successfully, you're ready for the workshop! 🎉

## Optional: Pre-Workshop Reading

If you want to get a head start, check out these resources:

### Basics (5-10 minutes)
- [YAML Basics](resources/bonus/yaml-basics.md) - If you're rusty on YAML syntax
- [Networking Fundamentals](resources/bonus/networking-basics.md) - Refresh on ports, DNS, and basic networking

### Kubernetes Context (15-20 minutes)
- [Official Kubernetes Docs - What is Kubernetes?](https://kubernetes.io/docs/concepts/overview/)
- [Docker Compose to Kubernetes: Key Differences](resources/compose-to-k8s-mapping.md)

### Tools Overview (Optional)
- [kubectl Cheatsheet](resources/kubectl-cheatsheet.md)
- [k9s Documentation](https://k9scli.io/)

## Troubleshooting

### Issue: Podman Command Not Found (Windows)

**Solution:** Make sure Podman Desktop has fully initialized. Check that:
1. WSL2 is installed: `wsl --list --verbose`
2. The Podman machine is running in Podman Desktop
3. Restart your terminal/PowerShell window

### Issue: Permission Denied (Linux)

**Solution:** You may need to run Podman in rootful mode or configure rootless properly:
```bash
# Enable Podman socket for rootless
systemctl --user enable --now podman.socket

# Or use rootful Podman (requires sudo)
sudo podman --version
```

### Issue: Out of Disk Space

**Solution:** Clean up unused containers and images:
```bash
# Remove old containers
podman container prune

# Remove old images
podman image prune -a

# Check disk usage
podman system df
```

### Issue: Nested Containers Won't Start (Windows)

**Solution:** Ensure virtualization is enabled in BIOS and Hyper-V/WSL2 is properly configured:
```powershell
# Check WSL2 version
wsl --version

# Update WSL2 if needed
wsl --update
```

### Issue: kind Cluster Creation Fails

If you get errors during `kind create cluster`:
1. Make sure you set: `export KIND_EXPERIMENTAL_PROVIDER=podman`
2. Try with `sudo` if using rootful Podman
3. Check logs: `podman logs <container-name>`
4. Verify you have enough resources (RAM, disk)

## Getting Help

**Before the Workshop:**
- Open an issue on the GitHub repository
- Email the instructor (contact info provided in workshop invitation)

**During the Workshop:**
- Raise your hand or use the designated chat channel
- Instructors will help troubleshoot environment issues

## Pre-Workshop Checklist

Print or keep this handy:

- [ ] Podman installed and verified (`podman --version`)
- [ ] Workshop repository cloned
- [ ] Workshop image built or pulled
- [ ] Test container successfully launched
- [ ] Test kind cluster created and deleted successfully
- [ ] All cleanup completed (`kind delete cluster --name test`)
- [ ] Optional: Reviewed bonus materials on YAML and networking

**If you can check all these boxes, you're 100% ready!**

See you at the workshop!
