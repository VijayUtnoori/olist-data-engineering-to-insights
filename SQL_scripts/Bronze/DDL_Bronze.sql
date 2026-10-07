
/*
----------------------------------------------------------------------------
DDL Script: Create Bronze Tables
-----------------------------------------------------------------------------
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
------------------------------------------------------------------------------
*/

--============================================
--Create Bronze Schema Tables(Used NVARCHAR to avoid any Fails)
--=============================================

--customers
IF OBJECT_ID('bronze.olist_customers' ,'U') IS NOT NULL
    DROP TABLE bronze.olist_customers;

CREATE TABLE bronze.olist_customers(
customer_id NVARCHAR(100),
    customer_unique_id NVARCHAR(100),
    customer_zip_code_prefix NVARCHAR(20),
    customer_city NVARCHAR(100),
    customer_state NVARCHAR(20)
);

--Geolocation
IF OBJECT_ID('bronze.olist_geolocation', 'U') IS NOT NULL
    DROP TABLE bronze.olist_geolocation;
CREATE TABLE bronze.olist_geolocation(
    geolocation_zip_code_prefix NVARCHAR(20),
    geolocation_lat NVARCHAR(100),
    geolocation_lng NVARCHAR(100),
    geolocation_city NVARCHAR(100),
    geolocation_state NVARCHAR(20)
);

--Products
IF OBJECT_ID('bronze.olist_products', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_products;
CREATE TABLE bronze.olist_products (
    product_id NVARCHAR(100),
    product_category_name NVARCHAR(150),
    product_name_lenght NVARCHAR(50),
    product_description_lenght NVARCHAR(50),
    product_photos_qty NVARCHAR(50),
    product_weight_g NVARCHAR(50),
    product_length_cm NVARCHAR(50),
    product_height_cm NVARCHAR(50),
    product_width_cm NVARCHAR(50)
);

--Sellers
IF OBJECT_ID('bronze.olist_sellers', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_sellers;
CREATE TABLE bronze.olist_sellers (
    seller_id NVARCHAR(100),
    seller_zip_code_prefix NVARCHAR(20),
    seller_city NVARCHAR(100),
    seller_state NVARCHAR(20)
);

--Product Category Translation
IF OBJECT_ID('bronze.olist_product_category_translation', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_product_category_translation;

CREATE TABLE bronze.olist_product_category_translation (
    product_category_name NVARCHAR(150),
    product_category_name_english NVARCHAR(150)
);

--Orders
IF OBJECT_ID('bronze.olist_orders', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_orders;

CREATE TABLE bronze.olist_orders (
    order_id NVARCHAR(100),
    customer_id NVARCHAR(100),
    order_status NVARCHAR(50),
    order_purchase_timestamp NVARCHAR(100),
    order_approved_at NVARCHAR(100),
    order_delivered_carrier_date NVARCHAR(100),
    order_delivered_customer_date NVARCHAR(100),
    order_estimated_delivery_date NVARCHAR(100)
);

--Order Items
IF OBJECT_ID('bronze.olist_order_items', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_order_items;

CREATE TABLE bronze.olist_order_items (
    order_id NVARCHAR(100),
    order_item_id NVARCHAR(50),
    product_id NVARCHAR(100),
    seller_id NVARCHAR(100),
    shipping_limit_date NVARCHAR(100),
    price NVARCHAR(50),
    freight_value NVARCHAR(50)
);

--Order Payments
IF OBJECT_ID('bronze.olist_order_payments', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_order_payments;

CREATE TABLE bronze.olist_order_payments (
    order_id NVARCHAR(100),
    payment_sequential NVARCHAR(50),
    payment_type NVARCHAR(50),
    payment_installments NVARCHAR(50),
    payment_value NVARCHAR(50)
);

--Order Reviews
IF OBJECT_ID('bronze.olist_order_reviews', 'U') IS NOT NULL 
    DROP TABLE bronze.olist_order_reviews;

CREATE TABLE bronze.olist_order_reviews (
    review_id NVARCHAR(100),
    order_id NVARCHAR(100),
    review_score NVARCHAR(50),
    review_comment_title NVARCHAR(MAX),
    review_comment_message NVARCHAR(MAX),
    review_creation_date NVARCHAR(100),
    review_answer_timestamp NVARCHAR(100)
);


