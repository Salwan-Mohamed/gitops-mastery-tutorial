# Pattern 3: Instance per Logical Group - The Middle Way

## Overview

Group your clusters logically (by team, project, or region), with one Argo CD instance per group.

## Architecture

```
E-commerce Project Argo CD
    ├── E-commerce Dev
    ├── E-commerce Staging
    └── E-commerce Production

Mobile App Argo CD
    ├── Mobile Dev
    ├── Mobile Staging
    └── Mobile Production

Internal Tools Argo CD
    ├── Tools Dev
    └── Tools Production
```

## When to Use

✅ Growing organizations (30-200 engineers)
✅ Multiple teams/products (need for autonomy with some oversight)
✅ Regional requirements (different compliance needs per region)
✅ Mix of cluster sizes and criticality

## Grouping Strategies

### By Department
- Development team clusters
- QA/Testing clusters
- Operations infrastructure

### By Project
- Customer-facing app clusters
- Internal tools clusters
- Analytics/ML clusters

### By Geography
- North America clusters
- Europe clusters (GDPR compliance)
- Asia-Pacific clusters

## Files in This Directory

- `by-team/` - Examples of team-based grouping
- `by-region/` - Examples of region-based grouping
- `by-project/` - Examples of project-based grouping
