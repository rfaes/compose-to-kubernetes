# Compose to Kubernetes Workshop

A hands-on workshop for developers transitioning from Docker Compose to Kubernetes. This workshop is designed for developers familiar with `docker-compose.yml` and Podman, providing a practical path to understanding Kubernetes fundamentals and advanced operations.

## Workshop Overview

**Duration:** 8 hours total (two 4-hour sessions)  
**Format:** Instructor-led with hands-on labs  
**Prerequisites:** Docker Compose experience, basic terminal usage

### Part 1: Kubernetes Fundamentals (4 hours)
Learn core Kubernetes concepts and resources by comparing them directly to Docker Compose equivalents. Topics include Pods, Deployments, Services, ConfigMaps, Secrets, and Storage.

### Part 2: Advanced Kubernetes Operations (4 hours)
Master production-ready Kubernetes skills including advanced kubectl usage, debugging, health probes, deployment strategies, Ingress, Helm, and GitOps with Flux.

## Repository Structure

```
compose-to-kubernetes/
├── setup/                    # Workshop environment setup
│   ├── Dockerfile           # Workshop container image
│   ├── kind/                # Kubernetes cluster configs
│   ├── start-workshop.sh    # Linux startup script
│   └── start-workshop.ps1   # Windows startup script
├── part-1/                  # Part 1: Kubernetes Fundamentals (11 sections)
├── part-2/                  # Part 2: Advanced Operations (8 sections)
├── resources/               # Cheatsheets, bonus materials
├── docker-compose.yml       # Alternative Docker setup
├── Makefile                 # Convenient make commands
├── PREREQUISITES.md         # Detailed setup guide
├── CONTRIBUTING.md          # Contribution guidelines
├── CODE_OF_CONDUCT.md       # Community guidelines
├── SECURITY.md              # Security policy
└── LICENSE                  # MIT License
```

## Getting Started

### Prerequisites
1. **Podman installed** on your system:
   - **Windows:** Install [Podman Desktop](https://podman-desktop.io/)
   - **Linux:** Install via package manager (`dnf install podman` or `apt install podman`)

2. **System Requirements:**
   - 12-16 GB RAM (for nested containers and multi-node clusters)
   - 20 GB free disk space
   - CPU with virtualization support

3. **Clone this repository:**
   ```bash
   git clone https://github.com/rfaes/compose-to-kubernetes.git
   cd compose-to-kubernetes
   ```

### Quick Start

Follow the detailed setup instructions in [PREREQUISITES.md](PREREQUISITES.md).

**TL;DR:**
```bash
# Build the workshop environment (or pull pre-built image)
cd setup
podman build -t k8s-workshop-tools .

# Start the workshop environment
./start-workshop.sh    # Linux
# or
./start-workshop.ps1   # Windows
```

## Workshop Content

### [Part 1: Kubernetes Fundamentals](part-1/)
1. Introduction to Kubernetes
2. Environment Setup & First Steps
3. Core Resources: Pods
4. Deployments & ReplicaSets
5. Services & Networking
6. Configuration Management (ConfigMaps & Secrets)
7. Storage in Kubernetes
8. Namespaces & Resource Organization
9. Essential kubectl & k9s Commands
10. Manifests & Best Practices
11. **Final Lab:** 3-tier application deployment

### [Part 2: Advanced Operations](part-2/)
1. Ingress Controllers & Advanced Routing
2. Package Management with Helm
3. GitOps with Flux CD
4. Monitoring & Observability (Prometheus, Grafana, Loki)
5. Advanced Deployment Strategies (Blue/Green, Canary)
6. Autoscaling (HPA, VPA, KEDA)
7. Security & RBAC
8. Multi-Cluster Management

## Learning Approach

This workshop uses a **progressive, hands-on approach**:

- **Docker Compose → Kubernetes mapping** in every section
- **Live demonstrations** of concepts
- **Hands-on labs** after each major topic (~45% of workshop time)
- **Real-world examples** using public container images
- **Comprehensive final labs** to integrate all concepts

## What's Included

- **Complete Workshop Materials:** Theory, examples, and hands-on labs for all 19 sections
- **Presentation Slides:** Marp-based slides for Part 1 and Part 2
- **Workshop Environment:** Dockerfile with all tools (kubectl, kind, k9s, Helm, Flux)
- **Cluster Configurations:** Three kind setups (simple, multi-node, HA)
- **Lab Exercises:** Comprehensive labs with step-by-step solutions
- **Cheatsheets:** kubectl, k9s shortcuts, and compose-to-k8s mapping
- **Bonus Materials:** YAML basics, networking fundamentals, troubleshooting guides
- **CI/CD Integration:** GitHub Actions for content validation
- **Make Commands:** Convenient Makefile for common tasks

## Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting:
- Report issues or suggest improvements
- Submit pull requests with fixes or enhancements
- Share feedback after completing the workshop
- Help translate materials to other languages

All contributors must follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## Quick Commands with Make

If you have `make` installed:

```bash
make build          # Build workshop container
make start          # Start workshop environment
make stop           # Stop workshop environment
make clean          # Clean up everything
make validate       # Validate all YAML files
make test           # Run content validation tests
make shell          # Open shell in workshop container
make cluster-simple # Create simple kind cluster
```

## Alternative: Docker Compose

Prefer Docker over Podman?

```bash
docker-compose up -d
docker exec -it k8s-workshop bash
```

## Security

This workshop is designed for **local learning environments only**. 

For production use, please review our [Security Policy](SECURITY.md) and implement proper security hardening.

## License

MIT License - See [LICENSE](LICENSE) for details.

This workshop is free to use, modify, and distribute.

## Acknowledgments

Built with:
- [kind](https://kind.sigs.k8s.io/) - Kubernetes in Docker
- [k9s](https://k9scli.io/) - Kubernetes TUI
- [Helm](https://helm.sh/) - Kubernetes package manager
- [Flux](https://fluxcd.io/) - GitOps toolkit
- [Marp](https://marp.app/) - Markdown presentations

---

**Ready to start?** Head to [PREREQUISITES.md](PREREQUISITES.md) to set up your environment!
