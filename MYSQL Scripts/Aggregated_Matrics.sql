-- Find the Total Sales
SELECT SUM(sales_amount) AS total_sales FROM fact_sale;

-- Find how many items are sold
SELECT ROUND(SUM(quantity)) AS total_quantity FROM fact_sale;

-- Find the average selling price
SELECT ROUND(AVG(price), 2) AS avg_price FROM fact_sale;

-- Find the Total number of Orders
SELECT ROUND(COUNT(order_number)) AS total_orders FROM fact_sale;

SELECT ROUND(COUNT(DISTINCT order_number)) AS total_orders FROM fact_sale;

-- Find the total number of products
SELECT ROUND(COUNT(product_name)) AS total_products FROM products;

-- Find the total number of customers
SELECT ROUND(COUNT(customer_key)) AS total_customers FROM customers;

-- Find the total number of customers that has placed an order
SELECT ROUND(COUNT(DISTINCT customer_key)) AS total_customers FROM fact_sale;

-- Generated a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM fact_sale
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM fact_sale
UNION ALL
SELECT 'Average Price', AVG(price) FROM fact_sale
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM fact_sale
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM customers;