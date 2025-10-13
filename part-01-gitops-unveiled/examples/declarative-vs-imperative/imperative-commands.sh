#!/bin/bash

##############################################################################
# Imperative Approach Example
# This script shows the traditional way of deploying to Kubernetes
##############################################################################

set -e

echo "=== Imperative Approach Demo ==="
echo ""
echo "Creating resources using imperative commands..."
echo ""

# Create namespace
echo "1. Creating namespace..."
kubectl create namespace imperative-demo

# Create deployment
echo "2. Creating deployment..."
kubectl create deployment nginx \
  --image=nginx:1.21 \
  -n imperative-demo

# Wait a bit for deployment
sleep 2

# Scale deployment
echo "3. Scaling deployment to 3 replicas..."
kubectl scale deployment nginx \
  --replicas=3 \
  -n imperative-demo

# Expose deployment
echo "4. Exposing deployment as service..."
kubectl expose deployment nginx \
  --port=80 \
  --type=ClusterIP \
  -n imperative-demo

# Set resource limits
echo "5. Setting resource limits..."
kubectl set resources deployment nginx \
  --limits=cpu=200m,memory=256Mi \
  --requests=cpu=100m,memory=128Mi \
  -n imperative-demo

# Add labels
echo "6. Adding labels..."
kubectl label deployment nginx \
  environment=demo \
  managed-by=imperative \
  -n imperative-demo

echo ""
echo "=== Deployment Complete ==="
echo ""
echo "Resources created:"
kubectl get all -n imperative-demo

echo ""
echo "Problems with this approach:"
echo "  - No version control"
echo "  - Hard to reproduce"
echo "  - No audit trail"
echo "  - Error-prone"
echo "  - State exists only in cluster"
echo ""
echo "Try to recreate this... can you remember all the commands?"
