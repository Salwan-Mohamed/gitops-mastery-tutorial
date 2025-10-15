# App of Apps Pattern

## Overview

The App of Apps pattern allows you to manage multiple related Argo CD Applications as a single unit. Think of it as a "meta-application" that creates and manages other applications.

## Use Cases

1. **Cluster Bootstrapping**: Deploy all necessary add-ons at once
2. **Microservices Stack**: Manage related services together
3. **Team Environments**: Bundle applications for a specific team
4. **Multi-Component Applications**: Deploy frontend, backend, and database as one unit

## Examples Included

### 1. Basic Example
Simple demonstration with 3 applications (frontend, backend, database)

### 2. Cluster Bootstrap
Complete cluster setup with essential add-ons

### 3. Microservices Stack
Production-ready microservices deployment

## Quick Start

```bash
# Deploy basic example
kubectl apply -f basic-example/app-of-apps.yaml

# Watch applications being created
kubectl get applications -n argocd -w

# View in Argo CD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

## How It Works

1. Create a "root" Application that points to a directory
2. The directory contains manifests for "child" Applications
3. Argo CD automatically creates and syncs all child Applications
4. Updates to the directory automatically update child Applications

## Best Practices

- ✅ Use for logically related applications
- ✅ Keep directory structure simple and organized
- ✅ Enable automatic sync for seamless updates
- ✅ Use selfHeal to maintain desired state
- ❌ Don't mix unrelated applications
- ❌ Don't nest App of Apps too deeply
