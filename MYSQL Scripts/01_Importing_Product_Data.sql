CREATE TABLE products (     										
    product_key int,
    product_id int, 
    product_number varchar(50),   
    product_name varchar(50),
	category_id varchar(20),
    category varchar(50),
	subcategory varchar(50),
    maintenance varchar(20),
    cost int, 
    product_line varchar(50),
    start_date date
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dim_products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' 
ESCAPED BY '\\'        -- Handles escaped characters
LINES TERMINATED BY '\n'  
(
    product_key,
	product_id,
	product_number,
	product_name,
	category_id,
	category,
	subcategory,
	maintenance,
	cost,
	product_line,
	@start_date_var
)
SET 
    start_date = NULLIF(@startdate_var,'');