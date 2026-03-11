# Security Policy

## Supported Versions

This workshop is actively maintained. We recommend always using the latest version from the `main` branch.

| Version | Supported          |
| ------- | ------------------ |
| main    | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in the workshop materials or setup scripts, please report it by:

1. **DO NOT** open a public issue
2. Email the maintainer directly (check GitHub profile for contact)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if available)

## Security Considerations for Workshop

This workshop is designed for **local learning environments only**. The configurations and examples are intentionally simplified for educational purposes and should **NOT** be used in production without proper security hardening.

### Known Limitations

The workshop environment includes:

1. **Privileged Containers** - Required for kind/nested containers
2. **Simple Passwords** - Examples use basic authentication for demonstration
3. **No TLS in Some Examples** - Some examples use HTTP for simplicity
4. **Permissive RBAC** - Some examples show overly permissive roles for learning
5. **No Network Policies** - Early sections don't include network isolation

### Production Security Checklist

Before using concepts from this workshop in production:

- [ ] Implement proper RBAC with least privilege
- [ ] Enable Pod Security Standards (restricted)
- [ ] Use NetworkPolicies for isolation
- [ ] Implement TLS/mTLS for all communications
- [ ] Use secrets management (Vault, Sealed Secrets, etc.)
- [ ] Enable audit logging
- [ ] Scan container images for vulnerabilities
- [ ] Implement resource limits and quotas
- [ ] Use admission controllers (OPA/Gatekeeper)
- [ ] Follow CIS Kubernetes Benchmarks

### Container Image Security

The workshop container image includes:
- Latest stable versions of tools
- No credentials or sensitive data
- Minimal attack surface

To verify image integrity:
```bash
# Check image signature (when available)
podman image trust show

# Scan for vulnerabilities
trivy image k8s-workshop-tools:latest
```

## Security in Workshop Content

Some sections intentionally demonstrate insecure configurations to teach security concepts:
- **Part 1, Section 11**: Shows examples of what NOT to do
- **Part 2, Section 07**: Covers security best practices and hardening

Always read the security warnings in each section.

## Updates and Patches

We monitor security advisories for:
- Kubernetes
- kubectl
- Helm
- Flux
- Container runtime (Podman/Docker)
- kind

The workshop Dockerfile is updated regularly to use the latest stable versions.

## Response Timeline

- **Critical vulnerabilities**: Within 48 hours
- **High severity**: Within 1 week
- **Medium/Low severity**: Next release cycle

## Acknowledgments

We thank the security researchers and community members who responsibly disclose vulnerabilities.
