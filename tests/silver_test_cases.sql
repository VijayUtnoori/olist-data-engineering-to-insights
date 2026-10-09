/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/
--============================
--CUSTOMERS
--===============================
USE Olist_DataWarehouse;
SELECT * FROM bronze.olist_customers;

--duplicate records check
--result: NOt found
SELECT 
	customer_id,
	COUNT(*) as count_id
FROM bronze.olist_customers
GROUP BY customer_id 
HAVING COUNT(*)>1 OR customer_id IS NULL;

--duplicate records check
--result: Yes Found
SELECT 
	customer_unique_id,
	COUNT(*) as count_unique_id
FROM bronze.olist_customers
GROUP BY customer_unique_id 
HAVING COUNT(*)>1 OR customer_unique_id IS NULL;

SELECT
customer_state,
COUNT(customer_state) AS states_count
FROM bronze.olist_customers
GROUP BY customer_state;

SELECT
customer_city,
COUNT(customer_city) AS states_count
FROM bronze.olist_customers
GROUP BY customer_city;

SELECT 
customer_state
FROM bronze.olist_customers
WHERE customer_state!=TRIM(customer_state);

SELECT 
customer_city
FROM bronze.olist_customers
WHERE customer_state!=TRIM(customer_city);

SELECT 
customer_id
FROM bronze.olist_customers
WHERE customer_id!=TRIM(customer_id);

SELECT 
customer_unique_id
FROM bronze.olist_customers
WHERE customer_unique_id!=TRIM(customer_unique_id);

SELECT 
replace(customer_zip_code_prefix,'"','') AS code
FROM bronze.olist_customers
WHERE replace(customer_zip_code_prefix,'"','')<4 AND replace(customer_zip_code_prefix,'"','')>5

  


--==================================================
--GEOLOCATION
--=================================
SELECT TOP 100 * FROM Olist_DataWarehouse.bronze.olist_geolocation;

--COUNT total states and check data multilanguage if exist
SELECT geolocation_city,COUNT(geolocation_city) 
FROM Olist_DataWarehouse.silver.olist_geolocation 
GROUP BY geolocation_city

SELECT geolocation_state,COUNT(geolocation_state) 
FROM Olist_DataWarehouse.silver.olist_geolocation 
GROUP BY geolocation_state

--check duplicates codes 
SELECT geolocation_zip_code_prefix,COUNT(*) 
FROM Olist_DataWarehouse.silver.olist_geolocation 
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) >1

-- Expected Result: 0 rows returned
SELECT 
    geolocation_zip_code_prefix,
    geolocation_city
FROM silver.olist_geolocation
WHERE geolocation_city LIKE '%[ãáâàäçéêèëíîìïõóôòöúûùü]%';

--checkd and leading or traling spaces
SELECT geolocation_state
FROM Olist_DataWarehouse.silver.olist_geolocation 
WHERE geolocation_city!=TRIM(geolocation_city)

--checking lug and long  with posible range
SELECT 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng
FROM silver.olist_geolocation
WHERE geolocation_lat > 5.5 OR geolocation_lat < -34.5
   OR geolocation_lng > -34.0 OR geolocation_lng < -74.0;

---========================================
--Order_item
--============================
--date validation (shipping_limit_date and greater then order_purchase_date)
SELECT 
    oi.order_id,
    oi.order_item_id,
    o.order_purchase_timestamp,
    oi.shipping_limit_date
FROM Olist_DataWarehouse.bronze.olist_order_items oi
INNER JOIN Olist_DataWarehouse.bronze.olist_orders o
ON REPLACE(oi.order_id, '"', '') = REPLACE(o.order_id, '"', '')
WHERE CAST(oi.shipping_limit_date AS DATETIME2) <CAST(o.order_purchase_timestamp AS DATETIME2);

--check result
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_order_items

-- check leading and traling spaces for all columns
SELECT 
seller_id
FROM Olist_DataWarehouse.bronze.olist_order_items
WHERE seller_id!=TRIM(seller_id); 

--NOT featch dates is null
SELECT * FROM Olist_DataWarehouse.silver.olist_order_items
WHERE shipping_limit_date IS NULL


  

--========================
--ORDER_PAYMENTS

--check leading and traling spaces for all columns
SELECT 
	payment_type
FROM Olist_DataWarehouse.bronze.olist_order_payments
WHERE payment_type!=TRIM(payment_type);

--Counted and verify all payment_types
SELECT
	payment_type,
	COUNT(order_id)
FROM Olist_DataWarehouse.bronze.olist_order_payments
GROUP BY payment_type

  

--=================
--order_reviews
--================
--check duplicates
SELECT
review_id,
COUNT(*)
FROM Olist_DataWarehouse.silver.olist_order_reviews
GROUP BY review_id
HAVING COUNT(*)>1
--check the review_score 
SELECT
review_score,
COUNT(*)
FROM Olist_DataWarehouse.silver.olist_order_reviews
GROUP BY review_score
--check data validation
SELECT
CAST(review_creation_date AS DATETIME2(0)) AS review_creation_date,
CAST(review_answer_timestamp AS DATETIME2(0)) AS review_answer_timestamp 
FROM Olist_DataWarehouse.bronze.olist_order_reviews
WHERE CAST(review_creation_date AS DATETIME2(0))>CAST(review_answer_timestamp AS DATETIME2(0))


  

--==========================
--orders

--before 
  select count(order_id) FROM Olist_DataWarehouse.bronze.olist_orders
  --after 
  select count(order_id) FROM Olist_DataWarehouse.silver.olist_orders

  --COUNT null in order_approved_at do it for all columns 
SELECT 
	order_approved_at,
	COUNT(*) 
FROM Olist_DataWarehouse.bronze.olist_orders
GROUP BY order_approved_at
HAVING order_approved_at IS NULL

--check top 50 records
 SELECT TOP 50 * FROM Olist_DataWarehouse.silver.olist_orders

  


 --================
 --products

   --check the duplicates
   SELECT product_id,COUNT(*) FROM Olist_DataWarehouse.bronze.olist_products
   GROUP BY product_id
   HAVING COUNT(*)>1
 ---check nulls and varify it for all columns
   SELECT product_description_length,COUNT(*) FROM Olist_DataWarehouse.silver.olist_products
   WHERE product_description_length IS NULL
   GROUP BY product_description_length

   SELECT product_photos_qty,COUNT(*) FROM Olist_DataWarehouse.silver.olist_products
   WHERE product_photos_qty IS NULL
   GROUP BY product_photos_qty

   SELECT product_weight_g,COUNT(*) FROM Olist_DataWarehouse.silver.olist_products
   WHERE product_weight_g IS NULL
   GROUP BY product_weight_g

   SELECT product_height_cm,COUNT(*) FROM Olist_DataWarehouse.silver.olist_products
   WHERE product_height_cm IS NULL
   GROUP BY product_height_cm

   --CHEKING NEGATIVE VALUES
   SELECT 
    product_id,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM silver.olist_products
WHERE product_weight_g < 0 
   OR product_length_cm < 0 
   OR product_height_cm < 0 
   OR product_width_cm < 0;



   ---==============
   --Seller--
   ---============
  SELECT seller_city FROM Olist_DataWarehouse.silver.olist_sellers
  GROUP BY seller_city

  SELECT DISTINCT(seller_state) FROM Olist_DataWarehouse.silver.olist_sellers

  -- Check if any seller_id is duplicated
SELECT seller_id, COUNT(*) 
FROM Olist_DataWarehouse.silver.olist_sellers 
GROUP BY seller_id 
HAVING COUNT(*) > 1;



-- Expected Result: 0 rows returned
SELECT 
    seller_id, 
    seller_city
FROM silver.olist_sellers
WHERE seller_city LIKE '%[ãáâàäçéêèëíîìïõóôòöúûùü"]%';

