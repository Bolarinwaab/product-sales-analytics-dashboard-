# Management Requirements Traceability

| Requirement | Implementation | Output |
|---|---|---|
| Revenue by Country | `sql/05_management_scorecard.sql` | Country revenue + margin |
| Revenue by Date/Year | `sql/04_yoy_analysis.sql` | Annual/monthly trend |
| Revenue, Profit & Units YoY | `sql/04_yoy_analysis.sql` + DAX | YoY measures |
| Revenue by Discount Band | `sql/06_discount_analysis.sql` | Revenue, profit, units, orders, margin, share |
| Country × Year scorecard | `sql/05_management_scorecard.sql` | Country annual matrix |
| Product performance | `sql/03_kpis.sql` + Power BI model | Product drill-down |
| Category performance | `sql/03_kpis.sql` | Category revenue/profit/margin |
| Segment performance | `sql/03_kpis.sql` | Segment revenue/profit/margin |
| Shipping performance | `sql/03_kpis.sql` | Revenue/profit/margin/delivery days |
| Executive dashboard | `dashboard/executive_dashboard.html` | Management presentation |
| Power BI implementation | `powerbi/` | DAX/model/theme |
| Enterprise architecture | `architecture/` | Target-state architecture |
| Data quality | `tests/sql_validation.sql` | Validation/reconciliation |
| CI quality gate | `.github/workflows/portfolio-quality.yml` | Automated artifact validation |

## Status

**Portfolio implementation complete.** Production use requires approved Emmtec source data, business-approved KPI thresholds and security configuration.
