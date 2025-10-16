# Pattern 1: Centralized Control - Single Command Center

## Overview

One Argo CD instance manages deployments across all your Kubernetes clusters.

## Architecture

```
Management Cluster (Argo CD)
    ↓
    ├── Dev Cluster 1
    ├── Dev Cluster 2
    ├── Staging Cluster
    └── Production Clusters (1-7)
```

## When to Use

✅ Small to medium teams (under 50 people)
✅ Simple environment structure (dev → staging → production)
✅ Straightforward networking (clusters in same region/cloud)
✅ Need for centralized visibility

## When to Avoid

❌ You hit scaling limits around 50 clusters
❌ Network costs explode (clusters across multiple regions)
❌ Single point of failure concerns
❌ Configuration becomes a bottleneck

## Setup Instructions

```bash
# 1. Create management cluster
kind create cluster --name management

# 2. Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 3. Add external clusters
kubectl config use-context dev-cluster
argocd cluster add dev-cluster --name dev-cluster

kubectl config use-context staging-cluster
argocd cluster add staging-cluster --name staging-cluster

kubectl config use-context prod-cluster
argocd cluster add prod-cluster --name prod-cluster

# 4. Deploy applications
kubectl apply -f central-argocd-apps.yaml
```

## Files in This Directory

- `central-argocd-apps.yaml` - Application definitions for all clusters
- `cluster-secrets.yaml` - Cluster connection secrets
- `app-of-apps.yaml` - App of Apps pattern for managing multiple applications
