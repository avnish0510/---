-- Monthly sales report (basic version)

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sale
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- Monthly sales report 
SELECT
    DATE_FORMAT(order_date, '%Y-%m-01') AS Month_Start,
    SUM(sales_amount) AS Total_Sales,
    COUNT(DISTINCT customer_key) AS Total_Customers,
    SUM(quantity) AS Total_Quantity
FROM fact_sale
WHERE order_date IS NOT NULL
GROUP BY month_start
ORDER BY month_start;

-- Monthly sales report with year-months format 
SELECT
    DATE_FORMAT(order_date, '%Y-%b') AS year_months,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sale
WHERE order_date IS NOT NULL
GROUP BY year_months, order_date  
ORDER BY order_date;  