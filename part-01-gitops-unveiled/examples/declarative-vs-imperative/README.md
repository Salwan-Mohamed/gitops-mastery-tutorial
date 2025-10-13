# Declarative vs Imperative: A Side-by-Side Comparison

This example demonstrates the fundamental difference between imperative (traditional) and declarative (GitOps) approaches to Kubernetes deployment.

## The Key Difference

### Imperative (Traditional)
**"How to do it"** - You tell the system the steps to execute

```bash
kubectl create namespace production
kubectl create deployment nginx --image=nginx:1.21 -n production
kubectl scale deployment nginx --replicas=3 -n production
kubectl expose deployment nginx --port=80 -n production
```

**Problems:**
- ❌ No version control
- ❌ Hard to reproduce
- ❌ No audit trail
- ❌ Error-prone
- ❌ Can't easily rollback
- ❌ State exists only in cluster

### Declarative (GitOps)
**"What I want"** - You describe the desired end state

```yaml
# All in Git
apiVersion: v1
kind: Namespace
metadata:
  name: production
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  namespace: production
spec:
  replicas: 3
  # ... complete configuration
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
  namespace: production
spec:
  # ... service configuration
```

**Benefits:**
- ✅ Version controlled
- ✅ Easily reproducible
- ✅ Complete audit trail
- ✅ Consistent
- ✅ Easy rollbacks (git revert)
- ✅ Git is the source of truth

## Try It Yourself

### Step 1: The Imperative Way

```bash
# Run these commands one by one
./imperative-commands.sh

# Check what was created
kubectl get all -n imperative-demo

# Try to recreate it... can you remember all the commands?
# What if you need to do this on another cluster?
```

### Step 2: The Declarative Way

```bash
# Apply the declarative manifest
kubectl apply -f declarative-manifest.yaml

# Check what was created
kubectl get all -n declarative-demo

# Need to recreate? Just run the same command!
kubectl delete -f declarative-manifest.yaml
kubectl apply -f declarative-manifest.yaml
```

### Step 3: Make Changes

**Imperative:**
```bash
# Scale to 5 replicas
kubectl scale deployment nginx --replicas=5 -n imperative-demo

# Change image
kubectl set image deployment/nginx nginx=nginx:1.22 -n imperative-demo

# What changed? Hard to track!
```

**Declarative:**
```bash
# Edit the manifest
vim declarative-manifest.yaml
# Change replicas: 3 to replicas: 5
# Change image: nginx:1.21 to image: nginx:1.22

# Apply changes
kubectl apply -f declarative-manifest.yaml

# Clear audit trail in Git!
git diff
git commit -m "Scale nginx to 5 replicas and update to 1.22"
```

### Step 4: Rollback

**Imperative:**
```bash
# How do you rollback? What were the previous values?
kubectl rollout undo deployment/nginx -n imperative-demo
# This only works for deployments, not for other resources
```

**Declarative:**
```bash
# Simple Git rollback
git revert HEAD
kubectl apply -f declarative-manifest.yaml

# Or checkout previous version
git checkout HEAD~1 declarative-manifest.yaml
kubectl apply -f declarative-manifest.yaml
```

## Real-World Scenario

### Scenario: Multi-Environment Deployment

**Imperative Approach:**
```bash
# Dev environment
kubectl create deployment app --image=myapp:v1 -n dev
kubectl scale deployment app --replicas=1 -n dev
kubectl set resources deployment app --limits=cpu=100m,memory=128Mi -n dev

# Staging environment (slightly different)
kubectl create deployment app --image=myapp:v1 -n staging
kubectl scale deployment app --replicas=2 -n staging
kubectl set resources deployment app --limits=cpu=200m,memory=256Mi -n staging

# Production (more differences)
kubectl create deployment app --image=myapp:v1 -n production
kubectl scale deployment app --replicas=5 -n production
kubectl set resources deployment app --limits=cpu=500m,memory=512Mi -n production
kubectl autoscale deployment app --min=5 --max=10 --cpu-percent=80 -n production

# Good luck remembering all this!
# Good luck keeping them in sync!
# Good luck with the audit!
```

**Declarative Approach:**
```yaml
# environments/
#   ├── base/
#   │   └── deployment.yaml
#   ├── dev/
#   │   └── kustomization.yaml
#   ├── staging/
#   │   └── kustomization.yaml
#   └── production/
#       └── kustomization.yaml

# Deploy to any environment
kubectl apply -k environments/dev
kubectl apply -k environments/staging
kubectl apply -k environments/production

# All differences tracked in Git!
# Easy to see what's different between environments!
# Complete audit trail!
```

## Comparison Table

| Aspect | Imperative | Declarative (GitOps) |
|--------|-----------|---------------------|
| **Approach** | How to do it | What I want |
| **Version Control** | ❌ Manual tracking | ✅ Automatic in Git |
| **Reproducibility** | ❌ Hard | ✅ Easy |
| **Audit Trail** | ❌ Limited | ✅ Complete |
| **Rollback** | ❌ Complex | ✅ git revert |
| **Collaboration** | ❌ Difficult | ✅ Pull requests |
| **Documentation** | ❌ Separate | ✅ Code is docs |
| **Drift Detection** | ❌ Manual | ✅ Automatic |
| **State Management** | ❌ In cluster only | ✅ In Git |
| **Learning Curve** | ✅ Lower | ⚠️ Steeper initially |
| **Automation** | ❌ Hard | ✅ Built-in |

## When to Use Each?

### Use Imperative When:
- 🔧 Quick debugging/testing
- 📖 Learning Kubernetes
- 🔍 One-off investigations
- ⚡ Emergency hotfixes (but document after!)

### Use Declarative (GitOps) When:
- 🏭 Production environments
- 👥 Team collaboration
- 📊 Multiple environments
- 🛡️ Security and compliance matter
- 🔁 You need reproducibility
- 📝 Audit trails are required

## Exercise: Convert Imperative to Declarative

Try converting these imperative commands to declarative YAML:

```bash
# Challenge 1: Simple deployment
kubectl create deployment redis --image=redis:6.2
kubectl scale deployment redis --replicas=3
kubectl expose deployment redis --port=6379

# Challenge 2: With configuration
kubectl create configmap app-config --from-literal=DEBUG=true
kubectl create secret generic db-password --from-literal=password=secret123
kubectl create deployment app --image=myapp:latest
kubectl set env deployment/app --from=configmap/app-config
kubectl set env deployment/app --from=secret/db-password

# Write the declarative YAML for both!
```

## Cleanup

```bash
# Cleanup imperative demo
kubectl delete namespace imperative-demo

# Cleanup declarative demo
kubectl delete -f declarative-manifest.yaml
```

## Key Takeaways

1. 📋 **Declarative is self-documenting** - The YAML file IS the documentation
2. 🔄 **Git enables powerful workflows** - Version control, code review, rollbacks
3. 🤝 **Teams collaborate better** - Pull requests, reviews, discussions
4. 🔒 **Security is built-in** - Changes are tracked, approved, audited
5. 🏭 **Production-ready** - Reliable, consistent, reproducible deployments

## Next Steps

- Review the complete manifests in this directory
- Try modifying the declarative approach
- Experience GitOps workflow with Argo CD
- Move to the next example

---

**Remember:** In GitOps, we don't run kubectl commands in production. We commit to Git and let the GitOps tool do the rest!
