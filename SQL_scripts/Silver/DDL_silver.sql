
/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
----olist_customers

IF OBJECT_ID ('silver.olist_customers' , 'U') IS NOT NULL
	DROP TABLE silver.olist_customers;

CREATE TABLE silver.olist_customers(
    customer_id NVARCHAR(50),
    customer_unique_id NVARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city NVARCHAR(50),
    customer_state NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
----olist_geolocation
IF OBJECT_ID ('silver.olist_geolocation' , 'U') IS NOT NULL
	DROP TABLE silver.olist_geolocation;

CREATE TABLE silver.olist_geolocation(
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(18, 14),
    geolocation_lng DECIMAL(18, 14),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(100),
);
----olist_order_items
IF OBJECT_ID ('silver.olist_order_items', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_items;

CREATE TABLE silver.olist_order_items (
    order_id NVARCHAR(50),
    order_item_id INT,
    product_id NVARCHAR(50),
    seller_id NVARCHAR(50),
    shipping_limit_date DATETIME2,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
----olist_order_payment
IF OBJECT_ID ('silver.olist_order_payments', 'U') IS NOT NULL
    DROP TABLE silver.olist_order_payments;

CREATE TABLE silver.olist_order_payments (
    order_id NVARCHAR(50),
    payment_sequential INT,
    payment_type NVARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-----olist_order_reviews
IF OBJECT_ID('silver.olist_order_reviews' , 'U') IS NOT NULL
    DROP TABLE silver.olist_order_reviews;

CREATE TABLE silver.olist_order_reviews (
    review_id NVARCHAR(50),
    order_id NVARCHAR(50),
    review_score INT,
    review_creation_date DATE,
    review_answer_timestamp DATETIME2(0),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
---olist_product_category_translation
IF OBJECT_ID('silver.olist_product_category_translation', 'U') IS NOT NULL
    DROP TABLE silver.olist_product_category_translation;

CREATE TABLE silver.olist_product_category_translation (
    product_category_name NVARCHAR(100),
    product_category_name_english NVARCHAR(100),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
---olist_products

IF OBJECT_ID ('silver.olist_products' , 'U') IS NOT NULL
	DROP TABLE silver.olist_products;

CREATE TABLE silver.olist_products(
    product_id NVARCHAR(50),
    product_category_name VARCHAR(100),
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_weight_g DECIMAL(10,2),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

----olist_sellers
IF OBJECT_ID ('silver.olist_sellers' , 'U') IS NOT NULL
	DROP TABLE silver.olist_sellers;

CREATE TABLE silver.olist_sellers(
    seller_id NVARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

---olist_orders
IF OBJECT_ID ('silver.olist_orders' , 'U') IS NOT NULL
	DROP TABLE silver.olist_orders;

CREATE TABLE silver.olist_orders(
    order_id NVARCHAR(50),
    customer_id NVARCHAR(50),
    order_status NVARCHAR(50),
    order_purchase_timestamp DATETIME2(0),
    order_approved_at DATETIME2(0),
    order_delivered_carrier_date DATETIME2(0),
    order_delivered_customer_date DATETIME2(0),
    order_estimated_delivery_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-----check
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_customers;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_geolocation;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_order_items;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_order_payments;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_order_reviews;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_product_category_translation;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_products;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_sellers;
SELECT TOP 10 * FROM Olist_DataWarehouse.bronze.olist_orders;





