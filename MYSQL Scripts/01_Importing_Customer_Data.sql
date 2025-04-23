USE reatil_data;

CREATE TABLE customers (
    customer_key INT,
    customer_id INT,
    cust_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(20),
    gender VARCHAR(10),
    birthdate DATE,
    create_date DATE
);


SELECT  COUNT(*)  FROM  customers;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\dim_customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
ESCAPED BY '\\'        -- Handles escaped characters
LINES TERMINATED BY '\n'  -- For Linux/Mac, use '\r\n' for Windows
(
    customer_key, 
    customer_id, 
    cust_number, 
    first_name, 
    last_name, 
    country, 
    marital_status, 
    gender, 
    @birthdate_var,  -- For handling possible empty dates
    @create_date_var
)
SET
    birthdate = IF(@birthdate_var = '', NULL, STR_TO_DATE(@birthdate_var, '%d-%m-%Y')),
    create_date = IF(@create_date_var = '', NULL, STR_TO_DATE(@create_date_var, '%d-%m-%Y'));