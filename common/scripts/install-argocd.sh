#!/bin/bash

##############################################################################
# Install Argo CD for GitOps Tutorial
# This script installs and configures Argo CD in your Kubernetes cluster
##############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ARGOCD_VERSION="${ARGOCD_VERSION:-stable}"
ARGOCD_NAMESPACE="argocd"
TIMEOUT=300

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  GitOps Tutorial - Argo CD Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if kubectl is configured
if ! kubectl cluster-info &> /dev/null; then
    echo -e "${RED}❌ Cannot connect to Kubernetes cluster${NC}"
    echo ""
    echo "Please ensure:"
    echo "  1. You have a running Kubernetes cluster"
    echo "  2. kubectl is properly configured"
    echo "  3. Run './setup-kind.sh' if you haven't already"
    exit 1
fi

echo -e "${GREEN}✓${NC} Connected to Kubernetes cluster"
echo ""

# Check if Argo CD is already installed
if kubectl get namespace ${ARGOCD_NAMESPACE} &> /dev/null; then
    echo -e "${YELLOW}⚠️  Argo CD namespace already exists${NC}"
    echo ""
    read -p "Do you want to reinstall Argo CD? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Uninstalling existing Argo CD...${NC}"
        kubectl delete namespace ${ARGOCD_NAMESPACE} --wait=true --timeout=${TIMEOUT}s
        echo -e "${GREEN}✓${NC} Argo CD uninstalled"
        echo ""
    else
        echo -e "${BLUE}Keeping existing installation${NC}"
        echo ""
        echo "To access Argo CD:"
        echo "  kubectl port-forward svc/argocd-server -n ${ARGOCD_NAMESPACE} 8080:443"
        echo ""
        echo "Get admin password:"
        echo "  kubectl -n ${ARGOCD_NAMESPACE} get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d"
        exit 0
    fi
fi

# Create namespace
echo -e "${BLUE}Creating namespace '${ARGOCD_NAMESPACE}'...${NC}"
kubectl create namespace ${ARGOCD_NAMESPACE}
echo -e "${GREEN}✓${NC} Namespace created"
echo ""

# Install Argo CD
echo -e "${BLUE}Installing Argo CD (version: ${ARGOCD_VERSION})...${NC}"
echo -e "${YELLOW}This may take a few minutes...${NC}"
echo ""

kubectl apply -n ${ARGOCD_NAMESPACE} -f https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml

echo ""
echo -e "${GREEN}✓${NC} Argo CD manifests applied"
echo ""

# Wait for Argo CD to be ready
echo -e "${BLUE}Waiting for Argo CD pods to be ready...${NC}"
kubectl wait --for=condition=Ready pods --all -n ${ARGOCD_NAMESPACE} --timeout=${TIMEOUT}s

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Argo CD Installation Complete! 🎉${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Get admin password
echo -e "${BLUE}Retrieving admin credentials...${NC}"
ARGOCD_PASSWORD=$(kubectl -n ${ARGOCD_NAMESPACE} get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo ""
echo -e "${BLUE}Argo CD Credentials:${NC}"
echo "  Username: ${GREEN}admin${NC}"
echo "  Password: ${GREEN}${ARGOCD_PASSWORD}${NC}"
echo ""
echo -e "${YELLOW}⚠️  Save these credentials securely!${NC}"
echo ""

# Display pods
echo -e "${BLUE}Argo CD Pods:${NC}"
kubectl get pods -n ${ARGOCD_NAMESPACE}
echo ""

# Display services
echo -e "${BLUE}Argo CD Services:${NC}"
kubectl get svc -n ${ARGOCD_NAMESPACE}
echo ""

# Access instructions
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  How to Access Argo CD${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

echo -e "${BLUE}Option 1: Port Forward (Recommended for local dev)${NC}"
echo "  Run this command:"
echo "    ${GREEN}kubectl port-forward svc/argocd-server -n ${ARGOCD_NAMESPACE} 8080:443${NC}"
echo ""
echo "  Then open: ${GREEN}https://localhost:8080${NC}"
echo "  Login with username: ${GREEN}admin${NC}"
echo "  Password: ${GREEN}${ARGOCD_PASSWORD}${NC}"
echo ""

echo -e "${BLUE}Option 2: Using Argo CD CLI${NC}"
echo "  Install CLI:"
echo "    macOS: ${GREEN}brew install argocd${NC}"
echo "    Linux: ${GREEN}curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64${NC}"
echo ""
echo "  Login:"
echo "    ${GREEN}argocd login localhost:8080${NC}"
echo ""

echo -e "${BLUE}Option 3: LoadBalancer (for cloud clusters)${NC}"
echo "  Patch the service:"
echo "    ${GREEN}kubectl patch svc argocd-server -n ${ARGOCD_NAMESPACE} -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'${NC}"
echo ""

# Useful commands
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Useful Commands${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

echo "  Get password again:"
echo "    ${GREEN}kubectl -n ${ARGOCD_NAMESPACE} get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d${NC}"
echo ""

echo "  Check Argo CD status:"
echo "    ${GREEN}kubectl get all -n ${ARGOCD_NAMESPACE}${NC}"
echo ""

echo "  View Argo CD logs:"
echo "    ${GREEN}kubectl logs -n ${ARGOCD_NAMESPACE} -l app.kubernetes.io/name=argocd-server${NC}"
echo ""

echo "  Uninstall Argo CD:"
echo "    ${GREEN}kubectl delete namespace ${ARGOCD_NAMESPACE}${NC}"
echo ""

# Next steps
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Next Steps${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

echo "  1. Access the Argo CD UI using port-forward"
echo ""
echo "  2. Deploy your first application:"
echo "     ${GREEN}cd ../part-01-gitops-unveiled/getting-started/first-app${NC}"
echo "     ${GREEN}kubectl apply -f application.yaml${NC}"
echo ""
echo "  3. Explore the examples in the repository"
echo ""

echo -e "${GREEN}Happy GitOps-ing with Argo CD! 🚀${NC}"
