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
├── setup/              # Workshop environment setup
├── part-1/             # Part 1: Kubernetes Fundamentals
├── part-2/             # Part 2: Advanced Operations (coming soon)
├── resources/          # Cheatsheets, bonus materials, sample apps
└── slides/             # Marp presentation files
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

### [Part 2: Advanced Operations](part-2/) *(Coming Soon)*
1. Advanced kubectl Techniques
2. Debugging & Troubleshooting
3. Application Health & Reliability
4. Deployment Strategies & Updates
5. Ingress & Advanced Networking
6. Package Management with Helm
7. GitOps with Flux
8. High Availability & Production Readiness
9. Security & Best Practices
10. **Final Lab:** Production-grade deployment

## Learning Approach

This workshop uses a **progressive, hands-on approach**:

- **Docker Compose → Kubernetes mapping** in every section
- **Live demonstrations** of concepts
- **Hands-on labs** after each major topic (~45% of workshop time)
- **Real-world examples** using public container images
- **Comprehensive final labs** to integrate all concepts

## What's Included

- Complete workshop materials (theory + practice)
- Marp slide decks for presentations
- Pre-configured kind (Kubernetes in Docker) setups
- Hands-on lab exercises with solutions
- Kubectl and k9s cheatsheets
- Bonus materials (YAML basics, networking fundamentals)
- Troubleshooting guides

## Contributing

This is a workshop repository. If you find issues or have suggestions:
1. Open an issue describing the problem
2. Submit a PR with improvements
3. Share feedback after completing the workshop

## License

MIT License - See [LICENSE](LICENSE) for details

## Acknowledgments

Built with:
- [kind](https://kind.sigs.k8s.io/) - Kubernetes in Docker
- [k9s](https://k9scli.io/) - Kubernetes TUI
- [Helm](https://helm.sh/) - Kubernetes package manager
- [Flux](https://fluxcd.io/) - GitOps toolkit
- [Marp](https://marp.app/) - Markdown presentations

---

**Ready to start?** Head to [PREREQUISITES.md](PREREQUISITES.md) to set up your environment!
