# Pattern 2: Dedicated Instances - Fortress per Cluster

## Overview

Every cluster gets its own Argo CD instance. Complete isolation, maximum security.

## Architecture

```
Cluster 1 (with Argo CD) → Manages itself
Cluster 2 (with Argo CD) → Manages itself
Cluster 3 (with Argo CD) → Manages itself
```

## Perfect For

✅ Edge computing scenarios (remote locations, spotty connectivity)
✅ Air-gapped environments (high-security requirements)
✅ Independent teams (each owning their infrastructure)
✅ Multi-tenant platforms (strict isolation between customers)

## When to Avoid

❌ Limited ops team (maintaining multiple instances is labor-intensive)
❌ Need for central visibility (no single pane of glass)
❌ Frequent changes to GitOps configuration
❌ Tight budget (more infrastructure = more cost)

## Setup Instructions

```bash
# Run this for EACH cluster

# 1. Switch to target cluster
kubectl config use-context cluster-1

# 2. Install Argo CD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 3. Configure to manage itself
kubectl apply -f self-managed-app.yaml

# 4. Repeat for all clusters
```

## Files in This Directory

- `self-managed-app.yaml` - Argo CD application for self-management
- `bootstrap-script.sh` - Automation script for deploying to multiple clusters
- `argocd-config.yaml` - Standard Argo CD configuration
