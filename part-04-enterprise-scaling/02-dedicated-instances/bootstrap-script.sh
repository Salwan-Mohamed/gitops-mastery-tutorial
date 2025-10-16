#!/bin/bash
# Bootstrap script for deploying Argo CD to multiple clusters

set -e

# List of clusters to bootstrap
CLUSTERS=(
  "edge-location-1"
  "edge-location-2"
  "edge-location-3"
  "edge-location-4"
)

ARGOCD_VERSION="stable"

for CLUSTER in "${CLUSTERS[@]}"; do
  echo "========================================"
  echo "Bootstrapping cluster: $CLUSTER"
  echo "========================================"
  
  # Switch context
  kubectl config use-context "$CLUSTER"
  
  # Verify cluster connectivity
  if ! kubectl cluster-info > /dev/null 2>&1; then
    echo "ERROR: Cannot connect to cluster $CLUSTER"
    continue
  fi
  
  # Create namespace
  kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
  
  # Install Argo CD
  echo "Installing Argo CD..."
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/install.yaml
  
  # Wait for Argo CD to be ready
  echo "Waiting for Argo CD to be ready..."
  kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s
  
  # Apply self-managed application
  echo "Applying self-managed application..."
  kubectl apply -f self-managed-app.yaml
  
  # Get admin password
  ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
  echo "Argo CD Admin Password for $CLUSTER: $ADMIN_PASSWORD"
  
  echo "Cluster $CLUSTER bootstrapped successfully!"
  echo ""
done

echo "All clusters bootstrapped!"
