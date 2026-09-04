/* Executive KPI layer */
SELECT
    SUM(sales) AS total_revenue,
    SUM(profit) AS gross_profit,
    CAST(SUM(profit) / NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS profit_margin,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    CAST(SUM(sales) / NULLIF(COUNT(DISTINCT order_id),0) AS DECIMAL(18,2)) AS average_order_value,
    CAST(SUM(sales) / NULLIF(COUNT(DISTINCT customer_id),0) AS DECIMAL(18,2)) AS revenue_per_customer
FROM analytics.vw_emmtec_sales;
GO

/* Category / segment / shipping views used by management */
SELECT category, SUM(sales) AS revenue, SUM(profit) AS profit,
       CAST(SUM(profit)/NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS margin
FROM analytics.vw_emmtec_sales
GROUP BY category ORDER BY revenue DESC;

SELECT segment, SUM(sales) AS revenue, SUM(profit) AS profit,
       CAST(SUM(profit)/NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS margin
FROM analytics.vw_emmtec_sales
GROUP BY segment ORDER BY revenue DESC;

SELECT ship_mode, SUM(sales) AS revenue, SUM(profit) AS profit,
       CAST(SUM(profit)/NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS margin,
       AVG(CAST(delivery_days AS DECIMAL(10,2))) AS avg_delivery_days
FROM analytics.vw_emmtec_sales
GROUP BY ship_mode ORDER BY revenue DESC;
