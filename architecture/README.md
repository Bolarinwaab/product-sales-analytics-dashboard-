# EMMTEC Systems Enterprise Sales Analytics Architecture

## Architecture objective

Provide a scalable, governed analytics architecture that can ingest sales/ERP/CRM extracts, transform them through controlled data layers, publish a reusable semantic model, and deliver management dashboards.

## Logical architecture

```text
ERP / CRM / CSV / Excel
        |
        v
+-------------------+
| BRONZE / RAW      |  Immutable source landing
+-------------------+
        |
        v
+-------------------+
| SILVER / CLEAN    |  Standardise, validate, deduplicate
+-------------------+
        |
        v
+-------------------+
| GOLD / WAREHOUSE  |  Star schema + business rules
+-------------------+
        |
        v
+-------------------+
| SEMANTIC MODEL    |  Power BI / governed DAX measures
+-------------------+
        |
        v
+-------------------+
| MANAGEMENT BI     |  Executive dashboard + scorecards
+-------------------+
```

## Recommended cloud target

For a Microsoft-oriented enterprise deployment:

- Azure Data Factory / Fabric Data Factory for orchestration
- Azure Data Lake Storage Gen2 / OneLake for raw and curated storage
- Azure SQL / Fabric Warehouse for the dimensional warehouse
- Power BI semantic model for governed metrics and reporting
- Microsoft Entra ID for identity and access
- Key Vault for secrets
- Azure Monitor / Log Analytics for operational monitoring
- GitHub Actions for CI/CD

The current portfolio implementation uses SQL Server-compatible DDL and an HTML dashboard so it can run without cloud credentials. The architecture is deliberately cloud-ready.

## Star schema

```text
                    DimDate
                       |
DimCustomer --- FactSales --- DimProduct
                       |
                  DimGeography
                       |
                  DimShipping
                       |
                 DimDiscount
```

**FactSales grain:** one sales order line.

**Dimensions:** Date, Customer, Product, Geography, Shipping and Discount/Order attributes.

Microsoft recommends star-schema modeling for Power BI semantic models because dimensions support filtering/grouping while fact tables support aggregation. citeturn0search0turn0search1

## Security architecture

1. Entra ID authentication.
2. Least-privilege database roles.
3. Separate developer, test and production workspaces.
4. Row-level security where country/region ownership requires it.
5. Secrets stored outside source control.
6. No confidential Emmtec data committed to the public repository.
7. Audit logging for pipeline and warehouse operations.

## Data quality controls

- Null and mandatory-field checks
- Duplicate Row_ID / Order_ID-line detection
- Invalid date checks
- Negative/zero sales exception reporting
- Discount range validation
- Profit margin outlier checks
- Referential integrity checks
- Reconciliation of source totals to warehouse totals

## Reliability

Recommended production pipeline:

`Extract -> land -> validate -> transform -> load -> reconcile -> refresh semantic model -> publish`

Loads should be idempotent, partition-aware where volume requires it, and restartable after failure.

## Disaster recovery

- Keep raw source snapshots according to retention policy.
- Version SQL and semantic-model definitions in GitHub.
- Maintain infrastructure configuration as code when cloud deployment is introduced.
- Define RPO/RTO with management before production implementation.
- Test restoration periodically.

## Cost-control principles

- Incremental ingestion instead of full reloads where supported.
- Partition large fact tables by date.
- Remove unused columns before semantic-model publication.
- Aggregate historical data when detailed rows are no longer required for interactive reporting.
- Monitor refresh duration and query performance.

## Portfolio governance

This repository currently uses public benchmark data to demonstrate the architecture. It must not be represented as confidential Emmtec financial data. When approved company data becomes available, replace only the ingestion/source layer and retain the governed model, KPI definitions and dashboard design.