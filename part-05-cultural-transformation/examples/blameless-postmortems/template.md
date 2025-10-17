# Incident Post-Mortem Template

## Incident Overview

**Incident ID**: INC-YYYY-MM-DD-NNN  
**Date**: YYYY-MM-DD  
**Duration**: HH:MM  
**Severity**: [P0-Critical | P1-High | P2-Medium | P3-Low]  
**Status**: [Resolved | Investigating | Monitoring]

**Incident Commander**: [Name]  
**Participants**: [List of people involved]

## Executive Summary

[2-3 sentence summary of what happened and the impact]

**Example**: "On October 18, 2024, a Kubernetes upgrade from 1.24 to 1.25 caused security scanning tools to fail, resulting in blocked deployments for 2 hours. Customer impact was minimal as production services continued running, but new deployments were delayed."

---

## What Happened?

### Timeline

| Time (UTC) | Event | Action Taken |
|------------|-------|---------------|
| 10:00 | Platform team initiated K8s upgrade 1.24→1.25 | Upgrade started |
| 10:15 | Upgrade completed successfully | - |
| 10:20 | Security team's scanning tool stopped working | Investigation began |
| 10:30 | Identified PodSecurityPolicy deprecation | - |
| 10:45 | Decision to rollback vs fix-forward | - |
| 11:00 | Decided to implement PodSecurityStandards | - |
| 11:30 | New policies deployed and tested | - |
| 12:00 | All systems operational | Incident closed |

### Impact

**User Impact**:
- No customer-facing service disruption
- Internal deployments blocked for 2 hours
- Security scanning unavailable during incident

**Business Impact**:
- 3 planned feature releases delayed by 2 hours
- Estimated cost: $X,XXX in delayed deployments

**Technical Impact**:
- 15 applications pending deployment
- Security scanning gap of 2 hours
- Manual verification required for pending changes

---

## Why Did This Happen?

### Root Cause Analysis

**Primary Cause**:
[Describe the main technical or process issue - FOCUS ON SYSTEMS, NOT PEOPLE]

**Example**: "The Kubernetes 1.25 upgrade deprecated PodSecurityPolicies in favor of PodSecurityStandards. Our security scanning tool depended on PSPs and had no migration path documented."

**Contributing Factors**:
1. **Lack of communication**: Upgrade not announced in guild meeting
2. **Missing dependency mapping**: No documentation of which tools depend on K8s features
3. **Insufficient testing**: Upgrade tested on isolated cluster without security tools
4. **No deprecation tracking**: No process for tracking deprecated Kubernetes features

### What Worked Well?

✅ Incident detected within 5 minutes  
✅ All relevant teams joined incident channel quickly  
✅ Decision-making was clear and collaborative  
✅ Team remained calm and focused  
✅ Communication to stakeholders was timely  
✅ Documentation was updated during resolution

### What Didn't Work?

❌ No advance notice of breaking changes  
❌ Tools weren't tested in target environment  
❌ No rollback plan prepared  
❌ Dependency mapping incomplete  
❌ Guild meeting skipped that week

---

## What Are We Doing Differently?

### Immediate Actions (Completed)

- [x] Deployed PodSecurityStandards to all clusters
- [x] Updated security tool configuration
- [x] Verified all pending deployments
- [x] Documented PSP to PSS migration

### Short-term Actions (Next 2 Weeks)

- [ ] **Owner**: Platform Team | **Due**: 2024-10-25  
  Create Kubernetes upgrade checklist
  
- [ ] **Owner**: Security Team | **Due**: 2024-10-25  
  Document all tool dependencies on K8s features
  
- [ ] **Owner**: Platform Team | **Due**: 2024-11-01  
  Establish 2-week notice for infrastructure changes
  
- [ ] **Owner**: All Teams | **Due**: 2024-11-01  
  Resume weekly guild meetings (mandatory attendance)

### Long-term Actions (Next 1-3 Months)

- [ ] **Owner**: Platform Team | **Due**: 2024-11-15  
  Implement automated K8s deprecation tracking
  
- [ ] **Owner**: Platform Team | **Due**: 2024-12-01  
  Create staging environment that mirrors production (including all tools)
  
- [ ] **Owner**: Architecture Team | **Due**: 2024-12-15  
  Build comprehensive dependency map of all systems
  
- [ ] **Owner**: All Teams | **Due**: 2024-12-31  
  Establish change advisory board for major infrastructure changes

---

## Lessons Learned

### For Platform Team
- Major version upgrades require cross-team coordination
- Test upgrades in production-like environment, not isolated clusters
- Prepare rollback plans before executing changes

### For Security Team
- Maintain compatibility matrix for all security tools
- Subscribe to Kubernetes deprecation notices
- Test tools against beta K8s releases

### For Organization
- Guild meetings provide critical communication channel
- Dependency mapping prevents surprise breakages
- "It works in my environment" is not sufficient testing

### Process Improvements
- Establish change notification period (2 weeks minimum)
- Create pre-upgrade checklist for all teams to review
- Require guild meeting discussion for major changes

---

## Metrics

**Detection Time**: 5 minutes  
**Response Time**: 15 minutes  
**Resolution Time**: 2 hours  
**MTTR**: 2 hours

**DORA Metrics Impact**:
- Deployment Frequency: Temporarily reduced (2h window)
- Lead Time: Increased by 2h for pending changes
- Change Failure Rate: +1 failed change (upgrade)
- MTTR: 2h (within acceptable range)

---

## References

- [Kubernetes 1.25 Release Notes](https://kubernetes.io/blog/2022/08/23/kubernetes-v1-25-release/)
- [PodSecurityPolicy Deprecation Guide](https://kubernetes.io/docs/concepts/security/pod-security-policy/)
- [Our Internal Upgrade Runbook](../runbooks/kubernetes-upgrade.md)
- [Incident Slack Channel](#slack-link)
- [Monitoring Dashboard During Incident](#grafana-link)

---

## Sign-off

**Incident Commander**: [Name] - [Date]  
**Technical Lead**: [Name] - [Date]  
**Engineering Manager**: [Name] - [Date]

---

## Notes

### How to Use This Template

1. **Be factual, not emotional**: Stick to observable facts
2. **Focus on systems, not people**: "The process failed" not "Person X made a mistake"
3. **Be specific**: Exact times, exact impacts, exact actions
4. **Be actionable**: Every lesson learned should have an action item
5. **Be accountable**: Assign owners and due dates
6. **Be honest**: If we don't know something, say so

### Remember

- **NO BLAME**: This is about learning, not punishment
- **NO SHAME**: Everyone makes mistakes; systems should prevent them
- **NO HIDING**: Transparency builds trust and prevents recurrence

### Good Examples

✅ "The upgrade process didn't include testing with security tools"  
✅ "Our communication process didn't reach all affected teams"  
✅ "The monitoring alert didn't trigger because the query was misconfigured"

### Bad Examples

❌ "John forgot to test the upgrade"  
❌ "The security team should have known about the upgrade"  
❌ "This wouldn't have happened if people paid attention"

---

*This template is inspired by Google's SRE practices and adapted for GitOps environments.*