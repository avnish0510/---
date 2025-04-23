-- Calculate the total sales per month and the running total of sales over time Monthly
SELECT
    month_date,
    total_sales,
    SUM(total_sales) OVER (ORDER BY month_date) AS running_total_sales,
    ROUND(AVG(avg_price) OVER (ORDER BY month_date),2) AS moving_average_price
FROM (
    SELECT 
        DATE_FORMAT(MIN(order_date), '%Y-%m-01') AS month_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM fact_sale
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), MONTH(order_date)
) AS monthly_sales
ORDER BY month_date;