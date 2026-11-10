/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to
    populate the 'silver' schema tables from the 'bronze' schema.
Actions Performed:
    - Truncates Silver tables.
    - Inserts transformed and cleansed data from Bronze into Silver tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/
--CREATED STORED PROCEDURE
CREATE OR ALTER PROCEDURE silver.loaded_silver AS
BEGIN
    --START AND END TIME 
    DECLARE @start_time DATETIME,@end_time DATETIME --to measure the start and end time 
    BEGIN TRY
    PRINT'=============================================';
	PRINT 'LOADING SILVER LAYER';
	PRINT'==============================================';

	PRINT '-------------------------------------------';
	PRINT 'LOAD ALL TABLES';
	PRINT'--------------------------------------------';
	SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_customers'
	TRUNCATE TABLE silver.olist_customers;
	PRINT'>>INSERTING DATA INTO:silver.olist_customers'
            --customer_unique_id, but different customers can have multiple customer_unique_id,
            INSERT INTO silver.olist_customers (
            customer_id,
            customer_unique_id,
            customer_zip_code_prefix,
            customer_city,
            customer_state)
        SELECT
            customer_id,
            customer_unique_id,
            customer_zip_code_prefix,
            customer_city,
            customer_state
        FROM (
        SELECT * , ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) AS rn
        FROM (
            SELECT
                REPLACE(customer_id, '"', '') AS customer_id,
                REPLACE(customer_unique_id, '"', '') AS customer_unique_id,
                TRY_CAST(REPLACE(customer_zip_code_prefix, '"', '') AS INT) AS customer_zip_code_prefix,
                TRIM(customer_city) AS customer_city,
                CASE UPPER(TRIM(customer_state))--state mapping 
                    WHEN 'AC' THEN 'Acre'
                    WHEN 'AL' THEN 'Alagoas'
                    WHEN 'AP' THEN 'Amapa'
                    WHEN 'AM' THEN 'Amazonas'
                    WHEN 'BA' THEN 'Bahia'
                    WHEN 'CE' THEN 'Ceara'
                    WHEN 'DF' THEN 'Federal District'
                    WHEN 'ES' THEN 'Espirito Santo'
                    WHEN 'GO' THEN 'Goias'
                    WHEN 'MA' THEN 'Maranhao'
                    WHEN 'MT' THEN 'Mato Grosso'
                    WHEN 'MS' THEN 'Mato Grosso do Sul'
                    WHEN 'MG' THEN 'Minas Gerais'
                    WHEN 'PA' THEN 'Para'
                    WHEN 'PB' THEN 'Paraiba'
                    WHEN 'PR' THEN 'Parana'
                    WHEN 'PE' THEN 'Pernambuco'
                    WHEN 'PI' THEN 'Piaui'
                    WHEN 'RJ' THEN 'Rio de Janeiro'
                    WHEN 'RN' THEN 'Rio Grande do Norte'
                    WHEN 'RS' THEN 'Rio Grande do Sul'
                    WHEN 'RO' THEN 'Rondonia'
                    WHEN 'RR' THEN 'Roraima'
                    WHEN 'SC' THEN 'Santa Catarina'
                    WHEN 'SP' THEN 'Sao Paulo'
                    WHEN 'SE' THEN 'Sergipe'
                    WHEN 'TO' THEN 'Tocantins'
                    ELSE 'Unknown'
                END AS customer_state
            FROM bronze.olist_customers) cleaned
            --ensure that customer_id and customer_unique_id is not null and not empty string
            WHERE customer_id IS NOT NULL
            AND customer_id <> ''
            AND customer_unique_id IS NOT NULL
            AND customer_unique_id <> ''
            ) ranking
            WHERE rn=1;
     SET @end_time=GETDATE();
	 PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
	 PRINT'------'

--=============================================================
--GEOLOCATION 
--=====================================================

    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_geolocation'
	TRUNCATE TABLE silver.olist_geolocation;
	PRINT'>>INSERTING DATA INTO:silver.olist_geolocation';
    WITH normalized_geo AS (
            SELECT 
                TRY_CAST(REPLACE(geolocation_zip_code_prefix,'"','') AS INT) AS geolocation_zip_code_prefix,
                TRY_CAST(geolocation_lat AS DECIMAL(10, 8)) AS geolocation_lat,
                TRY_CAST(geolocation_lng AS DECIMAL(10, 8)) AS geolocation_lng,           
                -- Physical accent stripping & lowercasing
                LOWER(TRANSLATE(CAST(geolocation_city AS VARCHAR(100)),
                        'áàâãäéèêëíìîïóòôõöúùûüç','aaaaaeeeeiiiiooooouuuuc')) AS geolocation_city,
                -- State mapping
                CASE UPPER(geolocation_state)
                    WHEN 'AC' THEN 'Acre'
                    WHEN 'AL' THEN 'Alagoas'
                    WHEN 'AP' THEN 'Amapa'
                    WHEN 'AM' THEN 'Amazonas'
                    WHEN 'BA' THEN 'Bahia'
                    WHEN 'CE' THEN 'Ceara'
                    WHEN 'DF' THEN 'Federal District'
                    WHEN 'ES' THEN 'Espirito Santo'
                    WHEN 'GO' THEN 'Goias'
                    WHEN 'MA' THEN 'Maranhao'
                    WHEN 'MT' THEN 'Mato Grosso'
                    WHEN 'MS' THEN 'Mato Grosso do Sul'
                    WHEN 'MG' THEN 'Minas Gerais'
                    WHEN 'PA' THEN 'Para'
                    WHEN 'PB' THEN 'Paraiba'
                    WHEN 'PR' THEN 'Parana'
                    WHEN 'PE' THEN 'Pernambuco'
                    WHEN 'PI' THEN 'Piaui'
                    WHEN 'RJ' THEN 'Rio de Janeiro'
                    WHEN 'RN' THEN 'Rio Grande do Norte'
                    WHEN 'RS' THEN 'Rio Grande do Sul'
                    WHEN 'RO' THEN 'Rondonia'
                    WHEN 'RR' THEN 'Roraima'
                    WHEN 'SC' THEN 'Santa Catarina'
                    WHEN 'SP' THEN 'Sao Paulo'
                    WHEN 'SE' THEN 'Sergipe'
                    WHEN 'TO' THEN 'Tocantins'
                    ELSE 'Unknown'
                END AS geolocation_state
            FROM bronze.olist_geolocation
            -- PRE-FILTER: Discard NULLs and out-of-bounds coordinates BEFORE ranking
            WHERE TRY_CAST(geolocation_lat AS DECIMAL(10, 8)) IS NOT NULL 
              AND TRY_CAST(geolocation_lng AS DECIMAL(10, 8)) IS NOT NULL
              AND TRY_CAST(geolocation_lat AS DECIMAL(10, 8)) BETWEEN -33.75 AND 5.25
              AND TRY_CAST(geolocation_lng AS DECIMAL(10, 8)) BETWEEN -73.98 AND -34.79 )
        INSERT INTO silver.olist_geolocation (
            geolocation_zip_code_prefix,
            geolocation_lat,
            geolocation_lng,
            geolocation_city,
            geolocation_state )
        SELECT 
          geolocation_zip_code_prefix,
          AVG(geolocation_lat)AS geolocation_lat,
          AVG(geolocation_lng) AS geolocation_lng,
          MIN(geolocation_city)AS geolocation_city,
          MIN(geolocation_state)AS geolocation_state
        FROM normalized_geo
        WHERE geolocation_zip_code_prefix IS NOT NULL
        GROUP BY geolocation_zip_code_prefix
      SET @end_time=GETDATE();
	  PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
	  PRINT'------'
    --======================================
    --seller
    --====================
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_sellers'
	TRUNCATE TABLE silver.olist_sellers;
	PRINT'>>INSERTING DATA INTO:silver.olist_sellers'; 
           WITH clean_sellers AS (
            SELECT 
                REPLACE(s.seller_id, '"', '') AS seller_id,
                REPLACE(s.seller_zip_code_prefix, '"', '') AS seller_zip_code_prefix,          
                -- Pull standardized city name; clean fallback city string if lookup is NULL
                COALESCE(
                    g.geolocation_city,  --mapped with geolocation_city cleaned
                    LOWER(
                        TRANSLATE(CAST(TRIM(REPLACE(s.seller_city, '"', '')) AS VARCHAR(100)),
                            'áàâãäéèêëíìîïóòôõöúùûüç','aaaaaeeeeiiiiooooouuuuc'))) AS seller_city,
                            --before                    --after
                -- Map state codes to full state names there are total 23 states
                CASE UPPER(TRIM(REPLACE(COALESCE(g.geolocation_state, s.seller_state), '"', '')))
                    WHEN 'AC' THEN 'Acre'
                    WHEN 'AL' THEN 'Alagoas'
                    WHEN 'AP' THEN 'Amapa'
                    WHEN 'AM' THEN 'Amazonas'
                    WHEN 'BA' THEN 'Bahia'
                    WHEN 'CE' THEN 'Ceara'
                    WHEN 'DF' THEN 'Federal District'
                    WHEN 'ES' THEN 'Espirito Santo'
                    WHEN 'GO' THEN 'Goias'
                    WHEN 'MA' THEN 'Maranhao'
                    WHEN 'MG' THEN 'Minas Gerais'
                    WHEN 'MS' THEN 'Mato Grosso do Sul'
                    WHEN 'MT' THEN 'Mato Grosso'
                    WHEN 'PA' THEN 'Para'
                    WHEN 'PB' THEN 'Paraiba'
                    WHEN 'PE' THEN 'Pernambuco'
                    WHEN 'PI' THEN 'Piaui'
                    WHEN 'PR' THEN 'Parana'
                    WHEN 'RJ' THEN 'Rio de Janeiro'
                    WHEN 'RN' THEN 'Rio Grande do Norte'
                    WHEN 'RO' THEN 'Rondonia'
                    WHEN 'RS' THEN 'Rio Grande do Sul'
                    WHEN 'SC' THEN 'Santa Catarina'
                    WHEN 'SE' THEN 'Sergipe'
                    WHEN 'SP' THEN 'Sao Paulo'
                    WHEN 'TO' THEN 'Tocantins'
                    ELSE COALESCE(g.geolocation_state, s.seller_state)--mapping
                END AS seller_state
            FROM Olist_DataWarehouse.bronze.olist_sellers s
            LEFT JOIN Olist_DataWarehouse.silver.olist_geolocation g
                ON REPLACE(s.seller_zip_code_prefix, '"', '') = g.geolocation_zip_code_prefix)--joined to match the city names with geolocation dataset
        INSERT INTO Olist_DataWarehouse.silver.olist_sellers (
            seller_id,
            seller_zip_code_prefix,
            seller_city,
            seller_state)
        SELECT 
            seller_id,
            seller_zip_code_prefix,
            seller_city,
            seller_state
        FROM clean_sellers;
        --load end time
    SET @end_time=GETDATE();
	PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
	PRINT'------'
   ---================================
    --order_review
    --=============================
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_order_reviews'
	TRUNCATE TABLE silver.olist_order_reviews;
	PRINT'>>INSERTING DATA INTO:silver.olist_order_reviews';
    WITH rank_reviews AS (
    SELECT 
	    REPLACE(review_id,'"','') AS review_id, 
	    REPLACE(order_id, '"','') AS order_id,
	    CAST(review_score AS INT) AS review_score,
        CASE 
            WHEN NULLIF(TRIM(REPLACE(review_comment_title,'"','')),'')IS NOT NULL THEN TRIM(REPLACE(review_comment_title,'"',''))
            ELSE 'Not submitd'
        END AS review_comment_title,
        CASE
            WHEN NULLIF(TRIM(REPLACE(review_comment_message,'"','')),'') IS NOT NULL THEN TRIM(REPLACE(review_comment_message,'"',''))
            ELSE 'Not commented'
        END AS review_comment_message,
	    CAST(review_creation_date AS DATE) AS review_creation_date,
	    CAST(review_answer_timestamp AS DATETIME2(0)) AS review_answer_timestamp,
        --feach only unique reviews 
	    ROW_NUMBER() OVER(PARTITION BY REPLACE(review_id,'"','') ORDER BY CAST(review_creation_date AS DATE)DESC) AS rn
    FROM Olist_DataWarehouse.bronze.olist_order_reviews
    WHERE NULLIF(TRIM(REPLACE(review_id,'"','')),'') IS NOT NULL 
          AND TRY_CAST(review_score AS INT) BETWEEN 1 AND 5 
          AND TRY_CAST(review_creation_date AS DATE) IS NOT NULL
          AND TRY_CAST(review_answer_timestamp AS DATETIME2(0)) IS NOT NULL
          AND TRY_CAST(review_creation_date AS DATE) <= TRY_CAST(review_answer_timestamp AS DATETIME2(0))  )
    INSERT INTO Olist_DataWarehouse.silver.olist_order_reviews(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp)
    SELECT 
	    review_id,
	    order_id,
	    review_score,
        review_comment_title,
        review_comment_message,
	    review_creation_date,
	    review_answer_timestamp
    FROM rank_reviews
    WHERE rn=1;
     SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		PRINT'------'
--=============================
        --products
        ----==============================
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_products'
	TRUNCATE TABLE silver.olist_products;
	PRINT'>>INSERTING DATA INTO:silver.olist_products';
        WITH translated_products AS (
        SELECT 
            REPLACE(p.product_id, '"', '') AS product_id,  
            -- Replace Portuguese category name with English translation
            --droped product name lenght column
            COALESCE(
                LOWER(TRIM(REPLACE(t.product_category_name_english, '"', ''))),
                LOWER(TRIM(REPLACE(p.product_category_name, '"', ''))),
                'unknown') AS product_category_name,
            COALESCE(TRY_CAST(product_name_lenght AS INT),0) AS product_name_length,
            COALESCE(TRY_CAST(p.product_description_lenght AS INT),0) AS product_description_length,
            COALESCE(TRY_CAST(p.product_photos_qty AS INT),0) AS product_photos_qty,
            TRY_CAST(p.product_weight_g AS DECIMAL(10,2)) AS product_weight_g,--can have decimal so conver decimal and replace 0 with nulls
            COALESCE(TRY_CAST(p.product_length_cm AS DECIMAL(10,2)),0) AS product_length_cm,--can have decimal so conver decimal and replace with 0 
            COALESCE(TRY_CAST(p.product_height_cm AS DECIMAL(10,2)),0) AS product_height_cm,--can have decimal so conver decimal and replace with 0 
            COALESCE(TRY_CAST(p.product_width_cm AS DECIMAL(10,2)),0) AS product_width_cm--can have decimal so conver decimal and replace with 0 
        FROM Olist_DataWarehouse.bronze.olist_products p
        LEFT JOIN Olist_DataWarehouse.bronze.olist_product_category_translation t 
            ON REPLACE(p.product_category_name, '"', '') = REPLACE(t.product_category_name, '"', '')) --joined with olist_product_category_translation to feach english product names
    INSERT INTO Olist_DataWarehouse.silver.olist_products (
        product_id,
        product_category_name,
        product_name_length,
        product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm)
    SELECT 
        product_id,
        product_category_name,
        product_name_length,
        product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    FROM translated_products;
     SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		PRINT'------'
    --================================
    --order payments
    --==============
    --insert into silver layer
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_order_payments'
	TRUNCATE TABLE silver.olist_order_payments;
	PRINT'>>INSERTING DATA INTO:silver.olist_order_payments'
    INSERT INTO Olist_DataWarehouse.silver.olist_order_payments(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value)
    SELECT --dataset clean
	    REPLACE(order_id,'"','') AS order_id,
	    CAST(payment_sequential AS INT) AS payment_sequential,
	    CASE LOWER(REPLACE(payment_type,'"','')) --mapping boleto(in Portuguese) to bank_slip 
	         WHEN 'boleto' THEN 'bank_slip'
		     WHEN 'not_defined' THEN 'unknown'
		     ELSE LOWER(REPLACE(payment_type,'"',''))
	    END AS payment_type,
	    CAST(payment_installments AS INT) AS payment_installments,
	    TRY_CAST(payment_value AS DECIMAL(10,2)) AS payment_value
    FROM Olist_DataWarehouse.bronze.olist_order_payments
    WHERE REPLACE(order_id,'"','') IS NOT NULL;
     SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		PRINT'------'
    ----========================
    --order
    --===============
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_orders'
	TRUNCATE TABLE silver.olist_orders;
	PRINT'>>INSERTING DATA INTO:silver.olist_orders';
    --Cleaning
        WITH converted_orders AS (
            SELECT
                NULLIF(REPLACE(TRIM(order_id), '"', ''), '') AS order_id,
                NULLIF(REPLACE(TRIM(customer_id), '"', ''), '') AS customer_id,
                LOWER(TRIM(order_status)) AS order_status,
                TRY_CAST(order_purchase_timestamp AS DATETIME2(0))
                    AS order_purchase_timestamp,
                TRY_CAST(order_approved_at AS DATETIME2(0))
                    AS order_approved_at,
                TRY_CAST(order_delivered_carrier_date AS DATETIME2(0))
                    AS order_delivered_carrier_date,
                TRY_CAST(order_delivered_customer_date AS DATETIME2(0))
                    AS order_delivered_customer_date,
                TRY_CAST(order_estimated_delivery_date AS DATE)
                    AS order_estimated_delivery_date
            FROM Olist_DataWarehouse.bronze.olist_orders)
            --adding
        INSERT INTO Olist_DataWarehouse.silver.olist_orders (
            order_id,
            customer_id,
            order_status,
            order_purchase_timestamp,
            order_approved_at,
            order_delivered_carrier_date,
            order_delivered_customer_date,
            order_estimated_delivery_date)
        SELECT
            order_id,
            customer_id,
            order_status,
            order_purchase_timestamp,
            order_approved_at,
            order_delivered_carrier_date,
            order_delivered_customer_date,
            order_estimated_delivery_date
        FROM converted_orders
        --data quality check
        WHERE
            --Mandatory fields
            order_id IS NOT NULL
            AND order_purchase_timestamp IS NOT NULL
            AND order_delivered_customer_date IS NOT NULL
            --Purchase must not occur after approval
            AND NOT(
                order_approved_at IS NOT NULL
                AND order_purchase_timestamp > order_approved_at)
            -- Approval must not occur after carrier date
            AND NOT(
                order_approved_at IS NOT NULL
                AND order_delivered_carrier_date IS NOT NULL
                AND order_approved_at > order_delivered_carrier_date)
            -- Carrier date must not occur after delivery
            AND NOT(
                order_delivered_carrier_date IS NOT NULL
                AND order_delivered_carrier_date > order_delivered_customer_date);
         SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		PRINT'------'
---===================================================
--ORDER REJECTED(they not follow the rules (keeping in separete table))
--======================================
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_orders'
	TRUNCATE TABLE silver.olist_orders_rejected;
	PRINT'>>INSERTING DATA INTO:silver.olist_orders';
        WITH converted_orders AS (
            SELECT
                NULLIF(REPLACE(TRIM(order_id), '"', ''), '') AS order_id,
                NULLIF(REPLACE(TRIM(customer_id), '"', ''), '') AS customer_id,
                LOWER(TRIM(order_status)) AS order_status,
                TRY_CAST(order_purchase_timestamp AS DATETIME2(0))
                    AS order_purchase_timestamp,
                TRY_CAST(order_approved_at AS DATETIME2(0))
                    AS order_approved_at,
                TRY_CAST(order_delivered_carrier_date AS DATETIME2(0))
                    AS order_delivered_carrier_date,
                TRY_CAST(order_delivered_customer_date AS DATETIME2(0))
                    AS order_delivered_customer_date,
                TRY_CAST(order_estimated_delivery_date AS DATE)
                    AS order_estimated_delivery_date
            FROM Olist_DataWarehouse.bronze.olist_orders),
        rejected_orders AS (
            SELECT *,
                NULLIF(CONCAT_WS('; ',
                    CASE WHEN order_id IS NULL
                        THEN 'Missing order ID' END,
                    CASE WHEN order_purchase_timestamp IS NULL
                        THEN 'Missing purchase timestamp' END,
                    CASE WHEN order_delivered_customer_date IS NULL
                        THEN 'Missing delivery timestamp' END,
                    CASE WHEN order_approved_at IS NOT NULL
                          AND order_purchase_timestamp IS NOT NULL
                          AND order_purchase_timestamp > order_approved_at
                        THEN 'Purchase after approval' END,
                    CASE WHEN order_approved_at IS NOT NULL
                          AND order_delivered_carrier_date IS NOT NULL
                          AND order_approved_at > order_delivered_carrier_date
                        THEN 'Approval after carrier handoff' END,
                    CASE WHEN order_delivered_carrier_date IS NOT NULL
                          AND order_delivered_customer_date IS NOT NULL
                          AND order_delivered_carrier_date > order_delivered_customer_date
                        THEN 'Carrier handoff after delivery' END ), '') AS rejection_reason
            FROM converted_orders)
        INSERT INTO Olist_DataWarehouse.silver.olist_orders_rejected (
            order_id,
            customer_id,
            order_status,
            order_purchase_timestamp,
            order_approved_at,
            order_delivered_carrier_date,
            order_delivered_customer_date,
            order_estimated_delivery_date,
            rejection_reason)
        SELECT
            order_id,
            customer_id,
            order_status,
            order_purchase_timestamp,
            order_approved_at,
            order_delivered_carrier_date,
            order_delivered_customer_date,
            order_estimated_delivery_date,
            rejection_reason
        FROM rejected_orders
        WHERE rejection_reason IS NOT NULL;
        SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		PRINT'------'
--==============================
--order_items
--=================================
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_order_items'
	TRUNCATE TABLE silver.olist_order_items;
	PRINT'>>INSERTING DATA INTO:silver.olist_order_items';
        WITH converted_items AS (
            SELECT
                NULLIF(REPLACE(TRIM(oi.order_id), '"', ''), '') AS order_id,
                TRY_CAST(oi.order_item_id AS INT) AS order_item_id,
                NULLIF(REPLACE(TRIM(oi.product_id), '"', ''), '') AS product_id,
                NULLIF(REPLACE(TRIM(oi.seller_id), '"', ''), '') AS seller_id,
                TRY_CAST(oi.shipping_limit_date AS DATETIME2(0))
                    AS shipping_limit_date,
                TRY_CAST(oi.price AS DECIMAL(10,2)) AS price,
                TRY_CAST(oi.freight_value AS DECIMAL(10,2)) AS freight_value,
                TRY_CAST(o.order_purchase_timestamp AS DATETIME2(0))
                    AS order_purchase_timestamp
            FROM Olist_DataWarehouse.bronze.olist_order_items oi
            LEFT JOIN Olist_DataWarehouse.bronze.olist_orders o
                ON REPLACE(TRIM(oi.order_id), '"', '') =
                   REPLACE(TRIM(o.order_id), '"', ''))
        INSERT INTO Olist_DataWarehouse.silver.olist_order_items (
            order_id,
            order_item_id,
            product_id,
            seller_id,
            shipping_limit_date,
            price,
            freight_value)
        SELECT
            i.order_id,
            i.order_item_id,
            i.product_id,
            i.seller_id,
            i.shipping_limit_date,
            i.price,
            i.freight_value
        FROM converted_items i
        INNER JOIN Olist_DataWarehouse.silver.olist_orders o
            ON i.order_id = o.order_id
        INNER JOIN Olist_DataWarehouse.silver.olist_products p
            ON i.product_id = p.product_id
        INNER JOIN Olist_DataWarehouse.silver.olist_sellers s
            ON i.seller_id = s.seller_id
        WHERE
            -- 1. Mandatory identifiers
            i.order_id IS NOT NULL
            AND i.order_item_id IS NOT NULL
            AND i.product_id IS NOT NULL
            AND i.seller_id IS NOT NULL
            -- 2. Mandatory shipping information
            AND i.shipping_limit_date IS NOT NULL
            AND i.order_purchase_timestamp IS NOT NULL
            -- 3. Price and freight validation
            AND i.price > 0
            AND i.freight_value >= 0
            -- 4. Shipping date validation
            AND i.shipping_limit_date >= i.order_purchase_timestamp;
            SET @end_time=GETDATE();
		    PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		    PRINT'------'
    ---==============================================================
    --order rejected(they not follow the order table (keeping in separete table)
    ---========================================
    SET @start_time=GETDATE();
    PRINT'>>TRUNCATE TABLE:silver.olist_orders'
	TRUNCATE TABLE silver.olist_order_items_rejected;
	PRINT'>>INSERTING DATA INTO:silver.olist_orders>>';
        WITH converted_items AS (
            SELECT
                NULLIF(REPLACE(TRIM(oi.order_id), '"', ''), '') AS order_id,
                TRY_CAST(oi.order_item_id AS INT) AS order_item_id,
                NULLIF(REPLACE(TRIM(oi.product_id), '"', ''), '') AS product_id,
                NULLIF(REPLACE(TRIM(oi.seller_id), '"', ''), '') AS seller_id,
                TRY_CAST(oi.shipping_limit_date AS DATETIME2(0))
                    AS shipping_limit_date,
                TRY_CAST(oi.price AS DECIMAL(10,2)) AS price,
                TRY_CAST(oi.freight_value AS DECIMAL(10,2)) AS freight_value,
                TRY_CAST(o.order_purchase_timestamp AS DATETIME2(0))
                    AS order_purchase_timestamp
            FROM Olist_DataWarehouse.bronze.olist_order_items oi
            LEFT JOIN Olist_DataWarehouse.bronze.olist_orders o
                ON REPLACE(TRIM(oi.order_id), '"', '') =
                   REPLACE(TRIM(o.order_id), '"', '')),
        rejected_items AS (
            SELECT
                i.*,
                NULLIF(CONCAT_WS('; ',
                     CASE WHEN i.order_id IS NULL
                        THEN 'Missing order ID' END,
                    CASE WHEN i.order_item_id IS NULL
                        THEN 'Missing order item ID' END,
                    CASE WHEN i.product_id IS NULL
                        THEN 'Missing product ID' END,
                    CASE WHEN i.seller_id IS NULL
                        THEN 'Missing seller ID' END,
                    CASE WHEN o.order_id IS NULL
                        THEN 'Order belongs to rejected or missing Silver order' END,
                    CASE WHEN p.product_id IS NULL
                        THEN 'Unmatched product ID' END,
                    CASE WHEN s.seller_id IS NULL
                        THEN 'Unmatched seller ID' END,
                    CASE WHEN i.shipping_limit_date IS NULL
                        THEN 'Missing or invalid shipping date' END,
                    CASE WHEN i.order_purchase_timestamp IS NULL
                        THEN 'Missing or invalid purchase timestamp' END,
                    CASE WHEN i.price IS NULL OR i.price <= 0
                        THEN 'Invalid price' END,
                    CASE WHEN i.freight_value IS NULL OR i.freight_value < 0
                        THEN 'Invalid freight value' END,
                    CASE WHEN i.shipping_limit_date IS NOT NULL
                          AND i.order_purchase_timestamp IS NOT NULL
                          AND i.shipping_limit_date < i.order_purchase_timestamp
                        THEN 'Shipping limit before purchase' END
                ), '') AS rejection_reason
            FROM converted_items i
            LEFT JOIN Olist_DataWarehouse.silver.olist_orders o
                ON i.order_id = o.order_id
            LEFT JOIN Olist_DataWarehouse.silver.olist_products p
                ON i.product_id = p.product_id
            LEFT JOIN Olist_DataWarehouse.silver.olist_sellers s
                ON i.seller_id = s.seller_id)
        INSERT INTO Olist_DataWarehouse.silver.olist_order_items_rejected (
            order_id,
            order_item_id,
            product_id,
            seller_id,
            shipping_limit_date,
            price,
            freight_value,
            rejection_reason)
        SELECT
            order_id,
            order_item_id,
            product_id,
            seller_id,
            shipping_limit_date,
            price,
            freight_value,
            rejection_reason
        FROM rejected_items
        WHERE rejection_reason IS NOT NULL;
        SET @end_time=GETDATE();
		PRINT'>>LOAD DURATION: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+'second';
		PRINT'------'
            --try catch block if any error occur show the error details
    END TRY
        BEGIN CATCH
            PRINT'====================================================';
            PRINT'ERROR OCCURE DURING EXCECUTION'
            PRINT'ERROR MESSAGE'+ERROR_MESSAGE();
            PRINT'ERROR MESSAGE'+CAST(ERROR_NUMBER() AS NVARCHAR);
            PRINT'ERROR MESSAGE'+CAST(ERROR_STATE() AS NVARCHAR);
            PRINT'============================================';
        END CATCH
  END;
  EXEC silver.loaded_silver
 


