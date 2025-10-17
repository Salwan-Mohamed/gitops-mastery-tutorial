# GitOps Guild Meeting Agenda

**Date**: YYYY-MM-DD  
**Time**: HH:MM - HH:MM (Time Zone)  
**Location**: [Meeting Room / Video Link]  
**Facilitator**: [Name]  
**Note Taker**: [Name]

---

## Attendees

### Required
- [ ] Developer Team Representative
- [ ] Platform Engineering Representative
- [ ] Security Team Representative
- [ ] Operations Representative

### Optional
- [ ] Product Management
- [ ] QA/Testing Team
- [ ] SRE Team

### Absent
- [List any absent members]

---

## Meeting Objectives

1. Share upcoming changes across teams
2. Discuss recent incidents and learnings
3. Resolve cross-team blockers
4. Align on GitOps standards and practices

---

## Agenda

### 1. Quick Wins & Celebrations (5 min)

*Start positive! Celebrate recent successes.*

- 🎉 [Team/Person] - [What they accomplished]
- 🎉 [Achievement]
- 🎉 [Milestone reached]

**DORA Metrics Snapshot**:
- Deployment Frequency: [X/week] (↑↓ from last week)
- Lead Time: [X minutes]
- Change Failure Rate: [X%]
- MTTR: [X minutes]

---

### 2. Upcoming Changes (Next 2 Weeks) (15 min)

*Each team shares planned changes that might affect others.*

#### Developer Team
**Change**: [Description]  
**Timeline**: [Date]  
**Impact**: [Who/what is affected]  
**Action Needed**: [What others need to do, if anything]  
**Questions**: [Open discussion]

**Example**:
- **Change**: Migrating payment service to new database
- **Timeline**: October 25, 2024
- **Impact**: Platform team (need new DB provisioned), Security (need to update network policies)
- **Action Needed**: Platform to provision PostgreSQL by Oct 23
- **Questions**: Can we use managed Azure PostgreSQL?

---

#### Platform Team
**Change**: [Description]  
**Timeline**: [Date]  
**Impact**: [Who/what is affected]  
**Action Needed**: [What others need to do]  
**Questions**: [Open discussion]

**Example**:
- **Change**: Kubernetes upgrade 1.27 → 1.28
- **Timeline**: November 1, 2024
- **Impact**: All teams (test applications compatibility)
- **Action Needed**: All teams test in staging by Oct 28
- **Questions**: Are there any deprecated APIs we're using?

---

#### Security Team
**Change**: [Description]  
**Timeline**: [Date]  
**Impact**: [Who/what is affected]  
**Action Needed**: [What others need to do]  
**Questions**: [Open discussion]

**Example**:
- **Change**: New Kyverno policy requiring read-only root filesystem
- **Timeline**: October 30, 2024 (audit mode), November 15 (enforce)
- **Impact**: All applications
- **Action Needed**: Developers update SecurityContext in manifests
- **Questions**: Which apps need exemptions?

---

#### Operations Team
**Change**: [Description]  
**Timeline**: [Date]  
**Impact**: [Who/what is affected]  
**Action Needed**: [What others need to do]  
**Questions**: [Open discussion]

---

### 3. Recent Incidents & Learnings (15 min)

*Blameless discussion of recent incidents.*

#### Incident: [INC-YYYY-MM-DD-NNN]
**Date**: [Date]  
**Duration**: [Time]  
**Impact**: [Description]

**What Happened** (brief):
[2-3 sentences]

**Root Cause**:
[Focus on system/process failure, not people]

**What We're Doing Differently**:
1. [Action item] - Owner: [Name] - Due: [Date]
2. [Action item] - Owner: [Name] - Due: [Date]

**Lessons for Guild**:
- [Learning that applies to everyone]
- [Process improvement suggestion]

---

### 4. Blockers & Help Needed (10 min)

*Quick round-robin: What's blocking your team?*

#### Developer Team
- **Blocker**: [Description]
- **Help Needed From**: [Team]
- **Resolution**: [Agreed action]

#### Platform Team
- **Blocker**: [Description]
- **Help Needed From**: [Team]
- **Resolution**: [Agreed action]

#### Security Team
- **Blocker**: [Description]
- **Help Needed From**: [Team]
- **Resolution**: [Agreed action]

#### Operations Team
- **Blocker**: [Description]
- **Help Needed From**: [Team]
- **Resolution**: [Agreed action]

---

### 5. Standards & Process Updates (10 min)

*Discuss improvements to GitOps practices.*

#### Proposed Changes

**Proposal**: [Description]  
**Sponsor**: [Name/Team]  
**Rationale**: [Why this change]  
**Discussion**: [Summary of discussion]  
**Decision**: [Approved / Rejected / Table for next meeting]  
**Action Items**: [If approved, what needs to happen]

**Example**:
- **Proposal**: Require 2 approvals for production PRs
- **Sponsor**: Security Team
- **Rationale**: Reduce change failure rate from 8% to <5%
- **Discussion**: Developers concerned about slowing velocity; agreed to try for 1 month
- **Decision**: Approved for 1-month trial
- **Action Items**: Platform to update branch protection rules

---

### 6. Knowledge Sharing (10 min)

*Optional: One team demonstrates something useful.*

**Topic**: [Title]  
**Presenter**: [Name]  
**Summary**: [What was shared]
**Resources**: [Links to docs, tools, etc.]

**Example Topics**:
- How to use PR-Generator for preview environments
- New Grafana dashboard for application metrics
- Security scanning integration in CI
- Debugging Argo CD sync failures

---

### 7. Action Items Review (5 min)

*Quick review of all action items from this meeting.*

| Action Item | Owner | Due Date | Status |
|-------------|-------|----------|--------|
| [Task] | [Name] | [Date] | ☐ Todo |
| [Task] | [Name] | [Date] | ☐ Todo |
| [Task] | [Name] | [Date] | ☐ Todo |

---

### 8. Open Floor (5 min)

*Anything else to discuss?*

- [Topic]
- [Topic]

---

## Decisions Made

1. **Decision**: [Description]  
   **Rationale**: [Why]  
   **Effective**: [Date]

2. **Decision**: [Description]  
   **Rationale**: [Why]  
   **Effective**: [Date]

---

## Parking Lot

*Topics that need more time, schedule follow-up.*

- [ ] [Topic] - Owner: [Name] - Follow-up: [Date/Meeting]
- [ ] [Topic] - Owner: [Name] - Follow-up: [Date/Meeting]

---

## Next Meeting

**Date**: [Next week same time]  
**Facilitator**: [Rotate to next person]  
**Note Taker**: [Rotate to next person]

**Proposed Topics**:
- Follow-up on [action items from this meeting]
- [Suggested topic from parking lot]

---

## Meeting Feedback

*Optional: Quick pulse check*

😀 Productive meeting, clear outcomes  
😐 Useful but could be better  
😟 Waste of time, needs major changes

**Improvement suggestions**:
- [Feedback]

---

## Notes & Resources

### Useful Links
- [GitOps Repository](https://github.com/company/gitops-platform)
- [DORA Metrics Dashboard](https://grafana.company.com/dora)
- [Incident Channel](#slack-incident-channel)
- [Previous Guild Meeting Notes](../guild-meetings/)

### Acronyms
- **DORA**: DevOps Research and Assessment
- **MTTR**: Mean Time To Recovery
- **PR**: Pull Request
- **RACI**: Responsible, Accountable, Consulted, Informed

---

## Distribution

**Share these notes with**:
- All attendees
- Team mailing lists
- Post in Slack #gitops-guild channel
- Archive in repository: `/guild-meetings/YYYY-MM-DD-notes.md`

---

*Meeting notes template v1.0 | Last updated: October 2024*