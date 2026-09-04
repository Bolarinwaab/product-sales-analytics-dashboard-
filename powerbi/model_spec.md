# Power BI Semantic Model Specification

## Model pattern
A governed star schema is used: FactSales sits at the center while dimensions provide filtering/grouping context. This follows Microsoft guidance for Power BI analytical models. citeturn0search0

## Grain
**FactSales:** one row per order line.

## Tables
| Table | Type | Key | Purpose |
|---|---|---|---|
| FactSales | Fact | SalesLineKey | Revenue, profit, quantity, discount |
| DimDate | Dimension | DateKey | Year, quarter, month, fiscal periods |
| DimCustomer | Dimension | CustomerKey | Customer and segment analysis |
| DimProduct | Dimension | ProductKey | Category, sub-category, product analysis |
| DimGeography | Dimension | GeographyKey | Country, city, state, region |
| DimShipping | Dimension | ShippingKey | Ship mode and delivery analysis |
| DimDiscount | Dimension | DiscountKey | Governed discount bands |

## Relationships
All dimensions use **1-to-many, single-direction** relationships into FactSales. This minimizes ambiguous filter paths and matches recommended star-schema behavior. citeturn0search2turn0search7

## Report pages
1. **Executive Overview** — KPI cards, revenue trend, profit trend, top markets, management alerts.
2. **Geography** — country/region revenue, profit, margin, Country × Year matrix.
3. **Commercial Performance** — category, sub-category, product and segment.
4. **Discount & Margin** — discount band revenue/profit/margin and loss-making transactions.
5. **Operations** — shipping mode, delivery days, order priority.
6. **Data Quality** — row counts, null checks, duplicate checks and reconciliation.

## RLS
Use a security mapping table:
`UserPrincipalName → GeographyKey/Country → DimGeography`.

Apply RLS to DimGeography so authorized managers only see their assigned markets. Microsoft recommends validating RLS roles before broad distribution. citeturn0search6

## Refresh
- DEV: manual / on demand
- TEST/UAT: scheduled validation refresh
- PROD: scheduled incremental refresh where volume warrants it
- Refresh failure: alert + run-log record + owner notification

## Governance
Measures are centralized in `powerbi/measures.dax`; report authors should use governed measures rather than recreating KPI formulas at visual level.
