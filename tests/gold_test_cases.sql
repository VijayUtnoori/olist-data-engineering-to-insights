--CUSTOMER AND SELLER AND GEOLOCATION QUALITY CHECK---====================

SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_sk) AS non_null_keys,
    COUNT(DISTINCT customer_sk) AS unique_keys
FROM gold.dim_customer;

DROP VIEW gold.dim_sellers

SELECT
    COUNT(*) AS total_rows,
    COUNT(geolocation_sk) AS non_null_keys,
    COUNT(DISTINCT geolocation_sk) AS unique_keys
FROM gold.dim_geolocation;

SELECT TOP 5 * FROM gold.dim_sellers

SELECT
    COUNT(*) AS total_rows,
    COUNT(sellers_sk) AS non_null_keys,
    COUNT(DISTINCT sellers_sk) AS unique_keys
FROM gold.dim_sellers;


--PRODUCTS===================================
SELECT
    COUNT(*) AS total_rows,
    COUNT(product_sk) AS non_null_keys,
    COUNT(DISTINCT product_sk) AS unique_keys
FROM gold.dim_products;

SELECT top 5 * FROM gold.dim_products;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS distinct_products
FROM gold.dim_products;

---ORDERS--==========================
--COUNTING-----
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_products
FROM Olist_DataWarehouse.silver.olist_orders
--PAYMENR--=============================
------
------CHECK COMBINATION UNIQUE-------
SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS duplicate_count
FROM silver.olist_order_payments
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1;
------------------------------
----CHECK NULLS AND COUNT---

SELECT COUNT(*) AS null_key_rows
FROM silver.olist_order_payments
WHERE order_id IS NULL
   OR payment_sequential IS NULL;


--CHECK-----------------
   SELECT * FROM gold.fact_payments


--=================================================================
--DISTANCE--============================
SELECT * FROM gold.vw_order_item_logistics


SELECT
    COUNT(*) AS total_rows,
    COUNT(distance_km) AS rows_with_distance,
    MIN(distance_km) AS min_distance_km,
    AVG(distance_km) AS avg_distance_km,
    MAX(distance_km) AS max_distance_km
FROM gold.vw_order_item_logistics;


SELECT TOP (20)
    order_id,
    customer_id,
    seller_id,
    customer_lat,
    customer_lng,
    seller_lat,
    seller_lng,
    distance_km
FROM gold.vw_order_item_logistics
ORDER BY distance_km DESC;


SELECT TOP (20)
    order_id,
    customer_id,
    seller_id,
    customer_lat,
    customer_lng,
    seller_lat,
    seller_lng,
    distance_km
FROM gold.vw_order_item_logistics
WHERE distance_km = 0
ORDER BY order_id;


SELECT TOP (20)
    order_id,
    customer_lat,
    customer_lng,
    seller_lat,
    seller_lng,
    distance_km
FROM gold.vw_order_item_logistics
WHERE distance_km > 2500
ORDER BY distance_km DESC;
