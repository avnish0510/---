-- =============================================================================
-- Customer Report

-- Highlights:
-- 1. Customer details (names, ages)
-- 2. Customer segmentation (VIP, Regular, New) and age groups
-- 3. Key metrics: orders, sales, quantity, products, lifespan
-- 4. KPIs: recency, average order value, monthly spend

-- =============================================================================
CREATE OR REPLACE VIEW report_customers AS

WITH base_query AS (
SELECT
    f.order_number,
    f.product_key,
    f.order_date,
    f.sales_amount,
    f.quantity,
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    TIMESTAMPDIFF(YEAR, c.birthdate, CURDATE()) AS age
FROM fact_sale f
LEFT JOIN customers c ON c.customer_key = f.customer_key
WHERE f.order_date IS NOT NULL
),

customer_aggregation AS (
SELECT 
    customer_key,
    customer_name,
    age,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT product_key) AS total_products,
    MAX(order_date) AS last_order_date,
    TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY 
    customer_key,
    customer_name,
    age
)

SELECT
    customer_key,
    customer_name,
    age,
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS age_group,
    CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    last_order_date,
    TIMESTAMPDIFF(MONTH, last_order_date, CURDATE()) AS recency,
    total_orders,
    ROUND(total_sales, 2) AS total_sales,
    total_quantity,
    total_products,
    lifespan,
    -- Average order value
    CASE WHEN total_orders = 0 THEN 0
         ELSE ROUND(total_sales / total_orders, 2)
    END AS avg_order_value,
    -- Average monthly spend
    CASE WHEN lifespan = 0 THEN ROUND(total_sales, 2)
         ELSE ROUND(total_sales / lifespan, 2)
    END AS avg_monthly_spend
FROM customer_aggregation;


SELECT * FROM report_customers;