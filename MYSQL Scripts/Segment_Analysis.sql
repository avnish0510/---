-- Segment products into cost ranges and count products in each segment
SELECT 
    CASE 
        WHEN cost < 100 THEN 'Below 100'
        WHEN cost <= 500 THEN '100-500' 
        WHEN cost <= 1000 THEN '500-1000' 
        ELSE 'Above 1000'
    END AS cost_range,
    COUNT(*) AS total_products
FROM products
GROUP BY cost_range
ORDER BY total_products DESC;

-- Grouping customers into spending segments

WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan_months
    FROM fact_sale f
    JOIN customers c ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT 
    CASE 
        WHEN lifespan_months >= 12 AND total_spending > 5000 THEN 'VIP'
        WHEN lifespan_months >= 12 THEN 'Regular'  
        ELSE 'New'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM customer_spending
GROUP BY customer_segment
ORDER BY total_customers DESC;
