# Workshop Environment Setup

This directory contains everything needed to set up your local Kubernetes workshop environment.

## Contents

- **Dockerfile** - Container image with all workshop tools
- **start-workshop.sh** - Launch script for Linux
- **start-workshop.ps1** - Launch script for Windows
- **kind/** - Kubernetes cluster configurations

## Quick Start

### 1. Build or Pull the Workshop Image

**Option A: Pull (Recommended)**
```bash
podman pull ghcr.io/rfaes/k8s-workshop-tools:latest
```

**Option B: Build Locally**
```bash
cd setup
podman build -t k8s-workshop-tools:latest .
```

### 2. Start the Workshop Environment

**Linux:**
```bash
./start-workshop.sh
```

**Windows:**
```powershell
.\start-workshop.ps1
```

## 🔧 kind Cluster Configurations

Three cluster configurations are provided for different learning stages:

### simple.yaml - Basic Setup
- **1 control-plane** node
- **1 worker** node
- Ports exposed: 80, 443, 30000
- **Use for:** Part 1 sections 1-7

```bash
kind create cluster --config /workspace/setup/kind/simple.yaml
```

### multi-node.yaml - Multi-Node Setup
- **1 control-plane** node
- **3 worker** nodes (labeled with zones: zone-a, zone-b, zone-c)
- Ports exposed: 80, 443, 30000
- **Use for:** Part 1 sections 8-11, testing affinity rules

```bash
kind create cluster --config /workspace/setup/kind/multi-node.yaml
```

### ha.yaml - High Availability Setup
- **3 control-plane** nodes (HA control plane with etcd)
- **3 worker** nodes (labeled with zones)
- Ports exposed: 80, 443
- **Use for:** Part 2 HA demonstrations

```bash
kind create cluster --config /workspace/setup/kind/ha.yaml --name workshop-ha
```

## Tools Included

The workshop container includes:

| Tool | Version | Purpose |
|------|---------|---------|
| **kind** | Latest | Create local Kubernetes clusters |
| **kubectl** | Latest stable | Kubernetes command-line tool |
| **k9s** | Latest | Terminal UI for Kubernetes |
| **Helm** | v3 (latest) | Kubernetes package manager |
| **Flux** | Latest | GitOps toolkit |
| **Podman** | Latest | Container runtime (nested) |
| **Git** | Latest | Version control |
| **vim** | Latest | Text editor |
| **jq** | Latest | JSON processor |

## Useful Commands

### Inside the Workshop Container

```bash
# Create cluster with simple setup
kind create cluster --config /workspace/setup/kind/simple.yaml

# List clusters
kind get clusters

# Get cluster info
kubectl cluster-info

# Check nodes
kubectl get nodes

# Launch k9s
k9s

# Delete cluster when done
kind delete cluster --name workshop
```

### Aliases Available

The container includes helpful aliases:
- `k` → `kubectl`
- `kgp` → `kubectl get pods`
- `kgs` → `kubectl get svc`
- `kgd` → `kubectl get deploy`
- `kga` → `kubectl get all`
- `kdesc` → `kubectl describe`
- `klogs` → `kubectl logs`

## Troubleshooting

### Container Won't Start

**Linux:**
```bash
# Check Podman service
systemctl --user status podman.socket

# Try with sudo (rootful mode)
sudo ./start-workshop.sh
```

**Windows:**
```powershell
# Check Podman machine status
podman machine list

# Start Podman machine if stopped
podman machine start
```

### kind Cluster Creation Fails

```bash
# Make sure KIND_EXPERIMENTAL_PROVIDER is set
export KIND_EXPERIMENTAL_PROVIDER=podman

# Check Podman is running
podman ps

# Try with verbose logging
kind create cluster --config /workspace/setup/kind/simple.yaml --verbosity 5
```

### Out of Resources

```bash
# Check system resources
podman system df

# Clean up unused images and containers
podman system prune -a

# Delete old kind clusters
kind delete clusters --all
```

## Cleanup

### Delete All Clusters
```bash
kind delete clusters --all
```

### Exit Workshop Container
```bash
exit
```

The container automatically removes itself on exit (`--rm` flag).

## Tips

1. **Save your work**: The `/workspace` directory is mounted from your host, so any files saved there persist after the container exits.

2. **Multiple terminals**: You can exec into the running container from another terminal:
   ```bash
   podman exec -it k8s-workshop /bin/bash
   ```

3. **Resource usage**: Monitor your system resources. Each kind node is a container, so a 3-node cluster = 3 containers + the workshop container.

4. **Cluster persistence**: kind clusters persist even after you exit the workshop container (containers are siblings, not nested). Always clean up:
   ```bash
   kind delete cluster --name workshop
   ```

## Next Steps

Once your environment is running:
1. Create a simple cluster: `kind create cluster --config /workspace/setup/kind/simple.yaml`
2. Verify it works: `kubectl get nodes`
3. Start the workshop: Navigate to `/workspace/part-1/`

Happy learning!
