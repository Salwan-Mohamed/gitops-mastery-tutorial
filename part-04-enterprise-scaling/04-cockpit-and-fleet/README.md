# Pattern 4: Cockpit and Fleet - Best of Both Worlds

## Overview

One central "cockpit" Argo CD manages platform infrastructure across all clusters. Each cluster runs its own "fleet" Argo CD for application deployments.

## Architecture

```
Central Cockpit Argo CD
    └── Manages platform components for:
        ├── Cluster 1 (runs own Argo CD for apps)
        ├── Cluster 2 (runs own Argo CD for apps)
        └── Cluster 3 (runs own Argo CD for apps)
```

## What Each Layer Manages

### Cockpit (Platform Team)
- Ingress controllers
- Certificate managers
- Security policies
- Monitoring stack
- Network policies
- Service mesh

### Fleet (Application Teams)
- Application deployments
- Feature flags
- A/B testing configurations
- Application-specific configs

## When This Shines

✅ Large organizations (100+ engineers)
✅ Mature DevOps practices (teams ready for self-service)
✅ Mix of centralized and distributed needs
✅ Strong platform engineering team

## Setup Instructions

### Step 1: Deploy Cockpit

```bash
# Create management cluster
kind create cluster --name cockpit

# Install Cockpit Argo CD
kubectl create namespace argocd-cockpit
kubectl apply -n argocd-cockpit -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Deploy platform components
kubectl apply -f cockpit-apps.yaml
```

### Step 2: Deploy Fleet Instances

```bash
# For each application cluster
kubectl config use-context app-cluster-1
kubectl create namespace argocd-fleet
kubectl apply -n argocd-fleet -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Deploy application management
kubectl apply -f fleet-apps.yaml
```

## Files in This Directory

- `cockpit-apps.yaml` - Platform infrastructure applications
- `fleet-apps.yaml` - Application deployment configurations
- `setup-cockpit.sh` - Automation script for cockpit setup
- `setup-fleet.sh` - Automation script for fleet setup
