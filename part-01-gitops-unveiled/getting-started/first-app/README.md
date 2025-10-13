# Your First GitOps Application

This example deploys a simple Nginx web server using GitOps principles with Argo CD.

## What This Example Demonstrates

- ✅ GitOps workflow in action
- ✅ Declarative application deployment
- ✅ Automatic synchronization from Git
- ✅ Self-healing capabilities
- ✅ Easy rollbacks

## Files in This Example

- **application.yaml** - Argo CD Application resource
- **deployment.yaml** - Kubernetes Deployment for Nginx
- **service.yaml** - Kubernetes Service to expose Nginx

## Quick Deploy

```bash
# Deploy the application
kubectl apply -f application.yaml

# Watch the deployment
kubectl get application -n argocd
kubectl get pods -w
```

## Step-by-Step Guide

### Step 1: Understand the Application Manifest

The `application.yaml` tells Argo CD:
- Where to find the Kubernetes manifests (this Git repo)
- Which cluster/namespace to deploy to
- Sync policy (automatic)

### Step 2: Deploy the Application

```bash
kubectl apply -f application.yaml
```

### Step 3: Monitor in Argo CD UI

1. Open Argo CD UI: https://localhost:8080
2. You'll see "my-first-gitops-app" appear
3. Watch it sync automatically
4. See the visual representation of resources

### Step 4: Verify Deployment

```bash
# Check application status
kubectl get application my-first-gitops-app -n argocd

# Check pods
kubectl get pods -l app=nginx

# Check service
kubectl get svc nginx
```

### Step 5: Access the Application

```bash
# Port forward to access locally
kubectl port-forward svc/nginx 8081:80

# Open in browser
open http://localhost:8081
```

You should see the Nginx welcome page!

## Test GitOps Self-Healing

### Scenario: Manual Change

Let's see what happens if someone manually changes the deployment:

```bash
# Manually scale to 5 replicas (not the GitOps way!)
kubectl scale deployment nginx --replicas=5

# Watch what happens
kubectl get pods -w
```

**Result:** Argo CD detects the drift and automatically scales back to 2 replicas (as defined in Git).

### Scenario: Delete a Pod

```bash
# Delete a pod
kubectl delete pod -l app=nginx --force

# Watch it get recreated
kubectl get pods -w
```

**Result:** Kubernetes recreates the pod, and Argo CD ensures desired state is maintained.

## Make a GitOps Change

The proper way to make changes:

### Option 1: Edit in UI

1. Go to Argo CD UI
2. Click on the application
3. Click "App Details" → "Parameters"
4. Change replicas to 3
5. Watch it sync

### Option 2: Edit in Git (Recommended)

```bash
# Fork this repository
# Edit deployment.yaml
# Change replicas: 2 to replicas: 3
# Commit and push

# Argo CD will automatically detect and sync the change
```

## Rollback

If something goes wrong:

```bash
# Via Argo CD UI
# Click "History and Rollback"
# Select previous version
# Click "Rollback"

# Or via CLI
argocd app rollback my-first-gitops-app
```

## Cleanup

To remove the application:

```bash
# Delete the application
kubectl delete -f application.yaml

# Verify cleanup
kubectl get pods -l app=nginx
```

## What You Learned

🎓 **Key Takeaways:**

1. **Declarative Deployment**: You declared what you want, not how to create it
2. **Git as Source of Truth**: The Git repository defines the desired state
3. **Automatic Sync**: Argo CD keeps cluster in sync with Git
4. **Self-Healing**: Manual changes are automatically reverted
5. **Easy Rollbacks**: Git history enables instant rollbacks
6. **Audit Trail**: Every change is tracked in Git

## Next Steps

- Explore the `deployment.yaml` and `service.yaml` files
- Try modifying the Nginx image version
- Add more replicas
- Add resource limits
- Explore other examples in this tutorial

## Troubleshooting

### Application Not Syncing?

```bash
# Check application status
kubectl describe application my-first-gitops-app -n argocd

# Force sync
kubectl patch application my-first-gitops-app -n argocd \
  --type merge -p '{"operation":{"sync":{"syncStrategy":{"hook":{}}}}}'
```

### Can't See Application in UI?

```bash
# Ensure Argo CD is running
kubectl get pods -n argocd

# Check application exists
kubectl get application -n argocd
```

---

**Congratulations!** You've just deployed your first GitOps application! 🎉
