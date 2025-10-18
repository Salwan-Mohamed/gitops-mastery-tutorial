#!/bin/bash

# CRC Setup Script for OpenShift Local
# Part 6: GitOps with OpenShift

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}OpenShift Local (CRC) Setup${NC}"
echo -e "${GREEN}================================${NC}"
echo ""

# Check if CRC is installed
if ! command -v crc &> /dev/null; then
    echo -e "${RED}✗ CRC is not installed${NC}"
    echo ""
    echo "Please download and install CRC from:"
    echo "https://developers.redhat.com/products/openshift-local/overview"
    echo ""
    echo "Steps:"
    echo "1. Create a Red Hat account (free)"
    echo "2. Download CRC for your OS"
    echo "3. Extract and move 'crc' binary to your PATH"
    echo "4. Run this script again"
    exit 1
fi

echo -e "${GREEN}✓ CRC is installed${NC}"
crc version
echo ""

# Check system resources
echo -e "${YELLOW}Checking system resources...${NC}"

# Get available memory (in GB)
if [[ "$OSTYPE" == "darwin"* ]]; then
    TOTAL_MEM=$(sysctl hw.memsize | awk '{print int($2/1024/1024/1024)}')
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    TOTAL_MEM=$(free -g | awk '/^Mem:/{print $2}')
else
    TOTAL_MEM=0
fi

# Get CPU cores
if [[ "$OSTYPE" == "darwin"* ]]; then
    CPU_CORES=$(sysctl -n hw.ncpu)
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CPU_CORES=$(nproc)
else
    CPU_CORES=0
fi

echo "Total Memory: ${TOTAL_MEM} GB"
echo "CPU Cores: ${CPU_CORES}"
echo ""

if [ "$TOTAL_MEM" -lt 16 ]; then
    echo -e "${RED}✗ Insufficient memory. At least 16 GB RAM required.${NC}"
    echo "  CRC needs 12 GB, plus system overhead"
    exit 1
fi

if [ "$CPU_CORES" -lt 6 ]; then
    echo -e "${YELLOW}⚠ Warning: Less than 6 CPU cores detected${NC}"
    echo "  CRC may run slowly with fewer cores"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo -e "${GREEN}✓ System resources check passed${NC}"
echo ""

# Check if CRC is already set up
if crc status &> /dev/null; then
    CRC_STATUS=$(crc status | head -n 1)
    echo -e "${YELLOW}CRC is already configured${NC}"
    echo "Current status: $CRC_STATUS"
    echo ""
    read -p "Do you want to delete and reconfigure? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Stopping CRC..."
        crc stop || true
        echo "Deleting CRC..."
        crc delete -f
        echo "Cleaning up..."
        crc cleanup
    else
        echo "Keeping existing configuration"
        exit 0
    fi
fi

# Setup CRC
echo -e "${YELLOW}Setting up CRC (this may take 10-15 minutes)...${NC}"
crc setup

echo ""
echo -e "${GREEN}✓ CRC setup complete${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Download your pull secret from:"
echo "   https://console.redhat.com/openshift/create/local"
echo ""
echo "2. Start CRC with:"
echo "   crc start --cpus 6 --memory 12288"
echo ""
echo "3. You will be prompted to paste your pull secret"
echo ""
echo "4. After startup, get credentials with:"
echo "   crc console --credentials"
echo ""
echo "5. Access the console at:"
echo "   https://console-openshift-console.apps-crc.testing"
echo ""
