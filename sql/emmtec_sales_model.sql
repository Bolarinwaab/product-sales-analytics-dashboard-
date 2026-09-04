/* EMMTEC SYSTEMS INTERNATIONAL - SALES ANALYTICS MODEL
   Portfolio benchmark implementation.
   Replace benchmark rows with approved Emmtec source data when available.
*/

CREATE SCHEMA analytics;
GO

CREATE TABLE analytics.fact_sales (
    row_id INT NOT NULL,
    order_id VARCHAR(30) NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NULL,
    ship_mode VARCHAR(30) NULL,
    customer_id VARCHAR(30) NULL,
    customer_name VARCHAR(150) NULL,
    segment VARCHAR(40) NULL,
    country VARCHAR(100) NULL,
    city VARCHAR(100) NULL,
    state VARCHAR(100) NULL,
    postal_code VARCHAR(20) NULL,
    region VARCHAR(60) NULL,
    product_id VARCHAR(40) NULL,
    category VARCHAR(60) NULL,
    sub_category VARCHAR(80) NULL,
    product_name VARCHAR(255) NULL,
    sales DECIMAL(18,2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(9,4) NULL,
    profit DECIMAL(18,2) NOT NULL,
    shipping_cost DECIMAL(18,2) NULL,
    order_priority VARCHAR(30) NULL,
    CONSTRAINT PK_fact_sales PRIMARY KEY (row_id)
);
GO

CREATE OR ALTER VIEW analytics.vw_emmtec_sales AS
SELECT
    f.*,
    YEAR(f.order_date) AS sales_year,
    DATEPART(QUARTER, f.order_date) AS sales_quarter,
    MONTH(f.order_date) AS sales_month,
    DATENAME(MONTH, f.order_date) AS sales_month_name,
    CASE
        WHEN f.discount = 0 THEN 'None'
        WHEN f.discount < 0.15 THEN 'Low'
        WHEN f.discount < 0.30 THEN 'Medium'
        ELSE 'High'
    END AS discount_band,
    CASE WHEN f.sales = 0 THEN 0 ELSE f.profit / f.sales END AS profit_margin,
    DATEDIFF(DAY, f.order_date, f.ship_date) AS delivery_days
FROM analytics.fact_sales f;
GO

-- Executive KPIs
SELECT
    SUM(sales) AS total_revenue,
    SUM(profit) AS gross_profit,
    CASE WHEN SUM(sales)=0 THEN 0 ELSE SUM(profit)/SUM(sales) END AS profit_margin,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM analytics.vw_emmtec_sales;

-- Revenue by year and YoY
WITH y AS (
    SELECT sales_year, SUM(sales) AS revenue
    FROM analytics.vw_emmtec_sales
    GROUP BY sales_year
)
SELECT sales_year, revenue,
       LAG(revenue) OVER (ORDER BY sales_year) AS prior_year_revenue,
       CASE WHEN LAG(revenue) OVER (ORDER BY sales_year) IS NULL THEN NULL
            ELSE (revenue / LAG(revenue) OVER (ORDER BY sales_year))-1 END AS revenue_yoy
FROM y
ORDER BY sales_year;

-- Revenue by country/region
SELECT country, region, SUM(sales) AS revenue, SUM(profit) AS profit,
       CASE WHEN SUM(sales)=0 THEN 0 ELSE SUM(profit)/SUM(sales) END AS margin
FROM analytics.vw_emmtec_sales
GROUP BY country, region
ORDER BY revenue DESC;

-- Discount governance
SELECT discount_band, SUM(sales) AS revenue, SUM(profit) AS profit,
       CASE WHEN SUM(sales)=0 THEN 0 ELSE SUM(profit)/SUM(sales) END AS margin
FROM analytics.vw_emmtec_sales
GROUP BY discount_band
ORDER BY CASE discount_band WHEN 'None' THEN 1 WHEN 'Low' THEN 2 WHEN 'Medium' THEN 3 ELSE 4 END;
