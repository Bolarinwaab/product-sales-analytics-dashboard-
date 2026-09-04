# Enterprise Data Pipeline

## Production pattern

`ERP / CRM / CSV → Bronze → Silver → Gold Warehouse → Power BI Semantic Model → Management`

### Bronze
Immutable source landing. Preserve source columns, source timestamps and file metadata. No business logic.

### Silver
Standardize column names and types; validate dates, discounts, quantities and keys; derive Year/Quarter/Month and DiscountBand; quarantine invalid rows.

### Gold
Publish the dimensional model:
- FactSales
- DimDate
- DimCustomer
- DimProduct
- DimGeography
- DimShipping
- DimDiscount

### Semantic layer
Power BI consumes curated Gold tables and exposes governed DAX measures.

## Operational controls
| Control | Target design |
|---|---|
| Load mode | Incremental by OrderDate / source watermark |
| Duplicate control | Row ID / source business key |
| Reconciliation | Revenue, profit, units and row counts |
| Data quality | Null, range, referential and date checks |
| Security | Entra ID + workspace roles + RLS |
| Secrets | Key Vault / managed identity |
| Monitoring | Pipeline run log + alerting |
| Deployment | DEV → TEST/UAT → PROD via GitHub CI/CD |
| Recovery | Source reprocessing + warehouse backup policy |
| Retention | Defined by corporate/legal policy |

## Future Emmtec integration
When approved ERP/CRM extracts become available, replace only the Bronze ingestion mapping. KPI definitions, Gold model, semantic measures and management report contract remain stable.
