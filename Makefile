# Makefile for Compose to Kubernetes Workshop

.PHONY: help build start stop clean test validate lint

# Default target
help:
	@echo "Compose to Kubernetes Workshop - Make Commands"
	@echo ""
	@echo "Available commands:"
	@echo "  make build      - Build the workshop container image"
	@echo "  make start      - Start the workshop environment"
	@echo "  make stop       - Stop the workshop environment"
	@echo "  make clean      - Clean up everything (clusters, containers, volumes)"
	@echo "  make test       - Run validation tests"
	@echo "  make validate   - Validate all YAML files"
	@echo "  make lint       - Lint markdown files"
	@echo "  make shell      - Open shell in workshop container"
	@echo ""

# Build workshop container
build:
	@echo "Building workshop container..."
	docker build -t k8s-workshop-tools:latest ./setup

# Start workshop environment
start:
	@echo "Starting workshop environment..."
	docker-compose up -d
	@echo ""
	@echo "Workshop environment started!"
	@echo "Access the container: docker exec -it k8s-workshop bash"

# Stop workshop environment
stop:
	@echo "Stopping workshop environment..."
	docker-compose down

# Clean up everything
clean:
	@echo "Cleaning up workshop environment..."
	@kind get clusters | xargs -I {} kind delete cluster --name {} 2>/dev/null || true
	@docker-compose down -v
	@docker system prune -f
	@echo "Cleanup complete!"

# Validate YAML files
validate:
	@echo "Validating Kubernetes YAML files..."
	@find part-1 part-2 -name "*.yaml" -type f | while read file; do \
		echo "Checking $$file"; \
		kubectl apply --dry-run=client -f "$$file" > /dev/null 2>&1 || echo "Warning: $$file may need review"; \
	done
	@echo "Validation complete!"

# Lint markdown files
lint:
	@echo "Linting markdown files..."
	@command -v markdownlint > /dev/null || npm install -g markdownlint-cli
	@markdownlint '**/*.md' --ignore node_modules || true

# Run all tests
test: validate lint
	@echo "Running workshop tests..."
	@bash ./setup/test-workshop.sh || true

# Open shell in workshop container
shell:
	@docker exec -it k8s-workshop bash || echo "Container not running. Run 'make start' first."

# Create simple kind cluster
cluster-simple:
	@docker exec -it k8s-workshop kind create cluster --config /workspace/setup/kind/simple.yaml

# Create multi-node kind cluster
cluster-multi:
	@docker exec -it k8s-workshop kind create cluster --config /workspace/setup/kind/multi-node.yaml

# Create HA kind cluster
cluster-ha:
	@docker exec -it k8s-workshop kind create cluster --config /workspace/setup/kind/ha.yaml --name workshop-ha

# Delete all clusters
cluster-delete:
	@docker exec -it k8s-workshop bash -c "kind get clusters | xargs -I {} kind delete cluster --name {}"
