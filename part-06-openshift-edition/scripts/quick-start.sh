#!/bin/bash

# Quick Start Script for Part 6: GitOps with OpenShift
# This script automates the entire setup process

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}GitOps with OpenShift - Quick Start${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Function to print step
print_step() {
    echo -e "${GREEN}[STEP $1/$2]${NC} $3"
}

# Function to check command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

TOTAL_STEPS=7
CURRENT_STEP=0

# Step 1: Check prerequisites
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Checking prerequisites..."
echo ""

if ! command_exists crc; then
    echo -e "${RED}✗ CRC is not installed${NC}"
    echo "Please install from: https://developers.redhat.com/products/openshift-local/overview"
    exit 1
fi
echo -e "${GREEN}✓ CRC installed${NC}"

if ! command_exists oc; then
    echo -e "${YELLOW}⚠ oc CLI not found${NC}"
    echo "You can install it later, but it's recommended"
fi

echo ""

# Step 2: Check if CRC is running
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Checking CRC status..."
echo ""

if ! crc status &> /dev/null; then
    echo -e "${YELLOW}CRC is not running${NC}"
    echo "Starting CRC (this may take 5-10 minutes)..."
    echo ""
    crc start --cpus 6 --memory 12288
else
    CRC_STATUS=$(crc status | grep "OpenShift" | awk '{print $2}')
    if [ "$CRC_STATUS" != "Running" ]; then
        echo "Starting CRC..."
        crc start
    else
        echo -e "${GREEN}✓ CRC is already running${NC}"
    fi
fi

echo ""

# Step 3: Setup oc environment
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Setting up oc environment..."
echo ""

eval $(crc oc-env)
echo -e "${GREEN}✓ oc environment configured${NC}"
echo ""

# Step 4: Login as admin
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Logging in as kubeadmin..."
echo ""

# Get credentials
ADMIN_PASS=$(crc console --credentials | grep "To login as an admin" -A 2 | grep "Password" | awk '{print $2}')
oc login -u kubeadmin -p $ADMIN_PASS https://api.crc.testing:6443 --insecure-skip-tls-verify=true

echo -e "${GREEN}✓ Logged in successfully${NC}"
echo ""

# Step 5: Install OpenShift GitOps Operator
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Installing OpenShift GitOps Operator..."
echo ""

# Check if operator is already installed
if oc get csv -n openshift-gitops-operator | grep -q "openshift-gitops-operator"; then
    echo -e "${GREEN}✓ OpenShift GitOps Operator already installed${NC}"
else
    echo "Installing operator... (this may take 2-3 minutes)"
    
    # Note: In real setup, you'd install via OperatorHub
    # For automation, we'll check if it's available
    echo -e "${YELLOW}Please install OpenShift GitOps Operator via OperatorHub:${NC}"
    echo "1. Open OpenShift Console: https://console-openshift-console.apps-crc.testing"
    echo "2. Go to Operators -> OperatorHub"
    echo "3. Search for 'OpenShift GitOps'"
    echo "4. Click Install"
    echo ""
    read -p "Press Enter once the operator is installed..."
fi

echo ""

# Step 6: Create project and Argo CD instance
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Creating project and Argo CD instance..."
echo ""

# Create project
if oc get project gitops-deployments &> /dev/null; then
    echo -e "${GREEN}✓ Project 'gitops-deployments' already exists${NC}"
else
    oc new-project gitops-deployments --display-name="GitOps Deployments Demo"
    echo -e "${GREEN}✓ Project created${NC}"
fi

# Apply Argo CD instance
if oc get argocd argocd-demo -n gitops-deployments &> /dev/null; then
    echo -e "${GREEN}✓ Argo CD instance already exists${NC}"
else
    oc apply -f ../02-operator-installation/argocd-instance.yaml
    echo "Waiting for Argo CD to be ready..."
    sleep 30
    oc wait --for=condition=Ready pods --all -n gitops-deployments --timeout=300s
    echo -e "${GREEN}✓ Argo CD instance created${NC}"
fi

echo ""

# Step 7: Deploy weather app
((CURRENT_STEP++))
print_step $CURRENT_STEP $TOTAL_STEPS "Deploying weather application..."
echo ""

if oc get application weather-app -n gitops-deployments &> /dev/null; then
    echo -e "${GREEN}✓ Weather app already deployed${NC}"
else
    oc apply -f ../03-weather-app/argocd-application.yaml
    echo "Waiting for application to sync..."
    sleep 10
    echo -e "${GREEN}✓ Weather app deployed${NC}"
fi

echo ""
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}Setup Complete! 🎉${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""

# Get URLs and credentials
CONSOLE_URL="https://console-openshift-console.apps-crc.testing"
ARGOCD_URL=$(oc get route argocd-demo-server -n gitops-deployments -o jsonpath='{.spec.host}' 2>/dev/null || echo "Not available yet")
ARGOCD_PASS=$(oc get secret argocd-demo-cluster -n gitops-deployments -o jsonpath='{.data.admin\.password}' 2>/dev/null | base64 -d || echo "Not available yet")

echo -e "${BLUE}Access Information:${NC}"
echo ""
echo -e "${YELLOW}OpenShift Console:${NC}"
echo "  URL: $CONSOLE_URL"
echo "  Username: kubeadmin"
echo "  Password: $ADMIN_PASS"
echo ""
echo -e "${YELLOW}Argo CD:${NC}"
echo "  URL: https://$ARGOCD_URL"
echo "  Username: admin"
echo "  Password: $ARGOCD_PASS"
echo ""
echo -e "${YELLOW}Useful Commands:${NC}"
echo "  Check CRC status:        crc status"
echo "  Stop CRC:                crc stop"
echo "  Open console:            crc console"
echo "  Get pods:                oc get pods -n gitops-deployments"
echo "  Get applications:        oc get applications -n gitops-deployments"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Open Argo CD UI and explore the weather app"
echo "2. Try scaling the app by editing the deployment YAML"
echo "3. Explore the production configs in 04-production-configs/"
echo "4. Read the full article in article.md"
echo ""
