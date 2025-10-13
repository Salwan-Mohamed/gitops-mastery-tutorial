# Part 1: GitOps Unveiled

## 📖 Overview

This directory contains all the hands-on examples, configurations, and code referenced in **Part 1** of the GitOps Mastery tutorial series: "GitOps Unveiled: Why Your Infrastructure Deserves the Git Treatment (And How to Start)".

**Article Link:** [Read on Medium](#) *(Update with your article link)*

## 🎯 What You'll Learn

In this part, you'll:

- ✅ Understand what GitOps is and why it matters
- ✅ See the evolution from traditional IT to GitOps
- ✅ Learn the four core pillars of GitOps
- ✅ Deploy your first GitOps-managed application
- ✅ Experience the GitOps workflow hands-on
- ✅ Compare declarative vs imperative approaches

## 📁 Directory Structure

```
part-01-gitops-unveiled/
├── README.md (you are here)
├── getting-started/
│   ├── kind-cluster/          # Kubernetes cluster setup
│   ├── argocd-setup/          # Argo CD installation
│   └── first-app/             # Your first GitOps application
├── examples/
│   ├── declarative-vs-imperative/  # Compare both approaches
│   ├── basic-deployment/           # Simple Kubernetes deployment
│   └── gitops-workflow/            # Complete GitOps workflow demo
└── docs/
    ├── installation-guide.md       # Detailed setup instructions
    └── troubleshooting.md          # Common issues and solutions
```

## 🚀 Quick Start

### Prerequisites

Ensure you have the following installed:

- **Docker Desktop** (v20.10+)
- **kubectl** (v1.27+)
- **kind** (v0.20+)
- **Git** (v2.30+)

### Step 1: Create Kubernetes Cluster

```bash
# From the repository root
cd gitops-mastery-tutorial

# Create a local Kubernetes cluster using Kind
chmod +x common/scripts/setup-kind.sh
./common/scripts/setup-kind.sh
```

This will:
- Create a 3-node Kind cluster (1 control-plane + 2 workers)
- Configure port forwarding for ingress (80, 443)
- Set up kubectl context

### Step 2: Install Argo CD

```bash
# Install Argo CD
chmod +x common/scripts/install-argocd.sh
./common/scripts/install-argocd.sh
```

This will:
- Install Argo CD in the `argocd` namespace
- Wait for all pods to be ready
- Display admin credentials

### Step 3: Access Argo CD UI

```bash
# In a new terminal, start port forwarding
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get the admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo
```

Open your browser to: **https://localhost:8080**

- Username: `admin`
- Password: (from command above)

## 📚 Hands-On Examples

### Example 1: Your First GitOps Application

Deploy a simple Nginx application using GitOps:

```bash
cd part-01-gitops-unveiled/getting-started/first-app

# Deploy the application
kubectl apply -f application.yaml

# Watch the deployment
kubectl get pods -w
```

**What happens:**
1. Argo CD detects the new Application resource
2. Syncs the desired state from your Git repository
3. Automatically deploys Nginx to your cluster
4. Continuously monitors for drift

### Example 2: Declarative vs Imperative

See the difference between traditional imperative commands and GitOps declarative approach:

```bash
cd part-01-gitops-unveiled/examples/declarative-vs-imperative

# View the imperative approach
cat imperative-commands.sh

# View the declarative approach
cat declarative-manifest.yaml

# Try the declarative approach
kubectl apply -f declarative-manifest.yaml
```

### Example 3: Complete GitOps Workflow

Experience the full GitOps cycle:

```bash
cd part-01-gitops-unveiled/examples/gitops-workflow

# 1. Deploy initial application
kubectl apply -f app-v1.yaml

# 2. Make a change (scale replicas)
# Edit app-v2.yaml and change replicas from 2 to 3

# 3. Apply the change
kubectl apply -f app-v2.yaml

# 4. Watch Argo CD automatically sync
kubectl get pods -w

# 5. Rollback if needed
kubectl apply -f app-v1.yaml
```

## 📖 Key Concepts Demonstrated

### 1. Declarative Configuration

Instead of running commands like:
```bash
kubectl create deployment nginx --image=nginx:1.21
kubectl scale deployment nginx --replicas=3
kubectl expose deployment nginx --port=80
```

You declare the desired state in YAML:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 3
  # ... rest of configuration
```

### 2. Git as Single Source of Truth

- All configurations live in Git
- Git history = deployment history
- Easy rollbacks with `git revert`
- Complete audit trail

### 3. Automated Synchronization

Argo CD continuously:
- Monitors your Git repository
- Compares desired state (Git) with actual state (cluster)
- Automatically applies changes
- Fixes any drift

### 4. Continuous Reconciliation

If someone manually changes the cluster:
```bash
# Manual change (not GitOps way!)
kubectl scale deployment nginx --replicas=10
```

Argo CD will detect this drift and automatically reconcile back to the desired state from Git.

## 🎓 Learning Path

Follow these examples in order:

1. **getting-started/first-app** - Deploy your first GitOps app
2. **examples/declarative-vs-imperative** - Understand the paradigm shift
3. **examples/basic-deployment** - Work with a simple deployment
4. **examples/gitops-workflow** - Experience the full cycle

## 💡 Best Practices Learned

By the end of Part 1, you'll understand:

- ✅ Why declarative is better than imperative for infrastructure
- ✅ How Git becomes your deployment automation tool
- ✅ The importance of version control for infrastructure
- ✅ How to achieve consistent deployments across environments
- ✅ The security benefits of GitOps (no direct cluster access needed)

## 🔧 Troubleshooting

### Application Not Syncing?

```bash
# Check Argo CD application status
kubectl get application -n argocd

# View application details
kubectl describe application my-app -n argocd

# Check Argo CD logs
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-application-controller
```

### Can't Access Argo CD UI?

```bash
# Ensure port-forward is running
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Check if argocd-server is running
kubectl get pods -n argocd | grep argocd-server

# View argocd-server logs
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-server
```

### Pods Not Starting?

```bash
# Check pod status
kubectl get pods

# Describe the pod for events
kubectl describe pod <pod-name>

# View pod logs
kubectl logs <pod-name>
```

For more troubleshooting help, see [docs/troubleshooting.md](./docs/troubleshooting.md)

## 📚 Additional Resources

### Official Documentation
- [Argo CD Docs](https://argo-cd.readthedocs.io/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Kind Docs](https://kind.sigs.k8s.io/)

### Related Articles
- [GitOps Principles](https://opengitops.dev/)
- [CNCF GitOps](https://www.cncf.io/blog/2021/04/12/gitops-is-so-much-more-than-CI-CD/)

### Video Tutorials
- [Argo CD Tutorial Playlist](https://www.youtube.com/@ArgoProj)
- [CNCF GitOps Videos](https://www.youtube.com/playlist?list=PLj6h78yzYM2O1wlsM-Ma-RYhfT5LKq0XC)

## 🤝 Contributing

Found an issue or want to improve an example? Contributions are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 What's Next?

Continue to **Part 2: Building Your First Production-Ready GitOps Pipeline** where you'll learn:

- Advanced Argo CD configurations
- Multi-environment strategies
- Secrets management with Sealed Secrets
- CI/CD integration patterns
- And much more!

## 💬 Questions?

- Open an issue in this repository
- Comment on the Medium article
- Join the discussion in GitHub Discussions

---

**Ready to continue?** Head to [Part 2](../part-02-production-pipeline/) →

---

*Part 1 of the GitOps Mastery Tutorial Series*
*Author: Salwan Mohamed*
*Repository: https://github.com/Salwan-Mohamed/gitops-mastery-tutorial*
