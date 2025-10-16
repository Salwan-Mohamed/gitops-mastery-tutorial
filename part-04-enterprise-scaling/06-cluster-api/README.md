# Cluster API - GitOps for Cluster Management

## Overview

Manage Kubernetes cluster lifecycle through GitOps using Cluster API.

## What You Can Do

✅ Create clusters declaratively
✅ Scale clusters up/down
✅ Upgrade Kubernetes versions
✅ Multi-cloud cluster management
✅ Self-service cluster provisioning

## Supported Providers

- AWS (CAPA)
- Azure (CAPZ)
- GCP (CAPG)
- vSphere (CAPV)
- OpenStack (CAPO)
- Many more...

## Architecture

```
Management Cluster
    ├── Cluster API Controllers
    ├── Argo CD (watches cluster manifests)
    └── Git Repository
          ├── cluster-1.yaml
          ├── cluster-2.yaml
          └── cluster-3.yaml
```

## Setup Instructions

### 1. Install Cluster API

```bash
# Install clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/latest/download/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl
sudo mv clusterctl /usr/local/bin/

# Initialize management cluster
clusterctl init --infrastructure aws
```

### 2. Create Cluster Definition

```bash
# Generate cluster template
clusterctl generate cluster prod-cluster \
  --kubernetes-version v1.28.0 \
  --control-plane-machine-count=3 \
  --worker-machine-count=3 \
  > prod-cluster.yaml

# Commit to Git
git add prod-cluster.yaml
git commit -m "Add production cluster"
git push
```

### 3. Let Argo CD Deploy It

Argo CD detects the new cluster manifest and creates it automatically!

## Files in This Directory

- `aws-cluster.yaml` - Example AWS cluster definition
- `azure-cluster.yaml` - Example Azure cluster definition
- `argocd-cluster-app.yaml` - Argo CD application for cluster management
- `self-service-portal/` - Self-service cluster request system
