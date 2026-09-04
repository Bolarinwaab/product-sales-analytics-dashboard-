# Azure Reference Architecture

```text
                    +----------------------+
                    | Emmtec Source Apps   |
                    | ERP / CRM / Files     |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Data Factory / Fabric |
                    | Orchestration         |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | ADLS Gen2 / OneLake   |
                    | Bronze / Raw          |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Silver Transformation |
                    | Clean / Conform       |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Azure SQL / Fabric    |
                    | Warehouse / Gold      |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Power BI Semantic     |
                    | Model + DAX + RLS     |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    | Management Dashboards |
                    +----------------------+
```

### Cross-cutting services

- Microsoft Entra ID: authentication and authorization
- Key Vault: secrets and credentials
- Azure Monitor / Log Analytics: telemetry and alerting
- GitHub Actions: CI/CD for SQL, documentation and deployment artifacts
- Defender/security controls as required by the final environment

### Environment strategy

`DEV → TEST/UAT → PROD`

Use separate workspaces, databases or logical environments. Production access should be controlled through Entra groups and least-privilege roles.

### Data movement

Prefer incremental loads using a reliable watermark such as `LastModifiedDate` or source transaction timestamp. Where no watermark exists, use partition/date-based extraction and reconciliation controls.

### Production readiness

Before production deployment, define:

- Data retention
- RPO/RTO
- Refresh SLA
- Data classification
- RLS ownership matrix
- Source-to-target reconciliation tolerance
- Incident escalation process
- Cost budget and monitoring thresholds
