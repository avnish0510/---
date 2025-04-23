-- To explore the structure of the database, including the list of tables and their schemas

SELECT 
    table_catalog, 
    table_schema, 
    table_name, 
    table_type
FROM information_schema.tables
WHERE table_schema = DATABASE();  -- Only show tables in current database

-- Get column details for the 'dim_customers' table
SELECT 
    column_name, 
    data_type, 
    is_nullable
FROM information_schema.columns
WHERE table_name = 'customers'
AND table_schema = DATABASE(); 