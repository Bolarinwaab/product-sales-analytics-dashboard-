/* Revenue, profit and units sold by year with YoY change */
WITH annual AS (
    SELECT
        sales_year,
        SUM(sales) AS revenue,
        SUM(profit) AS profit,
        SUM(quantity) AS units_sold
    FROM analytics.vw_emmtec_sales
    GROUP BY sales_year
), calc AS (
    SELECT *,
        LAG(revenue) OVER (ORDER BY sales_year) AS revenue_py,
        LAG(profit) OVER (ORDER BY sales_year) AS profit_py,
        LAG(units_sold) OVER (ORDER BY sales_year) AS units_py
    FROM annual
)
SELECT sales_year, revenue, profit, units_sold,
       revenue_py,
       CAST((revenue-revenue_py)/NULLIF(revenue_py,0) AS DECIMAL(18,4)) AS revenue_yoy,
       profit_py,
       CAST((profit-profit_py)/NULLIF(profit_py,0) AS DECIMAL(18,4)) AS profit_yoy,
       units_py,
       CAST((units_sold-units_py)*1.0/NULLIF(units_py,0) AS DECIMAL(18,4)) AS units_yoy
FROM calc
ORDER BY sales_year;
GO

/* Monthly trend for drill-down */
SELECT sales_year, sales_month, sales_month_name,
       SUM(sales) AS revenue,
       SUM(profit) AS profit,
       SUM(quantity) AS units_sold
FROM analytics.vw_emmtec_sales
GROUP BY sales_year, sales_month, sales_month_name
ORDER BY sales_year, sales_month;
