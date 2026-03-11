FROM fedora:latest

LABEL maintainer="rfaes"
LABEL description="Kubernetes workshop environment with kind, kubectl, k9s, helm, and flux"

# Install base packages
RUN dnf install -y \
    podman \
    fuse-overlayfs \
    curl \
    wget \
    git \
    vim \
    bash-completion \
    jq \
    && dnf clean all

# Configure Podman for nested containers
RUN mkdir -p /etc/containers && \
    echo '[storage]' > /etc/containers/storage.conf && \
    echo 'driver = "vfs"' >> /etc/containers/storage.conf && \
    echo '[storage.options]' >> /etc/containers/storage.conf && \
    echo 'mount_program = "/usr/bin/fuse-overlayfs"' >> /etc/containers/storage.conf

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Install kind
RUN curl -Lo /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64" && \
    chmod +x /usr/local/bin/kind

# Install k9s
RUN curl -sL "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" | \
    tar xz -C /usr/local/bin k9s && \
    chmod +x /usr/local/bin/k9s

# Install Helm
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Flux CLI
RUN curl -s https://fluxcd.io/install.sh | bash

# Set up bash completion
RUN kubectl completion bash > /etc/bash_completion.d/kubectl && \
    helm completion bash > /etc/bash_completion.d/helm && \
    kind completion bash > /etc/bash_completion.d/kind

# Create helpful aliases
RUN echo 'alias k=kubectl' >> /root/.bashrc && \
    echo 'alias kgp="kubectl get pods"' >> /root/.bashrc && \
    echo 'alias kgs="kubectl get svc"' >> /root/.bashrc && \
    echo 'alias kgd="kubectl get deploy"' >> /root/.bashrc && \
    echo 'alias kga="kubectl get all"' >> /root/.bashrc && \
    echo 'alias kdesc="kubectl describe"' >> /root/.bashrc && \
    echo 'alias klogs="kubectl logs"' >> /root/.bashrc && \
    echo 'export KIND_EXPERIMENTAL_PROVIDER=podman' >> /root/.bashrc && \
    echo 'export PS1="\[\e[32m\][k8s-workshop]\[\e[0m\] \w \$ "' >> /root/.bashrc

# Set working directory
WORKDIR /workspace

# Welcome message
RUN echo '#!/bin/bash' > /usr/local/bin/welcome.sh && \
    echo 'echo "╔════════════════════════════════════════════════╗"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "║  Welcome to the Kubernetes Workshop!          ║"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "║  All tools are ready: kind, kubectl, k9s      ║"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "╚════════════════════════════════════════════════╝"' >> /usr/local/bin/welcome.sh && \
    echo 'echo ""' >> /usr/local/bin/welcome.sh && \
    echo 'echo "Quick start:"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  1. Create cluster: kind create cluster --config /workspace/setup/kind/simple.yaml"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  2. Check nodes: kubectl get nodes"' >> /usr/local/bin/welcome.sh && \
    echo 'echo "  3. Launch k9s: k9s"' >> /usr/local/bin/welcome.sh && \
    echo 'echo ""' >> /usr/local/bin/welcome.sh && \
    chmod +x /usr/local/bin/welcome.sh

# Start Podman service and show welcome message
CMD /usr/local/bin/welcome.sh && podman system service --time=0 unix:///run/podman/podman.sock & exec /bin/bash
