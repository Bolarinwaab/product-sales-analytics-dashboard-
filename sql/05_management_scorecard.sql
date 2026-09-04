/* Management scorecards */

-- Country × Year scorecard: designed for global source data.
WITH base AS (
    SELECT country, sales_year, SUM(sales) AS revenue, SUM(profit) AS profit
    FROM analytics.vw_emmtec_sales
    GROUP BY country, sales_year
)
SELECT country,
       SUM(CASE WHEN sales_year = 2014 THEN revenue ELSE 0 END) AS revenue_2014,
       SUM(CASE WHEN sales_year = 2015 THEN revenue ELSE 0 END) AS revenue_2015,
       SUM(CASE WHEN sales_year = 2016 THEN revenue ELSE 0 END) AS revenue_2016,
       SUM(CASE WHEN sales_year = 2017 THEN revenue ELSE 0 END) AS revenue_2017,
       SUM(revenue) AS total_revenue,
       SUM(profit) AS total_profit,
       CAST(SUM(profit)/NULLIF(SUM(revenue),0) AS DECIMAL(18,4)) AS margin
FROM base
GROUP BY country
ORDER BY total_revenue DESC;
GO

-- Region × Year scorecard for the Sample Superstore benchmark.
SELECT region, sales_year, SUM(sales) AS revenue, SUM(profit) AS profit,
       CAST(SUM(profit)/NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS margin
FROM analytics.vw_emmtec_sales
GROUP BY region, sales_year
ORDER BY region, sales_year;
GO

-- Discount band management control.
SELECT discount_band,
       COUNT(*) AS order_lines,
       SUM(sales) AS revenue,
       SUM(profit) AS profit,
       CAST(SUM(profit)/NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS margin,
       CASE
         WHEN discount_band = 'High' THEN 'Approval + margin review'
         WHEN discount_band = 'Medium' THEN 'Manager review'
         WHEN discount_band = 'Low' THEN 'Standard controls'
         ELSE 'Baseline'
       END AS management_action
FROM analytics.vw_emmtec_sales
GROUP BY discount_band
ORDER BY CASE discount_band WHEN 'None' THEN 1 WHEN 'Low' THEN 2 WHEN 'Medium' THEN 3 ELSE 4 END;
