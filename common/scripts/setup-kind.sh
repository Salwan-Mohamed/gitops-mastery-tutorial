#!/bin/bash

##############################################################################
# Setup Kind Cluster for GitOps Tutorial
# This script creates a local Kubernetes cluster using Kind
##############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLUSTER_NAME="${CLUSTER_NAME:-gitops-demo}"
K8S_VERSION="${K8S_VERSION:-v1.27.3}"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  GitOps Tutorial - Kind Cluster Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if Kind is installed
if ! command -v kind &> /dev/null; then
    echo -e "${RED}❌ Kind is not installed${NC}"
    echo ""
    echo "Please install Kind first:"
    echo "  macOS: brew install kind"
    echo "  Linux: curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64"
    echo "  Windows: choco install kind"
    echo ""
    echo "Visit: https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker is not running${NC}"
    echo ""
    echo "Please start Docker Desktop and try again"
    exit 1
fi

echo -e "${GREEN}✓${NC} Kind is installed: $(kind version)"
echo -e "${GREEN}✓${NC} Docker is running"
echo ""

# Check if cluster already exists
if kind get clusters 2>/dev/null | grep -q "^${CLUSTER_NAME}$"; then
    echo -e "${YELLOW}⚠️  Cluster '${CLUSTER_NAME}' already exists${NC}"
    echo ""
    read -p "Do you want to delete it and create a new one? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Deleting existing cluster...${NC}"
        kind delete cluster --name "${CLUSTER_NAME}"
        echo -e "${GREEN}✓${NC} Cluster deleted"
        echo ""
    else
        echo -e "${BLUE}Using existing cluster${NC}"
        echo ""
        echo "To access the cluster:"
        echo "  kubectl cluster-info --context kind-${CLUSTER_NAME}"
        exit 0
    fi
fi

# Create Kind configuration
echo -e "${BLUE}Creating Kind cluster configuration...${NC}"

cat > /tmp/kind-config.yaml <<EOF
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: ${CLUSTER_NAME}
nodes:
  - role: control-plane
    kubeadmConfigPatches:
    - |
      kind: InitConfiguration
      nodeRegistration:
        kubeletExtraArgs:
          node-labels: "ingress-ready=true"
    extraPortMappings:
    - containerPort: 80
      hostPort: 80
      protocol: TCP
    - containerPort: 443
      hostPort: 443
      protocol: TCP
  - role: worker
  - role: worker
EOF

echo -e "${GREEN}✓${NC} Configuration created"
echo ""

# Create cluster
echo -e "${BLUE}Creating Kind cluster '${CLUSTER_NAME}'...${NC}"
echo -e "${YELLOW}This may take a few minutes...${NC}"
echo ""

if kind create cluster --config /tmp/kind-config.yaml --image "kindest/node:${K8S_VERSION}"; then
    echo ""
    echo -e "${GREEN}✓${NC} Cluster created successfully!"
else
    echo ""
    echo -e "${RED}❌ Failed to create cluster${NC}"
    rm /tmp/kind-config.yaml
    exit 1
fi

# Clean up config file
rm /tmp/kind-config.yaml

# Wait for cluster to be ready
echo ""
echo -e "${BLUE}Waiting for cluster to be ready...${NC}"
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Cluster Setup Complete! 🎉${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Display cluster info
echo -e "${BLUE}Cluster Information:${NC}"
echo "  Name: ${CLUSTER_NAME}"
echo "  Context: kind-${CLUSTER_NAME}"
echo "  Kubernetes Version: ${K8S_VERSION}"
echo ""

# Display nodes
echo -e "${BLUE}Cluster Nodes:${NC}"
kubectl get nodes -o wide
echo ""

# Display useful commands
echo -e "${BLUE}Useful Commands:${NC}"
echo "  Access cluster:"
echo "    ${GREEN}kubectl cluster-info --context kind-${CLUSTER_NAME}${NC}"
echo ""
echo "  View nodes:"
echo "    ${GREEN}kubectl get nodes${NC}"
echo ""
echo "  Delete cluster:"
echo "    ${GREEN}kind delete cluster --name ${CLUSTER_NAME}${NC}"
echo ""

# Next steps
echo -e "${BLUE}Next Steps:${NC}"
echo "  1. Install Argo CD:"
echo "     ${GREEN}./install-argocd.sh${NC}"
echo ""
echo "  2. Or install Flux CD:"
echo "     ${GREEN}./install-flux.sh${NC}"
echo ""

echo -e "${GREEN}Happy GitOps-ing! 🚀${NC}"
