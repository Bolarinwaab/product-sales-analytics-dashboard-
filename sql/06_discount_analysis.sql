/* Revenue by discount band — management requirement */
SELECT
    discount_band,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT order_id) AS orders,
    CAST(SUM(profit)/NULLIF(SUM(sales),0) AS DECIMAL(18,4)) AS margin,
    CAST(SUM(sales)/NULLIF(SUM(SUM(sales)) OVER (),0) AS DECIMAL(18,4)) AS revenue_share
FROM analytics.vw_emmtec_sales
GROUP BY discount_band
ORDER BY CASE discount_band
    WHEN 'None' THEN 1 WHEN 'Low' THEN 2 WHEN 'Medium' THEN 3 WHEN 'High' THEN 4 ELSE 5 END;
GO

/* Transaction-level exceptions for commercial review */
SELECT TOP (100)
    order_id, order_date, country, customer_name, product_name,
    sales, discount, discount_band, profit, profit_margin
FROM analytics.vw_emmtec_sales
WHERE discount_band = 'High' OR profit < 0
ORDER BY CASE WHEN profit < 0 THEN 0 ELSE 1 END, discount DESC, sales DESC;
