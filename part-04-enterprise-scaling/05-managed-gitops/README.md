# Pattern 5: Managed GitOps - The SaaS Approach

## Overview

A managed service hosts your Argo CD control plane, while lightweight agents run in your clusters.

## Architecture

```
Managed Platform (SaaS)
    └── Manages via agents in:
        ├── Your AWS Cluster
        ├── Your GCP Cluster
        └── Your On-prem Cluster
```

## Key Benefits

✅ Zero operational overhead for GitOps infrastructure
✅ Built-in enterprise features (RBAC, audit logs, multi-tenancy)
✅ Automatic updates and HA
✅ No cluster credentials in control plane
✅ Outbound-only connectivity from clusters

## Trade-offs

⚠️ SaaS fees vs self-managed costs
⚠️ Vendor dependency
⚠️ Requires outbound internet connectivity
⚠️ Data residency considerations

## When This Makes Sense

✅ Limited platform engineering resources
✅ Need enterprise features without building them
✅ Want to focus on applications, not GitOps infrastructure
✅ Compliance requirements need automated audit trails

## Providers

- **Akuity Platform** - Enterprise Argo CD SaaS
- **Codefresh** - Enterprise CI/CD with GitOps
- **Weaveworks (Weave GitOps)** - Flux-based managed GitOps

## Agent Setup Example (Akuity)

```bash
# Install agent in your cluster
kubectl create namespace akuity

# Apply agent configuration (from Akuity console)
kubectl apply -f agent-install.yaml

# Verify agent is connected
kubectl get pods -n akuity
```

## Files in This Directory

- `agent-config-example.yaml` - Sample agent configuration
- `comparison.md` - Comparison of managed GitOps providers
