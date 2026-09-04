# Emmtec Systems — Management Insights & Action Plan

## Executive interpretation

This portfolio model demonstrates how an Emmtec management team could move from raw sales transactions to a repeatable performance-management process. The benchmark contains 9,994 US Superstore transaction lines and is used only as a stand-in because confidential Emmtec sales data was not available for this build.

## Results

### 1. Revenue trajectory

Revenue increased from $484.2K in 2014 to $733.2K in 2017. 2015 declined 2.83%, followed by +29.46% growth in 2016 and +20.36% in 2017.

**Action:** establish monthly revenue targets and investigate the drivers behind every material YoY variance.

### 2. Regional concentration

West generated $725.5K, East $678.8K, Central $501.2K and South $391.7K. West and East together account for the majority of benchmark revenue.

**Action:** protect the leading markets while creating a recovery plan for underperforming territories.

### 3. Profit mix

Technology produced $145.5K of profit, Office Supplies $122.5K and Furniture $18.5K.

**Action:** prioritize high-margin product families and review low-margin product lines for pricing, procurement and discount leakage.

### 4. Discount governance

Discounts should not be evaluated on revenue alone. Management should pair discount bands with profit and margin so that revenue growth is not purchased at the expense of profitability.

**Action:** create approval thresholds for high discounts and add a minimum-margin guardrail to the sales process.

### 5. Shipping

Standard Class generated the largest benchmark revenue at approximately $1.36M.

**Action:** monitor shipping cost and delivery days by mode; a high-revenue mode can still destroy margin if logistics cost is uncontrolled.

## KPI framework

| KPI | Management use |
|---|---|
| Revenue | Growth and target tracking |
| Gross Profit | Economic contribution |
| Profit Margin | Pricing/discount guardrail |
| Units | Volume and demand |
| Orders | Transaction frequency |
| Customers | Customer-base health |
| Revenue YoY | Growth momentum |
| Profit YoY | Quality of growth |
| Discount-band margin | Promotion governance |
| Delivery days | Operational service level |

## Data-quality controls

Before using this model for actual Emmtec reporting, validate:

- unique order-line keys
- valid dates and shipping dates
- non-negative quantities
- currency and tax treatment
- duplicate transactions
- missing customer/product identifiers
- discount range
- reconciliation of revenue and profit to the source system
- approved country/market master data

## Deployment path

1. Replace benchmark fact data with approved Emmtec export.
2. Map company product, customer, geography and order dimensions.
3. Reconcile totals to ERP/accounting reports.
4. Publish Power BI semantic model.
5. Add row-level security if required.
6. Schedule refresh and management alerts.
7. Keep confidential source files outside the public GitHub repository.
