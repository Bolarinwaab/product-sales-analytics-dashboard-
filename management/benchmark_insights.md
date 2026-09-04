# Management Benchmark Insights

> **Important:** these are observations from the public Sample Superstore benchmark used for the Emmtec portfolio implementation. They are not Emmtec financial results.

## Executive readout

### 1. Revenue momentum
The benchmark generated approximately **$2.297M revenue** and **$286.4K profit**, producing an overall margin of about **12.46%**. Revenue declined slightly in 2015, then accelerated in 2016 and 2017.

| Year | Revenue | YoY |
|---|---:|---:|
| 2014 | $484,247.50 | — |
| 2015 | $470,532.51 | -2.83% |
| 2016 | $609,205.60 | +29.46% |
| 2017 | $733,215.26 | +20.36% |

**Management implication:** investigate what changed between 2015 and 2016, then identify which products, customers and markets sustained the acceleration.

### 2. Regional concentration
Benchmark revenue by region is led by West ($725.5K) and East ($678.8K), followed by Central ($501.2K) and South ($391.7K).

**Management implication:** use region/country drill-downs to protect the strongest markets while creating targeted recovery plans for weaker markets.

### 3. Category economics
Technology contributes the highest category profit at approximately $145.5K, followed by Office Supplies at $122.5K. Furniture contributes only about $18.5K of profit despite meaningful revenue.

**Management implication:** category decisions should use margin and profit alongside revenue. High revenue does not automatically mean high economic value.

### 4. Discount governance
Discount should be modeled as a governed commercial lever. The SQL model defines:
- None: 0%
- Low: >0% and <15%
- Medium: 15% to <30%
- High: ≥30%

**Management implication:** High discounts should require approval and margin review. The actual threshold should be calibrated against approved Emmtec pricing policy once company data is available.

### 5. Operations
Standard Class is the dominant shipping mode in the benchmark. The dashboard therefore tracks revenue, profit, margin and delivery days together rather than treating shipping volume alone as success.

## Recommended management actions

1. **Protect growth:** identify the products, customers and markets responsible for the 2016–2017 acceleration.
2. **Protect margin:** monitor discount bands and loss-making order lines.
3. **Improve weak categories:** investigate Furniture sub-categories with low or negative profit.
4. **Prioritize markets:** combine Country × Year revenue with margin and YoY to distinguish growth from low-quality revenue.
5. **Operationalize KPIs:** publish a monthly scorecard with owners, thresholds and actions.
6. **Replace benchmark data:** load approved Emmtec ERP/CRM extracts before using the dashboard for real business decisions.
