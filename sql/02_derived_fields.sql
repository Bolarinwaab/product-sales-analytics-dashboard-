/* Layer 2: reusable enriched sales view */
CREATE OR ALTER VIEW analytics.vw_emmtec_sales AS
SELECT
    f.*,
    YEAR(f.order_date) AS sales_year,
    DATEPART(QUARTER, f.order_date) AS sales_quarter,
    MONTH(f.order_date) AS sales_month,
    DATENAME(MONTH, f.order_date) AS sales_month_name,
    CASE
        WHEN COALESCE(f.discount,0) = 0 THEN 'None'
        WHEN f.discount < 0.15 THEN 'Low'
        WHEN f.discount < 0.30 THEN 'Medium'
        ELSE 'High'
    END AS discount_band,
    CASE WHEN f.sales = 0 THEN 0 ELSE f.profit / f.sales END AS profit_margin,
    CASE
        WHEN f.ship_date IS NULL THEN NULL
        ELSE DATEDIFF(DAY, f.order_date, f.ship_date)
    END AS delivery_days
FROM analytics.fact_sales AS f;
GO
