# Part 2: Building Your Production-Ready GitOps Pipeline

This directory contains all the code, configurations, and examples from **Part 2** of the GitOps Mastery series.

## 📚 What's Covered

- **Helm**: Kubernetes package management and templating
- **Kustomize**: Template-free configuration management
- **Argo CD**: GitOps continuous delivery for Kubernetes
- **Complete Weather App**: Real-world application deployment

## 🗂️ Directory Structure

```
part-02-production-pipeline/
├── README.md
├── helm-examples/
│   ├── my-nodejs-app/           # Complete Helm chart
│   ├── values-dev.yaml
│   ├── values-staging.yaml
│   └── values-production.yaml
├── kustomize-examples/
│   ├── base/                    # Base configurations
│   └── overlays/
│       ├── dev/
│       ├── staging/
│       └── production/
├── weather-app/
│   ├── src/                     # Application source code
│   ├── deployment/              # Kubernetes manifests
│   ├── Dockerfile
│   └── .github/workflows/       # CI/CD pipeline
├── argocd-setup/
│   ├── install.sh
│   ├── applications/
│   └── projects/
└── docs/
    ├── helm-guide.md
    ├── kustomize-guide.md
    └── argocd-guide.md
```

## 🚀 Quick Start

### 1. Deploy the Weather App

```bash
# Navigate to the weather app directory
cd weather-app

# Build and push the Docker image (update with your registry)
docker build -t your-dockerhub/weather-app:1.0.0 .
docker push your-dockerhub/weather-app:1.0.0

# Deploy with kubectl
kubectl apply -f deployment/

# Or deploy with Argo CD
kubectl apply -f ../argocd-setup/applications/weather-app.yaml
```

### 2. Try Helm Examples

```bash
# Navigate to Helm examples
cd helm-examples

# Install the Node.js app
helm install my-webapp ./my-nodejs-app --namespace dev --values values-dev.yaml

# Upgrade the release
helm upgrade my-webapp ./my-nodejs-app --namespace dev --values values-dev.yaml

# Rollback if needed
helm rollback my-webapp 1 --namespace dev
```

### 3. Try Kustomize Examples

```bash
# Navigate to Kustomize examples
cd kustomize-examples

# Preview dev environment
kustomize build overlays/dev

# Deploy to dev
kustomize build overlays/dev | kubectl apply -f -

# Deploy to production
kustomize build overlays/production | kubectl apply -f -
```

### 4. Set Up Argo CD

```bash
# Navigate to Argo CD setup
cd argocd-setup

# Install Argo CD
./install.sh

# Deploy an application
kubectl apply -f applications/weather-app.yaml
```

## 📖 Detailed Guides

- [Helm Guide](./docs/helm-guide.md) - Complete Helm tutorial
- [Kustomize Guide](./docs/kustomize-guide.md) - Kustomize patterns and best practices
- [Argo CD Guide](./docs/argocd-guide.md) - Setting up and using Argo CD

## 🎯 Learning Objectives

After completing this part, you'll be able to:

- ✅ Create and manage Helm charts
- ✅ Use Kustomize for environment-specific configurations
- ✅ Set up Argo CD for automated deployments
- ✅ Build a complete CI/CD pipeline
- ✅ Deploy a production-ready application
- ✅ Implement best practices for GitOps

## 🛠️ Prerequisites

- Completed Part 1 of the tutorial
- Kubernetes cluster (kind, minikube, or cloud provider)
- kubectl installed and configured
- Docker installed
- Git installed
- Helm installed (v3.12+)
- Kustomize installed (or use kubectl -k)

## 📝 Examples Overview

### Helm Chart: Node.js Application
A complete, production-ready Helm chart with:
- Resource limits and requests
- Health checks (liveness and readiness probes)
- Multi-environment support
- ConfigMaps and Secrets

### Kustomize: E-commerce Frontend
Multi-environment configuration with:
- Base configuration
- Environment-specific overlays
- Strategic merge patches
- ConfigMap and Secret generators

### Weather App: Complete Application
Full-stack weather forecasting app with:
- Python Flask backend
- HTML/CSS/JS frontend
- Kubernetes manifests
- GitHub Actions CI/CD
- Argo CD configuration

## 🔧 Troubleshooting

### Common Issues

**Helm install fails:**
```bash
# Check Helm version
helm version

# Verify chart syntax
helm lint ./my-chart

# Debug template rendering
helm template ./my-chart --debug
```

**Kustomize build errors:**
```bash
# Validate YAML
kustomize build overlays/dev

# Check for missing files
kustomize build overlays/dev --load-restrictor=LoadRestrictionsNone
```

**Argo CD sync issues:**
```bash
# Check application status
argocd app get weather-app

# Manual sync
argocd app sync weather-app

# Check logs
kubectl logs -n argocd deployment/argocd-application-controller
```

## 🤝 Contributing

Found an issue or have an improvement? Please submit a pull request or open an issue!

## 📚 Additional Resources

- [Helm Documentation](https://helm.sh/docs/)
- [Kustomize Documentation](https://kustomize.io/)
- [Argo CD Documentation](https://argo-cd.readthedocs.io/)
- [Kubernetes Best Practices](https://kubernetes.io/docs/concepts/configuration/overview/)

---

**Next:** [Part 3: Advanced GitOps Patterns](../part-03-advanced-patterns/README.md)
**Previous:** [Part 1: GitOps Unveiled](../part-01-gitops-unveiled/README.md)
