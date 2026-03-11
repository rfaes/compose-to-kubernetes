# Complete Solution - All Manifests

This directory contains the complete Kubernetes manifests for the final lab.

## Files

1. `namespace.yaml` - Application namespace
2. `database-secret.yaml` - Database credentials
3. `database-pvc.yaml` - Persistent storage for PostgreSQL
4. `database-statefulset.yaml` - PostgreSQL StatefulSet
5. `database-service.yaml` - Database Service
6. `backend-configmap.yaml` - Backend configuration
7. `backend-deployment.yaml` - Backend API Deployment
8. `backend-service.yaml` - Backend Service
9. `frontend-configmap.yaml` - Frontend HTML and configuration
10. `frontend-deployment.yaml` - Frontend Deployment
11. `frontend-service.yaml` - Frontend NodePort Service

## Deployment Order

```bash
# 1. Namespace and ConfigMaps/Secrets (independent)
kubectl apply -f namespace.yaml
kubectl apply -f database-secret.yaml
kubectl apply -f backend-configmap.yaml
kubectl apply -f frontend-configmap.yaml

# 2. Storage
kubectl apply -f database-pvc.yaml

# 3. Database layer
kubectl apply -f database-statefulset.yaml
kubectl apply -f database-service.yaml

# Wait for database to be ready
kubectl wait --for=condition=Ready pod/database-0 -n myapp --timeout=120s

# 4. Backend layer
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml

# 5. Frontend layer
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml

# Verify all resources
kubectl get all -n myapp
```

## Quick Deploy

Apply all at once (dependencies will be resolved):

```bash
kubectl apply -f solution/
```

## Access Application

```bash
# Frontend
http://localhost:30080

# Or using kubectl
kubectl port-forward -n myapp service/frontend 8080:80
# Then: http://localhost:8080
```

## Cleanup

```bash
kubectl delete namespace myapp
```
