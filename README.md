# EMMTEC SYSTEMS INTERNATIONAL — Enterprise Sales Performance Analytics

> **Portfolio simulation / benchmark implementation** built for Emmtec Systems International using a public Superstore benchmark dataset. It is **not a statement of Emmtec's confidential financial performance**.

## Management objective

Create an executive sales analytics solution that answers:

1. Revenue by country
2. Revenue by date/year
3. Revenue, profit and units sold YoY
4. Revenue by discount band
5. Country × Year management scorecard
6. Product, category, segment and shipping performance
7. Margin and operational risk signals

## Dashboard

Open `dashboard/executive_dashboard.html` in a browser.

## Benchmark KPI snapshot

| KPI | Benchmark result |
|---|---:|
| Revenue | $2,297,200.86 |
| Gross Profit | $286,397.02 |
| Profit Margin | 12.46% |
| Units Sold | 37,873 |
| Orders | 5,009 |
| Customers | 793 |
| Best Year | 2017 — $733,215.26 |
| Top Region | West — $725,457.82 |
| Top Category by Profit | Technology — $145,454.95 |

## Annual revenue and YoY

| Year | Revenue | YoY |
|---|---:|---:|
| 2014 | $484,247.50 | — |
| 2015 | $470,532.51 | -2.83% |
| 2016 | $609,205.60 | +29.46% |
| 2017 | $733,215.26 | +20.36% |

## Management findings from the benchmark model

- 2017 is the strongest revenue year, following a major acceleration in 2016.
- West is the largest revenue region; East is the next strongest contributor.
- Technology produces the highest category profit, while Furniture has a much smaller profit contribution.
- Standard Class is the dominant shipping mode by revenue.
- Discount governance should be treated as a margin-control lever: higher discount bands should require approval and profitability checks.

## Data provenance

The benchmark is derived from the publicly available Sample/Global Superstore family of datasets. Public references describe the data as fictional/educational rather than Emmtec production data. The source contains transactional fields such as order date, customer, geography, product, sales, quantity, discount and profit.

Sources:
- Tableau-derived Global Superstore repository: https://github.com/andrewmanueld/dataset_global_superstore_2016
- Kaggle Global Superstore dataset: https://www.kaggle.com/datasets/ronysoliman/global-superstore-dataset/data
- Sample Superstore reference and field structure: https://github.com/leonism/sample-superstore

## Architecture

`Raw benchmark → SQL staging → enriched sales view → KPI/YoY/scorecard queries → executive dashboard`

## Technology

SQL Server • SQL • Power BI-ready semantic model • HTML/CSS/SVG • GitHub

## Governance

Any future confidential Emmtec extract can replace the benchmark layer without changing the KPI definitions or dashboard design. Confidential source data should remain private and should not be committed to a public repository.
