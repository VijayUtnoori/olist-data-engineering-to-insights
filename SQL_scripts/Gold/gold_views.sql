USE Olist_DataWarehouse
--==========================================
--CUSTOMER
--========================
DROP VIEW gold.dim_customers
SELECT TOP 3 * FROM gold.dim_customers

CREATE OR ALTER VIEW gold.dim_customers AS
WITH customer_view AS(
SELECT
    ROW_NUMBER() OVER(ORDER BY C.customer_id) AS customer_key,
    C.customer_id,
    C.customer_unique_id,
    C.customer_zip_code_prefix,
    C.customer_city,
    C.customer_state,
    G.geolocation_lat AS customer_lat,
    G.geolocation_lng AS customer_lng,
-- Derived Geographic Region
    CASE C.customer_state
        -- Southeast
        WHEN 'Sao Paulo' THEN 'Southeast'
        WHEN 'Rio de Janeiro' THEN 'Southeast'
        WHEN 'Minas Gerais' THEN 'Southeast'
        WHEN 'Espirito Santo' THEN 'Southeast'
        -- South
        WHEN 'Parana' THEN 'South'
        WHEN 'Rio Grande do Sul' THEN 'South'
        WHEN 'Santa Catarina' THEN 'South'
        -- Northeast
        WHEN 'Bahia' THEN 'Northeast'
        WHEN 'Pernambuco' THEN 'Northeast'
        WHEN 'Ceara' THEN 'Northeast'
        WHEN 'Maranhao' THEN 'Northeast'
        WHEN 'Paraiba' THEN 'Northeast'
        WHEN 'Rio Grande do Norte' THEN 'Northeast'
        WHEN 'Alagoas' THEN 'Northeast'
        WHEN 'Piaui' THEN 'Northeast'
        WHEN 'Sergipe' THEN 'Northeast'
        -- North
        WHEN 'Amazonas' THEN 'North'
        WHEN 'Para' THEN 'North'
        WHEN 'Acre' THEN 'North'
        WHEN 'Rondonia' THEN 'North'
        WHEN 'Roraima' THEN 'North'
        WHEN 'Amapa' THEN 'North'
        WHEN 'Tocantins' THEN 'North'
        --Central-West (Midwest)
        WHEN 'Federal District' THEN 'Central-West'
        WHEN 'Goias' THEN 'Central-West'
        WHEN 'Mato Grosso' THEN 'Central-West'
        WHEN 'Mato Grosso do Sul' THEN 'Central-West'        
        ELSE 'Unknown'
    END AS customer_region
FROM Olist_DataWarehouse.silver.olist_customers C
LEFT JOIN Olist_DataWarehouse.silver.olist_geolocation G
ON C.customer_zip_code_prefix=G.geolocation_zip_code_prefix
)
SELECT
    customer_key,
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    customer_region,
    customer_lat,
    customer_lng
FROM customer_view

--============================
--GEOLOCATION
--=======================
DROP VIEW gold.dim_geolocation
SELECT TOP 3 * FROM gold.dim_geolocation

CREATE OR ALTER VIEW gold.dim_geolocation AS(
SELECT
    ROW_NUMBER() OVER(ORDER BY geolocation_zip_code_prefix) AS geolocation_key,
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
FROM Olist_DataWarehouse.silver.olist_geolocation
)
---===================================
--SELLER
--==========================
DROP VIEW gold.dim_sellers
SELECT TOP 3 * FROM gold.dim_sellers

CREATE OR ALTER VIEW  gold.dim_sellers AS(
SELECT
    ROW_NUMBER() OVER(ORDER BY S.seller_id) AS seller_key,
    S.seller_id,
    S.seller_zip_code_prefix,
    S.seller_city,
    S.seller_state,
    G.geolocation_lat AS seller_lat,
    G.geolocation_lng AS seller_lng,
-- Derived Geographic Region
    CASE S.seller_state
        -- Southeast
        WHEN 'Sao Paulo' THEN 'Southeast'
        WHEN 'Rio de Janeiro' THEN 'Southeast'
        WHEN 'Minas Gerais' THEN 'Southeast'
        WHEN 'Espirito Santo' THEN 'Southeast'
        -- South
        WHEN 'Parana' THEN 'South'
        WHEN 'Rio Grande do Sul' THEN 'South'
        WHEN 'Santa Catarina' THEN 'South'
        -- Northeast
        WHEN 'Bahia' THEN 'Northeast'
        WHEN 'Pernambuco' THEN 'Northeast'
        WHEN 'Ceara' THEN 'Northeast'
        WHEN 'Maranhao' THEN 'Northeast'
        WHEN 'Paraiba' THEN 'Northeast'
        WHEN 'Rio Grande do Norte' THEN 'Northeast'
        WHEN 'Alagoas' THEN 'Northeast'
        WHEN 'Piaui' THEN 'Northeast'
        WHEN 'Sergipe' THEN 'Northeast'
        -- North
        WHEN 'Amazonas' THEN 'North'
        WHEN 'Para' THEN 'North'
        WHEN 'Acre' THEN 'North'
        WHEN 'Rondonia' THEN 'North'
        WHEN 'Roraima' THEN 'North'
        WHEN 'Amapa' THEN 'North'
        WHEN 'Tocantins' THEN 'North'
        --Central-West (Midwest)
        WHEN 'Federal District' THEN 'Central-West'
        WHEN 'Goias' THEN 'Central-West'
        WHEN 'Mato Grosso' THEN 'Central-West'
        WHEN 'Mato Grosso do Sul' THEN 'Central-West'        
        ELSE 'Unknown'
    END AS seller_region
FROM Olist_DataWarehouse.silver.olist_sellers S
LEFT JOIN Olist_DataWarehouse.silver.olist_geolocation G
ON S.seller_zip_code_prefix=G.geolocation_zip_code_prefix
)
--==========================
--PRODUCT
--=======================================
SELECT TOP 2 * FROM gold.dim_products
DROP VIEW gold.dim_products

CREATE OR ALTER VIEW gold.dim_products AS(
SELECT * FROM (
SELECT 
  ROW_NUMBER() OVER(ORDER BY product_id) AS product_key,
  product_id,
  REPLACE(product_category_name,'_',' ') AS product_category,
  product_description_length,
  product_photos_qty,
  CAST(ROUND(product_weight_g / 1000.0, 2) AS FLOAT) AS weight_kg,
  CAST(ROUND((product_length_cm * product_height_cm * product_width_cm), 2) AS FLOAT) AS product_volume_cm,
  CASE 
    WHEN product_weight_g / 1000.0 >= 30 THEN 'Bulky'
    WHEN product_weight_g / 1000.0 >= 10 THEN 'Large'
    WHEN product_weight_g / 1000.0 >= 5 THEN 'Medium'
    ELSE 'Small'
  END AS product_size_category
FROM Olist_DataWarehouse.silver.olist_products)t
WHERE weight_kg>0)

---====================================
--ORDER TABLE
--=============================
SELECT TOP 3 * FROM gold.fact_orders
DROP VIEW gold.fact_orders

CREATE OR ALTER VIEW gold.fact_orders AS(
SELECT 
--serogate key
   ROW_NUMBER() OVER (ORDER BY order_purchase_timestamp, order_id) AS order_key,
   CAST(FORMAT(order_purchase_timestamp,'yyyyMMdd') AS INT)AS purchase_date_key,
   order_id,
   O.customer_id,
   C.customer_unique_id,
   C.customer_key,
   order_status, 
    -- Order Timeline Milestones
   order_purchase_timestamp AS purchased_at,
   order_approved_at AS approved_at,
   order_delivered_carrier_date AS shipped_at,
   order_delivered_customer_date AS delivered_at,
   order_estimated_delivery_date AS estimated_delivery_at,
       -- Derived Time Metrics
   DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date) AS order_delivered_days,
   DATEDIFF(DAY, order_delivered_customer_date, order_estimated_delivery_date) AS delivery_variance_days,
   DATEDIFF(DAY, order_purchase_timestamp, order_estimated_delivery_date) AS estimated_delivery_days,
   DATEDIFF(HOUR, order_purchase_timestamp, order_approved_at) AS approval_delay_hours
FROM Olist_DataWarehouse.silver.olist_orders O
LEFT JOIN gold.dim_customers C
ON C.customer_id=O.customer_id 
);
---=============================
--REVIEWS
--================================
DROP VIEW gold.fact_reviews
CREATE VIEW gold.fact_reviews AS(
SELECT 
    -- Review Metrics
    ROW_NUMBER() OVER(ORDER BY review_id) AS review_key,
    review_id,
    R.order_id,
    O.order_key,
    review_score,
    review_creation_date AS created_at,
    review_answer_timestamp AS answered_at, 
    CASE 
        WHEN review_score = 5 THEN 'Excellent_score'
        WHEN review_score IN (3, 4) THEN 'Average_score'
        WHEN review_score IS NOT NULL THEN 'Low_score'
        ELSE 'Unreviewed'
    END AS score_status, 
    DATEDIFF(DAY,review_creation_date,review_answer_timestamp) AS replay_days
FROM Olist_DataWarehouse.silver.olist_order_reviews R
INNER JOIN gold.fact_orders O
ON R.order_id=O.order_id
);


---======================
--PAYMENT
--============================
DROP VIEW gold.fact_payments
CREATE OR ALTER VIEW gold.fact_payments AS(
SELECT
    -- Surrogate key
    ROW_NUMBER() OVER ( ORDER BY P.order_id, P.payment_sequential ) AS payment_key,--give unique combination
    P.order_id,
    O.order_key,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value,
    -- Derived categorical status
    CASE
        WHEN payment_value >= 1000 THEN 'High payment value'
        WHEN payment_value >= 500 THEN 'Medium payment value'
        ELSE 'Low payment value'
    END AS payment_status
FROM Olist_DataWarehouse.silver.olist_order_payments P
INNER JOIN gold.fact_orders O
ON P.order_id=O.order_id
);

--=====================
--ORDER ITEMS
--===============================

DROP VIEW gold.fact_order_items;
CREATE OR ALTER VIEW gold.fact_order_items AS
SELECT
    -- Unique Integer Surrogate Key
    ROW_NUMBER() OVER (
        ORDER BY i.shipping_limit_date, i.order_id, i.order_item_id
    ) AS order_item_key,
    -- Business / Natural Keys
    i.order_id,
    S.seller_key,
    P.product_key,
    R.order_key,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    -- Date Keys & Timestamps
    CAST(CONVERT(CHAR(8), i.shipping_limit_date, 112) AS INT)
        AS shipping_limit_date_key,
    i.shipping_limit_date,
    -- Base Financial Measures
    i.price,
    i.freight_value,
    -- Derived Financial & Freight Metrics
    (i.price + i.freight_value) AS total_item_value,
    ROUND(
        (i.freight_value / NULLIF(i.price, 0)) * 100,
        2 ) AS freight_ratio_pct,
    CASE
        WHEN (i.freight_value / NULLIF(i.price, 0)) >= 0.30
            THEN 1
        ELSE 0
    END AS is_high_freight
FROM silver.olist_order_items AS i
LEFT JOIN gold.dim_sellers S
    ON i.seller_id=S.seller_id
LEFT JOIN gold.dim_products P
    ON i.product_id=P.product_id
LEFT JOIN gold.fact_orders R
    ON i.order_id=R.order_id


--==================
--DIM_DATE
---=============================

CREATE OR ALTER VIEW gold.dim_date AS
WITH N AS (
    SELECT TOP (1096)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b),
D AS (SELECT DATEADD(DAY, n, CAST('2016-01-01' AS DATE)) AS full_date FROM N)
SELECT
    YEAR(full_date) * 10000
        + MONTH(full_date) * 100
        + DAY(full_date) AS date_key,
    full_date,
    YEAR(full_date) AS calendar_year,
    MONTH(full_date) AS calendar_month,
    DATENAME(MONTH, full_date) AS month_name,
    DATEPART(QUARTER, full_date) AS calendar_quarter,
    DAY(full_date) AS day_of_month,
    DATENAME(WEEKDAY, full_date) AS day_name,
    CASE
        WHEN DATENAME(WEEKDAY, full_date) IN ('Saturday', 'Sunday') THEN 1
        ELSE 0
    END AS is_weekend
FROM D
WHERE full_date <= '2018-12-31';


DROP VIEW gold.vw_order_item_logistics

----======================================================
--order_item_logistics
---=====================================================

CREATE OR ALTER VIEW gold.vw_order_item_logistics AS

SELECT
    -- Order and item information
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    -- Customer coordinates
    c.customer_lat,
    c.customer_lng,
    -- Seller coordinates
    s.seller_lat,
    s.seller_lng,
    -- Distance in kilometers
    CASE
        WHEN c.customer_lat BETWEEN -90 AND 90
         AND c.customer_lng BETWEEN -180 AND 180
         AND s.seller_lat BETWEEN -90 AND 90
         AND s.seller_lng BETWEEN -180 AND 180
        THEN
            2 * 6371.0 * ASIN(
                SQRT(
                    CASE
                        WHEN h.a > 1 THEN 1.0
                        WHEN h.a < 0 THEN 0.0
                        ELSE h.a
                    END  ))
        ELSE NULL
    END AS distance_km,
    -- Distance availability status
    CASE
        WHEN o.order_id IS NULL
            THEN 'Missing Order'
        WHEN c.customer_id IS NULL
            THEN 'Missing Customer Record'
        WHEN s.seller_id IS NULL
            THEN 'Missing Seller Record'
        WHEN c.customer_lat IS NULL
          OR c.customer_lng IS NULL
            THEN 'Missing Customer Coordinates'
        WHEN s.seller_lat IS NULL
          OR s.seller_lng IS NULL
            THEN 'Missing Seller Coordinates'
        WHEN c.customer_lat NOT BETWEEN -90 AND 90
          OR c.customer_lng NOT BETWEEN -180 AND 180
            THEN 'Invalid Customer Coordinates'
        WHEN s.seller_lat NOT BETWEEN -90 AND 90
          OR s.seller_lng NOT BETWEEN -180 AND 180
            THEN 'Invalid Seller Coordinates'
        ELSE 'Valid Distance'
    END AS distance_status

FROM gold.fact_order_items oi
LEFT JOIN gold.fact_orders o
    ON oi.order_id = o.order_id
LEFT JOIN gold.dim_customers c
    ON o.customer_id = c.customer_id
LEFT JOIN gold.dim_sellers s
    ON oi.seller_id = s.seller_id
CROSS APPLY (
    SELECT
        POWER(
            SIN(RADIANS(s.seller_lat - c.customer_lat) / 2),
            2)
        +
        COS(RADIANS(c.customer_lat))
        * COS(RADIANS(s.seller_lat))
        * POWER(
            SIN(RADIANS(s.seller_lng - c.customer_lng) / 2),2 ) AS a) h;


--=================================
--olist_orders_droped
--=====================================
CREATE VIEW gold.olist_orders_droped AS
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
            FROM silver.olist_orders_rejected









