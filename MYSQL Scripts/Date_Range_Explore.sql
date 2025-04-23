-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM products
ORDER BY category, subcategory, product_name;

-- Determine the first and last order date and the total duration in months
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    Round(DATEDIFF( MAX(order_date), MIN(order_date) ) / 30) AS order_range_months
FROM fact_sale;

-- Find the youngest and oldest customer based on birthdate
-- Find the youngest and oldest customer based on birthdate
-- Using simple MySQL functions appropriate for 1 year experience level
SELECT
    MIN(birthdate) AS oldest_birthdate,
    TIMESTAMPDIFF(YEAR, MIN(birthdate), CURDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    TIMESTAMPDIFF(YEAR, MAX(birthdate), CURDATE()) AS youngest_age
FROM customers;

