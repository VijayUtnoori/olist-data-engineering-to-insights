/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Table 2(Geolocation) and 5( Order Reviews) Loaded via Import Flat File Wizard 
Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
--Created Stored procedure 
CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
    SET NOCOUNT ON;--SQL Server to stop sending messages like "(100 rows affected)"
    --to measure the time to load start and end and full batch start and end time 
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;

    BEGIN TRY
        SET @batch_start_time = GETDATE();

        PRINT '==================================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '==================================================';

        -- 1. Customers
        PRINT '>> TRUNCATING & LOADING: bronze.olist_customers';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_customers;
        BULK INSERT bronze.olist_customers
        FROM 'C:\olist_data\Olist_Row_Datasets\olist_customers_dataset.csv'
            WITH (FIRSTROW = 2,
            FIELDTERMINATOR = ',', 
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001', 
            TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        -- 2. Geolocation (Loaded via Import Flat File Wizard)
        PRINT '>> SKIPPING BULK INSERT FOR: bronze.olist_geolocation (Loaded via Wizard)';
        PRINT '--------------------------------------------------';

        -- 3. Order Items
        PRINT '>> TRUNCATING & LOADING: bronze.olist_order_items';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_order_items;
        BULK INSERT bronze.olist_order_items
        FROM 'C:\olist_data\Olist_Row_Datasets\olist_order_items_dataset.csv'
            WITH (FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001', 
            TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        -- 4. Order Payments
        PRINT '>> TRUNCATING & LOADING: bronze.olist_order_payments';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_order_payments;
        BULK INSERT bronze.olist_order_payments
        FROM 'C:\olist_data\Olist_Row_Datasets\olist_order_payments_dataset.csv'
            WITH (FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        -- 5. Order Reviews (Loaded via Import Flat File Wizard)
        PRINT '>> SKIPPING BULK INSERT FOR: bronze.olist_order_reviews (Loaded via Wizard)';
        PRINT '--------------------------------------------------';

        -- 6. Orders
        PRINT '>> TRUNCATING & LOADING: bronze.olist_orders';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_orders;
        BULK INSERT bronze.olist_orders
        FROM 'C:\olist_data\Olist_Row_Datasets\olist_orders_dataset.csv'
            WITH (FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        -- 7. Product Category Translation
        PRINT '>> TRUNCATING & LOADING: bronze.olist_product_category_translation';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_product_category_translation;
        BULK INSERT bronze.olist_product_category_translation
        FROM 'C:\olist_data\Olist_Row_Datasets\product_category_name_translation.csv'
            WITH (FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        -- 8. Products
        PRINT '>> TRUNCATING & LOADING: bronze.olist_products';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_products;
        BULK INSERT bronze.olist_products
        FROM 'C:\olist_data\Olist_Row_Datasets\olist_products_dataset.csv'
            WITH (FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '0x0a',
            CODEPAGE = '65001',
            TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        -- 9. Sellers
        PRINT '>> TRUNCATING & LOADING: bronze.olist_sellers';
        SET @start_time = GETDATE();
        TRUNCATE TABLE bronze.olist_sellers;
        BULK INSERT bronze.olist_sellers
        FROM 'C:\olist_data\Olist_Row_Datasets\olist_sellers_dataset.csv'
            WITH (FIRSTROW = 2,--Skips the CSV header row
            FIELDTERMINATOR = ',',-- Separates columns using commas.
            ROWTERMINATOR = '0x0a',--Ends lines with line-feeds
            CODEPAGE = '65001',--Encodes file using UTF-8.
            TABLOCK);--Speeds up bulk loading performance
        SET @end_time = GETDATE();
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------------';

        SET @batch_end_time = GETDATE();
        PRINT '==================================================';
        PRINT 'BRONZE LAYER LOAD COMPLETED SUCCESSFULLY';
        PRINT 'TOTAL LOAD DURATION: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
        PRINT '==================================================';

    END TRY
    BEGIN CATCH  --if any wrong shows errors via bulk load
        PRINT '==================================================';
        PRINT 'ERROR OCCURRED DURING EXECUTION';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number:  ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State:   ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==================================================';
    END CATCH
END;
GO
-- execute stored procedure 
EXEC bronze.load_bronze;

--to see the total count rows
SELECT 'olist_customers' AS
table_name,
COUNT(*) AS row_count
FROM bronze.olist_customers
UNION ALL
SELECT 'olist_geolocation',
COUNT(*) FROM bronze.olist_geolocation
UNION ALL
SELECT 'olist_order_items',
COUNT(*) FROM bronze.olist_order_items
UNION ALL
SELECT 'olist_order_payments',
COUNT(*) FROM bronze.olist_order_payments
UNION ALL 
SELECT 'olist_order_reviews',
COUNT(*) FROM bronze.olist_order_reviews
UNION ALL
SELECT 'olist_orders',
COUNT(*) FROM bronze.olist_orders
UNION ALL
SELECT 'olist_product_category_translation',
COUNT(*) FROM bronze.olist_product_category_translation
UNION ALL
SELECT 'olist_products',
COUNT(*) FROM bronze.olist_products
UNION ALL
SELECT 'olist_sellers',
COUNT(*) FROM bronze.olist_sellers;
