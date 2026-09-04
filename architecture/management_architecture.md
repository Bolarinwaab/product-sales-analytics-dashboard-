# Management Analytics Architecture

## Decision flow

**Operational systems → governed data → trusted measures → management decisions.**

### Executive questions

- Are sales growing?
- Which countries and regions drive revenue?
- Is growth profitable?
- Which products/categories create or destroy margin?
- Are discounts increasing volume without damaging profitability?
- Are shipping choices creating operational cost or service risk?

## KPI governance

| KPI | Definition | Grain | Owner |
|---|---|---|---|
| Revenue | Sum of sales transaction value | Order line | Sales/Finance |
| Profit | Sum of transaction profit | Order line | Finance |
| Profit Margin | Profit / Revenue | Filter context | Finance |
| Units Sold | Sum of quantity | Order line | Sales |
| Orders | Distinct order IDs | Order | Sales |
| Customers | Distinct customers | Customer | Sales |
| Revenue YoY | Current revenue vs prior-year revenue | Date | Finance |
| Discount Band | Standardized discount classification | Order line | Sales/Finance |

## Management thresholds

- **Green:** positive YoY growth and acceptable margin.
- **Amber:** growth or margin deterioration requiring review.
- **Red:** negative YoY plus weak/negative margin, or high discount exposure.

Thresholds should be replaced with approved Emmtec targets when management provides them.

## Recommended governance cadence

**Daily:** pipeline/data-quality monitoring.

**Weekly:** sales pipeline, revenue, orders, discount exceptions and operational issues.

**Monthly:** country/category/segment performance, margin bridge and YoY review.

**Quarterly:** strategic portfolio, customer concentration, pricing and market decisions.

## Architecture principle

No dashboard KPI should be independently recreated by analysts. Every executive metric should originate from a governed semantic-model measure or certified SQL definition.
