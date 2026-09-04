/* EMMTEC SYSTEMS INTERNATIONAL — ENTERPRISE SALES ANALYTICS
   Layer 1: warehouse-ready schema
   Grain: one row per sales order line
   Benchmark-safe: source facts are intentionally not embedded here.
*/

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'analytics')
    EXEC('CREATE SCHEMA analytics');
GO

IF OBJECT_ID('analytics.fact_sales','U') IS NULL
BEGIN
    CREATE TABLE analytics.fact_sales (
        row_id INT NOT NULL,
        order_id VARCHAR(30) NOT NULL,
        order_date DATE NOT NULL,
        ship_date DATE NULL,
        ship_mode VARCHAR(30) NULL,
        customer_id VARCHAR(50) NULL,
        customer_name VARCHAR(150) NULL,
        segment VARCHAR(40) NULL,
        country VARCHAR(100) NULL,
        city VARCHAR(100) NULL,
        state VARCHAR(100) NULL,
        postal_code VARCHAR(20) NULL,
        region VARCHAR(60) NULL,
        product_id VARCHAR(50) NULL,
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
END;
GO

CREATE INDEX IX_fact_sales_order_date ON analytics.fact_sales(order_date);
CREATE INDEX IX_fact_sales_country ON analytics.fact_sales(country);
CREATE INDEX IX_fact_sales_product ON analytics.fact_sales(product_id);
CREATE INDEX IX_fact_sales_customer ON analytics.fact_sales(customer_id);
GO
