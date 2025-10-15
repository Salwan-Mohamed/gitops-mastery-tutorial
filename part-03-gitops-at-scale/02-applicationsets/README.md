# ApplicationSets - GitOps at Scale

## Overview

ApplicationSets extend Argo CD's capabilities by allowing you to automatically generate multiple Applications from a single template. Think of it as "mail merge" for Kubernetes deployments.

## Generators Explained

### 1. List Generator
**Use Case**: Deploy to a specific, predefined list of targets
- Static list of clusters
- Known environments
- Controlled deployments

### 2. Cluster Generator
**Use Case**: Deploy to all clusters registered in Argo CD
- Cluster-wide add-ons
- Platform tools
- Automatic scaling with new clusters

### 3. Git Directory Generator
**Use Case**: Create an application for each directory
- Multi-tenant platforms
- Customer-specific deployments
- Per-team applications

### 4. Pull Request Generator
**Use Case**: Automatic preview environments
- Feature branch testing
- QA environments
- Automated cleanup

### 5. Matrix Generator
**Use Case**: Combine multiple generators
- Complex deployment patterns
- Multi-dimensional scaling

## Examples Structure

```
02-applicationsets/
├── list-generator/
│   └── multi-cluster-deploy.yaml
├── cluster-generator/
│   └── cluster-addons.yaml
├── git-directory-generator/
│   ├── customer-apps.yaml
│   └── customers/
├── pull-request-generator/
│   └── preview-environments.yaml
└── matrix-generator/
    └── team-deployments.yaml
```

## Quick Start

```bash
# Apply a simple List Generator
kubectl apply -f list-generator/multi-cluster-deploy.yaml

# Watch ApplicationSet create Applications
kubectl get applicationsets -n argocd
kubectl get applications -n argocd | grep generated

# Try Cluster Generator
kubectl apply -f cluster-generator/cluster-addons.yaml
```

## Comparison: App of Apps vs ApplicationSets

| Feature | App of Apps | ApplicationSets |
|---------|-------------|------------------|
| **Use Case** | Related apps in one cluster | Same app to many clusters |
| **Scalability** | 5-20 apps | 10-1000+ apps |
| **Dynamic** | Manual updates | Automatic generation |
| **Complexity** | Simple | Moderate |
| **Multi-Cluster** | Limited | Native support |
| **Best For** | Bootstrapping, stacks | Platform engineering |

## Real-World Scenarios

### Scenario 1: Platform Engineer
Deploy monitoring stack to all production clusters automatically
```yaml
generators:
- clusters:
    selector:
      matchLabels:
        env: production
```

### Scenario 2: SaaS Provider
Create isolated environment for each customer
```yaml
generators:
- git:
    directories:
    - path: customers/*
```

### Scenario 3: Developer
Automatic preview environments for pull requests
```yaml
generators:
- pullRequest:
    github:
      owner: myorg
      repo: frontend
```

## Best Practices

### Label Everything
```yaml
commonLabels:
  managed-by: applicationset
  generator: cluster
  environment: "{{metadata.labels.env}}"
```

### Use Appropriate Generators
- **List**: When you need explicit control
- **Cluster**: For cluster-wide tooling
- **Git**: For multi-tenancy
- **PR**: For preview environments
- **Matrix**: For complex patterns

### Test Before Production
```bash
# Dry run to see what will be created
kubectl apply -f applicationset.yaml --dry-run=server

# Check generated applications
kubectl get applications -n argocd -l argocd.argoproj.io/application-set-name=my-appset
```

### Monitor and Alert
```yaml
# Set up Prometheus alerts for ApplicationSet health
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: applicationset-alerts
spec:
  groups:
  - name: applicationsets
    rules:
    - alert: ApplicationSetNotHealthy
      expr: argocd_applicationset_info{health_status!="Healthy"} == 1
      for: 10m
```

## Troubleshooting

### Applications Not Generated
```bash
# Check ApplicationSet status
kubectl describe applicationset <name> -n argocd

# Verify generator parameters
kubectl get applicationset <name> -n argocd -o yaml

# Check Argo CD logs
kubectl logs -n argocd deployment/argocd-applicationset-controller
```

### Wrong Applications Created
- Verify generator query/selector
- Check template parameters
- Review cluster labels
- Validate Git repository structure

## Progressive Rollout

Start small and scale:

1. **Week 1**: Single ApplicationSet with List Generator
2. **Week 2**: Add Cluster Generator for add-ons
3. **Week 3**: Implement Git Generator for teams
4. **Week 4**: Add PR Generator for previews
5. **Month 2**: Complex Matrix Generators

## Additional Resources

- [Official ApplicationSet Documentation](https://argo-cd.readthedocs.io/en/stable/user-guide/application-set/)
- [Generator Examples](https://github.com/argoproj/argo-cd/tree/master/applicationset/examples)
- [Best Practices Guide](https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/)
