/* DATA QUALITY / RECONCILIATION TESTS
   Run after loading approved benchmark or Emmtec data.
   Expected benchmark totals are documented separately; these tests enforce structural integrity.
*/

-- 1. Primary key uniqueness
IF EXISTS (
    SELECT row_id FROM analytics.fact_sales
    GROUP BY row_id HAVING COUNT(*) > 1
) THROW 51001, 'Duplicate row_id detected', 1;

-- 2. Required sales grain fields
IF EXISTS (SELECT 1 FROM analytics.fact_sales WHERE order_id IS NULL OR order_date IS NULL)
    THROW 51002, 'Missing order grain fields', 1;

-- 3. Numeric sanity
IF EXISTS (SELECT 1 FROM analytics.fact_sales WHERE quantity < 0 OR sales < 0 AND profit > sales)
    THROW 51003, 'Invalid quantity/sales values', 1;

-- 4. Date sanity
IF EXISTS (SELECT 1 FROM analytics.fact_sales WHERE ship_date IS NOT NULL AND ship_date < order_date)
    THROW 51004, 'Ship date precedes order date', 1;

-- 5. Discount range
IF EXISTS (SELECT 1 FROM analytics.fact_sales WHERE discount IS NOT NULL AND (discount < 0 OR discount > 1))
    THROW 51005, 'Discount outside 0-100% range', 1;

-- 6. Reconciliation summary
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    SUM(quantity) AS units_sold,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM analytics.fact_sales;
