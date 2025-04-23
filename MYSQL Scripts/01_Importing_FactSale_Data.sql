CREATE TABLE fact_sale (
    order_number VARCHAR(50),
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity INT,
    price INT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\fact_sales.csv'
INTO TABLE fact_sale
FIELDS TERMINATED BY ',' 
ESCAPED BY '\\'        -- Handles escaped characters
LINES TERMINATED BY '\n' 
(
    order_number,
	product_key,
	customer_key,
	@order_date_var,
	@shipping_date_var,
	@due_date_var,
	sales_amount,
	quantity,
	price
)
SET 
    order_date = NULLIF(@order_date_var,''),
	shipping_date = NULLIF(@shipping_date_var,''),
    due_date = NULLIF(@due_date_var,'');