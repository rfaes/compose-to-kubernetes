FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    bash-completion \
    jq \
    make \
    build-essential \
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Install kind
RUN curl -Lo /usr/local/bin/kind "https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64" && \
    chmod +x /usr/local/bin/kind

# Install k9s
RUN curl -sL "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" | \
    tar xz -C /usr/local/bin k9s && \
    chmod +x /usr/local/bin/k9s

# Install Flux CLI
RUN curl -s https://fluxcd.io/install.sh | bash

# Install Marp CLI
RUN npm install -g @marp-team/marp-cli

# Install markdown tools
RUN npm install -g \
    markdownlint-cli \
    markdown-link-check \
    prettier

# Install YAML tools
RUN wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
    tar xf kubeval-linux-amd64.tar.gz && \
    mv kubeval /usr/local/bin && \
    rm kubeval-linux-amd64.tar.gz

# Install yq for YAML processing
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq

# Set up bash completion
RUN echo 'source /etc/bash_completion' >> /etc/bash.bashrc && \
    kubectl completion bash > /etc/bash_completion.d/kubectl && \
    helm completion bash > /etc/bash_completion.d/helm && \
    kind completion bash > /etc/bash_completion.d/kind && \
    flux completion bash > /etc/bash_completion.d/flux

# Create helpful aliases for vscode user
RUN echo 'alias k=kubectl' >> /home/vscode/.bashrc && \
    echo 'alias kgp="kubectl get pods"' >> /home/vscode/.bashrc && \
    echo 'alias kgs="kubectl get svc"' >> /home/vscode/.bashrc && \
    echo 'alias kgd="kubectl get deploy"' >> /home/vscode/.bashrc && \
    echo 'alias kga="kubectl get all"' >> /home/vscode/.bashrc && \
    echo 'alias kdesc="kubectl describe"' >> /home/vscode/.bashrc && \
    echo 'alias klogs="kubectl logs"' >> /home/vscode/.bashrc

# Set working directory
WORKDIR /workspace

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=dialog
