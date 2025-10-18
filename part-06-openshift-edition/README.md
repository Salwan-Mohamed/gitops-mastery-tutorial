# Part 6: GitOps with OpenShift - Enterprise Edition

[![OpenShift](https://img.shields.io/badge/OpenShift-4.14+-red.svg)](https://www.redhat.com/en/technologies/cloud-computing/openshift)
[![Argo CD](https://img.shields.io/badge/Argo%20CD-v2.9+-green.svg)](https://argo-cd.readthedocs.io/)
[![Red Hat](https://img.shields.io/badge/Red%20Hat-Enterprise-red.svg)](https://www.redhat.com/)

Welcome to Part 6 of the GitOps Mastery series! In this part, we explore how GitOps principles work within Red Hat OpenShift, bringing enterprise-grade features and security to your deployments.

## 📖 What You'll Learn

- **OpenShift Fundamentals**: Understanding OpenShift vs vanilla Kubernetes
- **Local Setup**: Setting up OpenShift Local (CRC) for development
- **GitOps on OpenShift**: Installing and configuring Argo CD using Operators
- **Production Best Practices**: High availability, security, and scaling patterns
- **Real-World Examples**: Weather application deployment with GitOps workflow
- **Enterprise Features**: Security Context Constraints, built-in CI/CD, and more

## 🎯 Learning Objectives

By the end of this part, you will be able to:

✅ Set up a local OpenShift cluster using CodeReady Containers (CRC)  
✅ Install OpenShift GitOps Operator and deploy Argo CD  
✅ Deploy applications using GitOps methodology on OpenShift  
✅ Implement production-ready configurations for high availability  
✅ Apply enterprise security best practices  
✅ Understand the differences between Kubernetes and OpenShift  
✅ Troubleshoot common OpenShift deployment issues  

## 📋 Prerequisites

### Required Software

- **Operating System**: Windows 10/11, macOS 12+, or Linux (Fedora/RHEL/Ubuntu)
- **RAM**: 16 GB minimum (12 GB allocated to CRC)
- **CPU**: 6 cores minimum
- **Disk Space**: 35 GB free
- **Red Hat Account**: Free account for pull secret (create at [Red Hat Developer](https://developers.redhat.com/))

### Required Tools

```bash
# OpenShift Local (CRC)
# Download from: https://developers.redhat.com/products/openshift-local/overview

# OpenShift CLI (oc)
# Download from: https://docs.openshift.com/container-platform/4.14/cli_reference/openshift_cli/getting-started-cli.html

# kubectl (optional but recommended)
kubectl version --client

# Git
git --version
```

### Knowledge Prerequisites

- Basic Kubernetes concepts (pods, deployments, services)
- Git fundamentals
- YAML syntax
- Command-line proficiency
- Understanding of Part 1-5 of this tutorial series (recommended)

## 🗂️ Directory Structure

```
part-06-openshift-edition/
│
├── README.md                           # This file
├── article.md                          # Full tutorial article
│
├── 01-setup/
│   ├── README.md
│   ├── crc-setup.sh                   # CRC installation script
│   ├── verify-setup.sh                # Setup verification
│   └── troubleshooting.md             # Common setup issues
│
├── 02-operator-installation/
│   ├── README.md
│   ├── gitops-operator.yaml           # OpenShift GitOps Operator
│   ├── create-project.yaml            # Project definition
│   └── argocd-instance.yaml           # Argo CD instance config
│
├── 03-weather-app/
│   ├── README.md
│   ├── deployment/
│   │   └── base/
│   │       ├── deployment.yaml        # App deployment
│   │       ├── service.yaml           # Service definition
│   │       └── kustomization.yaml     # Kustomize config
│   ├── argocd-application.yaml        # Argo CD app definition
│   └── update-replicas.sh             # Demo scaling script
│
├── 04-production-configs/
│   ├── README.md
│   ├── high-availability/
│   │   ├── multi-replica-deployment.yaml
│   │   ├── pod-disruption-budget.yaml
│   │   └── anti-affinity-rules.yaml
│   ├── security/
│   │   ├── security-context.yaml
│   │   ├── network-policy.yaml
│   │   ├── sealed-secret-example.yaml
│   │   └── scc-restricted.yaml
│   ├── monitoring/
│   │   ├── prometheus-rule.yaml
│   │   ├── grafana-dashboard.json
│   │   └── alertmanager-config.yaml
│   └── autoscaling/
│       ├── hpa.yaml
│       └── vpa.yaml
│
├── 05-best-practices/
│   ├── README.md
│   ├── resource-limits-example.yaml
│   ├── health-probes-example.yaml
│   ├── rollout-strategy-example.yaml
│   ├── secrets-management-example.yaml
│   └── multi-stage-dockerfile
│
├── 06-comparison/
│   ├── README.md
│   ├── kubernetes-vs-openshift.md
│   └── decision-matrix.md
│
├── scripts/
│   ├── setup-openshift-local.sh      # Complete setup script
│   ├── install-gitops-operator.sh    # GitOps operator installation
│   ├── deploy-weather-app.sh         # Deploy demo application
│   ├── cleanup.sh                    # Cleanup resources
│   └── quick-start.sh                # All-in-one setup
│
├── docs/
│   ├── installation-guide.md         # Detailed installation
│   ├── troubleshooting.md            # Troubleshooting guide
│   ├── security-hardening.md         # Security best practices
│   └── production-checklist.md       # Pre-production checklist
│
└── case-studies/
    ├── bloomberg-example.md
    ├── fintech-deployment.md
    └── healthcare-compliance.md
```

## 🚀 Quick Start

### Option 1: Developer Sandbox (No Installation)

The fastest way to get started with OpenShift:

```bash
# 1. Visit Red Hat Developer Sandbox
# https://developers.redhat.com/developer-sandbox

# 2. Sign up for free (30 days access)

# 3. Get your login command from the web console

# 4. Login via CLI
oc login --token=<your-token> --server=<your-server>

# 5. Skip to 02-operator-installation
```

### Option 2: OpenShift Local (Full Control)

For local development with full cluster control:

```bash
# 1. Clone this repository
git clone https://github.com/Salwan-Mohamed/gitops-mastery-tutorial.git
cd gitops-mastery-tutorial/part-06-openshift-edition

# 2. Run the complete setup script
./scripts/quick-start.sh

# This script will:
# - Verify prerequisites
# - Download and install CRC
# - Start OpenShift cluster
# - Install OpenShift GitOps Operator
# - Deploy Argo CD instance
# - Deploy weather app demo

# 3. Access your cluster
# OpenShift Console: https://console-openshift-console.apps-crc.testing
# Argo CD UI: (URL provided by script)
```

### Manual Step-by-Step Setup

If you prefer to understand each step:

```bash
# Step 1: Install CRC
cd 01-setup
./crc-setup.sh

# Step 2: Start OpenShift
crc start --cpus 6 --memory 12288

# Step 3: Install GitOps Operator
cd ../02-operator-installation
oc apply -f gitops-operator.yaml

# Step 4: Create Project and Argo CD
oc apply -f create-project.yaml
oc apply -f argocd-instance.yaml

# Step 5: Deploy Weather App
cd ../03-weather-app
oc apply -f argocd-application.yaml

# Step 6: Verify deployment
oc get pods -n gitops-deployments
```

## 📖 Tutorial Walkthrough

### Section 1: Understanding OpenShift
- What makes OpenShift different from Kubernetes
- Security features (SELinux, SCCs)
- Developer experience improvements
- Built-in CI/CD capabilities

### Section 2: Setting Up Your Environment
- Installing OpenShift Local (CRC)
- Installing OpenShift CLI (`oc`)
- Accessing the web console
- Verifying your installation

### Section 3: Installing GitOps
- Understanding OpenShift Operators
- Installing OpenShift GitOps Operator
- Creating Argo CD instance
- Accessing Argo CD UI

### Section 4: First GitOps Deployment
- Creating a project
- Deploying weather application
- Understanding sync status
- Making changes via Git

### Section 5: Production Best Practices
- High availability configurations
- Resource limits and requests
- Health probes (liveness, readiness, startup)
- Pod disruption budgets
- Horizontal pod autoscaling

### Section 6: Security Hardening
- Running as non-root user
- Security Context Constraints
- Network policies
- Secrets management
- Image security

### Section 7: Monitoring and Operations
- Built-in monitoring stack
- Creating alerts
- Dashboard customization
- Log aggregation

## 🛠️ Hands-On Exercises

### Exercise 1: Deploy Your First App
**Objective**: Deploy the weather application using GitOps

```bash
cd 03-weather-app
oc apply -f argocd-application.yaml
```

**Expected Outcome**: Application synced and healthy in Argo CD

### Exercise 2: Scale via Git
**Objective**: Change replica count through Git

```bash
# 1. Edit deployment/base/deployment.yaml
# Change replicas from 2 to 5

# 2. Commit and push
git add deployment/base/deployment.yaml
git commit -m "Scale to 5 replicas"
git push

# 3. Sync in Argo CD (manual or automatic)
```

**Expected Outcome**: 5 pods running

### Exercise 3: Implement Health Probes
**Objective**: Add liveness and readiness probes

```bash
cd 05-best-practices
# Study health-probes-example.yaml
# Apply to your deployment
```

**Expected Outcome**: Pods restart automatically on failure

### Exercise 4: Configure Autoscaling
**Objective**: Set up HorizontalPodAutoscaler

```bash
cd 04-production-configs/autoscaling
oc apply -f hpa.yaml
```

**Expected Outcome**: Pods scale based on CPU utilization

### Exercise 5: Secure with Network Policies
**Objective**: Implement network segmentation

```bash
cd 04-production-configs/security
oc apply -f network-policy.yaml
```

**Expected Outcome**: Only allowed traffic flows

## 🔧 Troubleshooting

### CRC Won't Start

```bash
# Clean slate approach
crc delete -f
crc cleanup
crc setup
crc start --cpus 6 --memory 12288
```

### Can't Access OpenShift Console

```bash
# Get URL
crc console --url

# Get credentials
crc console --credentials
```

### Argo CD Pods Not Running

```bash
# Check operator status
oc get csv -n openshift-gitops-operator

# Check Argo CD instance
oc get argocd -n gitops-deployments

# View events
oc get events -n gitops-deployments --sort-by='.lastTimestamp'
```

### Application OutOfSync

```bash
# Check app status
oc get application weather-app -n gitops-deployments

# View detailed diff
oc describe application weather-app -n gitops-deployments

# Force sync
oc patch application weather-app -n gitops-deployments \
  --type merge -p '{"operation":{"initiatedBy":{"username":"admin"},"sync":{"revision":"HEAD"}}}'
```

See [docs/troubleshooting.md](./docs/troubleshooting.md) for more solutions.

## 📊 Real-World Examples

### Example 1: E-commerce Platform
**Scenario**: Deploy microservices with high availability

```bash
cd 04-production-configs/high-availability
cat multi-replica-deployment.yaml
```

**Key Features**:
- 5 replicas across availability zones
- Pod anti-affinity rules
- Pod disruption budget (min 3 available)
- Rolling update strategy

### Example 2: FinTech Security
**Scenario**: SOC 2 compliant deployment

```bash
cd 04-production-configs/security
ls -la
```

**Key Features**:
- Non-root containers
- Network policies
- Sealed secrets
- Security scanning

### Example 3: Healthcare HIPAA
**Scenario**: HIPAA compliant workload

```bash
cd case-studies/healthcare-compliance.md
```

**Key Features**:
- Encrypted secrets
- Audit logging
- Network isolation
- Compliance reporting

## 🎯 Success Criteria

After completing this part, you should be able to:

- [ ] Install and configure OpenShift Local
- [ ] Deploy applications using OpenShift GitOps
- [ ] Implement high availability patterns
- [ ] Apply security best practices
- [ ] Configure monitoring and alerting
- [ ] Troubleshoot common issues
- [ ] Explain OpenShift vs Kubernetes differences

## 📚 Additional Resources

### Official Documentation
- [Red Hat OpenShift Documentation](https://docs.openshift.com/)
- [OpenShift Local Documentation](https://access.redhat.com/documentation/en-us/red_hat_openshift_local/)
- [OpenShift GitOps Documentation](https://docs.openshift.com/container-platform/4.14/cicd/gitops/understanding-openshift-gitops.html)

### Learning Resources
- [Red Hat Developer](https://developers.redhat.com/)
- [OpenShift Interactive Learning](https://learn.openshift.com/)
- [OpenShift Blog](https://www.openshift.com/blog)

### Community
- [OpenShift Commons](https://commons.openshift.org/)
- [Argo CD Slack](https://argoproj.github.io/community/join-slack)
- [Reddit r/openshift](https://www.reddit.com/r/openshift/)

### Tools
- [odo (OpenShift Do)](https://odo.dev/)
- [OpenShift CLI (oc)](https://docs.openshift.com/container-platform/4.14/cli_reference/openshift_cli/getting-started-cli.html)
- [k9s for OpenShift](https://k9scli.io/)

## 🤝 Contributing

Found an issue or want to improve this part?

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/improved-openshift-section`)
3. Commit your changes (`git commit -am 'Add improved OpenShift example'`)
4. Push to the branch (`git push origin feature/improved-openshift-section`)
5. Create a Pull Request

## 💬 Get Help

- **Questions**: Open a [GitHub Discussion](https://github.com/Salwan-Mohamed/gitops-mastery-tutorial/discussions)
- **Bugs**: Report an [Issue](https://github.com/Salwan-Mohamed/gitops-mastery-tutorial/issues)
- **Direct Help**: Comment on the [article](./article.md)

## ⭐ Show Your Support

If this part helped you:
- ⭐ Star this repository
- 📝 Share on social media
- 💬 Leave feedback
- 🤝 Contribute improvements

---

**Ready to dive into OpenShift?** Start with the [Setup Guide](./01-setup/README.md) or jump straight to the [Full Article](./article.md)! 🚀

---

**Previous**: [Part 5: Cultural Transformation](../part-05-cultural-transformation/README.md)  
**Next**: Part 7: Cloud-Native GitOps - Azure and AWS (Coming Soon)

---

*Part of the GitOps Mastery Tutorial Series*  
*Repository: https://github.com/Salwan-Mohamed/gitops-mastery-tutorial*  
*Last Updated: October 2025*
