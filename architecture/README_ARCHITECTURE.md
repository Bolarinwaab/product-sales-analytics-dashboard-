# Architecture Deliverables

This folder contains the enterprise architecture for the EMMTEC Systems sales analytics portfolio.

## Deliverables

- `architecture_diagram.svg` — visual end-to-end architecture.
- `powerbi_star_schema.md` — semantic model and DAX specification.
- `azure_reference_architecture.md` — cloud target architecture.
- `management_architecture.md` — KPI governance and management decision framework.

## Reference pattern

The architecture follows a layered data platform and dimensional/star-schema analytics model. This is aligned with Microsoft's guidance that enterprise Power BI solutions benefit from a warehouse/dimensional layer and star schema for performance and usability. citeturn0search0turn0search1

## Current implementation vs target state

| Capability | Portfolio now | Production target |
|---|---|---|
| Source | Public benchmark | Approved Emmtec ERP/CRM |
| Raw layer | Documented | ADLS/OneLake |
| Transform | SQL-compatible | ADF/Fabric + SQL |
| Warehouse | SQL model | Azure SQL/Fabric Warehouse |
| Semantic model | Power BI specification | Certified Power BI model |
| Dashboard | HTML executive dashboard | Power BI Service |
| Security | Design documented | Entra ID + RLS |
| Monitoring | Design documented | Azure Monitor/Log Analytics |
| CI/CD | GitHub repository | GitHub Actions + deployment gates |

This allows the portfolio to demonstrate enterprise architecture without pretending that confidential Emmtec systems or credentials were accessed.
