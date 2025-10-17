# RACI Matrix for GitOps Teams

## What is RACI?

**R** = **Responsible** - Does the work  
**A** = **Accountable** - Makes final decisions (only one A per task)  
**C** = **Consulted** - Provides input  
**I** = **Informed** - Kept up-to-date

## Core Principle

> "Everyone knows their lane. Nobody's surprised."

---

## GitOps RACI Matrix

### Application Management

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Write application code | **R** | C | I | I | **A** |
| Write Kubernetes manifests | **R** | C | C | I | **A** |
| Create application PR | **R** | I | I | I | I |
| Review application PR | C | **R** | **R** | I | **A** |
| Merge application PR | **R** | I | I | I | **A** |
| Deploy to development | **R** | C | I | I | **A** |
| Deploy to staging | **R** | C | C | I | **A** |
| Deploy to production | **R** | C | **R** | **A** | I |
| Monitor application health | C | **R** | I | **A** | I |
| Fix application bugs | **R** | C | I | I | **A** |
| Update dependencies | **R** | C | **R** | I | **A** |

### Infrastructure Management

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Provision Kubernetes clusters | I | **R** | C | **A** | I |
| Configure cluster networking | I | **R** | C | **A** | I |
| Manage cluster upgrades | C | **R** | C | **A** | I |
| Install GitOps tools (Argo CD) | I | **R** | C | **A** | I |
| Configure ingress controllers | C | **R** | C | **A** | I |
| Manage cert-manager | I | **R** | C | **A** | I |
| Provision cloud resources | C | **R** | C | **A** | I |
| Manage IaC (Terraform/Crossplane) | C | **R** | C | **A** | I |
| Create namespace structures | C | **R** | I | **A** | I |
| Configure RBAC | C | **R** | **R** | **A** | I |

### Security & Compliance

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Define security policies | C | C | **R** | **A** | I |
| Implement Kyverno policies | C | **R** | **R** | **A** | I |
| Scan container images | I | C | **R** | **A** | I |
| Manage secrets (Vault/Sealed) | C | **R** | **R** | **A** | I |
| Review security policies PR | C | C | **R** | **A** | I |
| Conduct security audits | C | C | **R** | **A** | I |
| Respond to security alerts | **R** | **R** | **R** | **A** | I |
| Apply security patches | **R** | **R** | C | **A** | I |
| Network policy management | C | **R** | **R** | **A** | I |
| Compliance reporting | I | C | **R** | **A** | C |

### GitOps Operations

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Configure Argo CD applications | **R** | C | I | **A** | I |
| Manage ApplicationSets | C | **R** | I | **A** | I |
| Handle sync failures | **R** | **R** | I | **A** | I |
| Monitor drift detection | C | **R** | I | **A** | I |
| Manage Git repositories | **R** | C | I | **A** | I |
| Define branch strategies | C | **R** | I | **A** | C |
| Configure webhooks | I | **R** | C | **A** | I |
| Manage Argo CD RBAC | C | **R** | C | **A** | I |
| Troubleshoot sync issues | **R** | **R** | I | **A** | I |

### Incident Response

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Detect incidents | **R** | **R** | **R** | **A** | I |
| Create incident channel | I | **R** | I | **A** | I |
| Incident Commander role | C | C | I | **A** | I |
| Diagnose application issues | **R** | C | I | **A** | I |
| Diagnose infrastructure issues | C | **R** | I | **A** | I |
| Diagnose security issues | C | C | **R** | **A** | I |
| Execute rollback | **R** | C | C | **A** | I |
| Communicate to stakeholders | C | C | I | **A** | **R** |
| Write post-mortem | **R** | **R** | **R** | **A** | C |
| Implement fixes | **R** | **R** | **R** | **A** | I |

### Monitoring & Observability

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Define application metrics | **R** | C | I | **A** | C |
| Configure Prometheus | C | **R** | I | **A** | I |
| Create Grafana dashboards | C | **R** | I | **A** | I |
| Set up alerting rules | C | **R** | I | **A** | I |
| Monitor application logs | **R** | C | I | **A** | I |
| Monitor infrastructure logs | I | **R** | I | **A** | I |
| Monitor security logs | I | C | **R** | **A** | I |
| Respond to alerts | **R** | **R** | **R** | **A** | I |
| Tune alert thresholds | **R** | **R** | I | **A** | I |

### Communication & Governance

| Task | Developer | Platform Engineer | Security | Operations | Product |
|------|-----------|-------------------|----------|------------|----------|
| Attend guild meetings | **R** | **R** | **R** | **R** | **R** |
| Present changes at guild | **R** | **R** | **R** | I | C |
| Document decisions | **R** | **R** | **R** | **R** | C |
| Maintain runbooks | **R** | **R** | **R** | **A** | I |
| Update team documentation | **R** | **R** | **R** | **A** | I |
| Create RFCs for major changes | **R** | **R** | **R** | **A** | C |
| Review RFCs | C | C | C | **A** | C |
| Track DORA metrics | C | **R** | I | **A** | C |
| Report on GitOps maturity | C | **R** | C | **A** | **R** |

---

## How to Use This Matrix

### Step 1: Customize for Your Organization

Copy this template and adjust:
- Add/remove roles based on your team structure
- Add/remove tasks based on your responsibilities
- Adjust R/A/C/I assignments based on your processes

### Step 2: Review with All Teams

1. Schedule a cross-team meeting
2. Go through each section
3. Discuss and agree on assignments
4. Document disagreements for leadership escalation
5. Get sign-off from all team leads

### Step 3: Publish and Enforce

1. Add to your GitOps repository
2. Reference in onboarding materials
3. Review during incidents ("Who should have been involved?")
4. Update quarterly as processes evolve

### Step 4: Monitor Effectiveness

Track:
- Are incidents resolved faster?
- Are teams surprised less often?
- Do people know who to ask for help?
- Are responsibilities clear during changes?

---

## Common Mistakes to Avoid

### ❌ Multiple 'A's per Task
**Problem**: Too many decision-makers creates confusion  
**Solution**: Only one person is Accountable. Others are Consulted.

### ❌ Everyone is 'R' or 'A'
**Problem**: No clear ownership  
**Solution**: Be specific. Someone must own it.

### ❌ Too Many People Involved
**Problem**: Slows down decision-making  
**Solution**: Limit C's to 2-3 people. Use I for awareness.

### ❌ Never Updating the Matrix
**Problem**: Matrix becomes outdated and ignored  
**Solution**: Review quarterly. Update after major org changes.

---
## Team-Specific Guidance

### For Developers
You are **Responsible** for:
- Your application code and manifests
- Deploying to development/staging
- Monitoring your applications
- Fixing bugs in your code

You are **Consulted** on:
- Infrastructure changes that affect your apps
- Security policies that might break functionality
- Platform improvements and new tools

### For Platform Engineers
You are **Responsible** for:
- Kubernetes cluster health and upgrades
- GitOps tooling (Argo CD, Flux)
- Infrastructure as Code
- Enabling developer self-service

You are **Accountable** (along with Ops) for:
- Overall platform stability
- Incident response coordination

### For Security Team
You are **Responsible** for:
- Security policies and their enforcement
- Vulnerability scanning and remediation
- Secrets management
- Compliance auditing

You are **Consulted** on:
- Application architectures
- Infrastructure changes
- Tool selections

### For Operations
You are **Accountable** for:
- Production stability
- Incident response
- SLA compliance
- Final go/no-go decisions for production

You coordinate but don't do all the work.

---

## Real Example: Deploying to Production

**Scenario**: Developer wants to deploy new feature to production

| Step | Who | Role | What They Do |
|------|-----|------|---------------|
| 1. Create PR | Developer | R | Write code, update manifests |
| 2. Code Review | Developer Team | C | Review code quality |
| 3. Security Review | Security | R | Check for vulnerabilities |
| 4. Platform Review | Platform | R | Check resource requirements |
| 5. Approval | Product/Ops | A | Final go/no-go decision |
| 6. Merge | Developer | R | Merge to main |
| 7. Auto-Deploy | Argo CD | - | GitOps sync |
| 8. Monitor | Developer + Platform | R | Watch metrics and logs |
| 9. Rollback (if needed) | Ops | A | Make decision |
| 10. Execute Rollback | Developer | R | Git revert + push |

**Key Points**:
- Developer does the work (R)
- Security & Platform provide input (R for review)
- Operations makes final call (A)
- Product might be A if business-critical feature

---

## Escalation Matrix

When RACI conflicts arise:

1. **R vs R conflict**: Team leads resolve
2. **A unclear**: Engineering Manager decides
3. **Too many C's**: Accountable person limits
4. **Nobody wants A**: Director assigns

**Remember**: The person who is **Accountable** has final say and takes responsibility for outcomes.

---

## Change Log

| Date | Change | Reason |
|------|---------|--------|
| 2024-10-18 | Initial version | Start of GitOps transformation |
| | | |
| | | |

---

*Review this RACI matrix quarterly or after major organizational changes.*