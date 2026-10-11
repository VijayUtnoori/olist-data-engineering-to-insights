
--CUSTOMER
--========================
CREATE OR ALTER VIEW  gold.dim_customers AS(
SELECT
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

--============================
--GEOLOCATION
--=======================
CREATE OR ALTER VIEW gold.dim_geolocation AS(
SELECT
    ROW_NUMBER() OVER(ORDER BY geolocation_zip_code_prefix) AS geolocation_sk,
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state,
-- Derived Geographic Region
    CASE geolocation_state
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
    END AS geolocation_region
FROM Olist_DataWarehouse.silver.olist_geolocation
)
---===================================
--SELLER
--==========================
CREATE OR ALTER VIEW  gold.dim_sellers AS(
SELECT
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
--
CREATE OR ALTER VIEW gold.dim_products AS(
SELECT * FROM (
SELECT 
  ROW_NUMBER() OVER(ORDER BY product_id) AS product_sk,
  product_id,
  product_category_name,
  product_description_length,
  product_photos_qty,
  CAST(ROUND(product_weight_g / 1000.0, 2) AS FLOAT) AS weight_kg,
  product_height_cm,
  product_width_cm,
  CAST(ROUND((product_length_cm * product_height_cm * product_width_cm), 2) AS FLOAT) AS product_volume_cm,
  CASE 
    WHEN product_weight_g / 1000.0 >= 30 THEN 'Bulky'
    WHEN product_weight_g / 1000.0 >= 10 THEN 'Large'
    WHEN product_weight_g / 1000.0 >= 5 THEN 'Medium'
    ELSE 'Small'
  END AS product_size_category
FROM Olist_DataWarehouse.silver.olist_products)t
WHERE weight_kg>0)

---=============
    --ORDER TABLE
CREATE OR ALTER VIEW gold.fact_orders AS(
SELECT 
--serogate key
   ROW_NUMBER() OVER (ORDER BY order_purchase_timestamp, order_id) AS order_sk,
   order_id,
   customer_id,
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
FROM Olist_DataWarehouse.silver.olist_orders);

---====
--REVIEWS
CREATE VIEW gold.fact_reviews AS(
SELECT 
    -- Review Metrics
    ROW_NUMBER() OVER(ORDER BY review_id) AS review_sk,
    review_id,
    order_id,
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
FROM Olist_DataWarehouse.silver.olist_order_reviews);


---======================
--PAYMENT
CREATE OR ALTER VIEW gold.fact_payments AS
SELECT
    -- Surrogate key
    ROW_NUMBER() OVER ( ORDER BY order_id, payment_sequential ) AS payment_sk,--give unique combination
    order_id,
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
FROM Olist_DataWarehouse.silver.olist_order_payments;

--=====================
--ORDER ITEMS
CREATE VIEW gold.fact_order_items AS
SELECT
    -- Unique Integer Surrogate Key
    ROW_NUMBER() OVER(
        ORDER BY i.shipping_limit_date, i.order_id, i.order_item_id
    ) AS order_item_sk,
    -- Business / Natural Keys
    i.order_id,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    -- Date Keys & Timestamps
    CAST(FORMAT(i.shipping_limit_date, 'yyyyMMdd') AS INT) AS shipping_limit_date_key,
    i.shipping_limit_date,
    -- Base Financial Measures
    i.price,
    i.freight_value,
    -- Derived Financial & Freight Metrics
    (i.price + i.freight_value) AS total_item_value,  
    ROUND((i.freight_value / NULLIF(i.price, 0)) * 100, 2 ) AS freight_ratio_pct,
    CASE 
        WHEN (i.freight_value / NULLIF(i.price, 0)) >= 0.30 THEN 1 
        ELSE 0 
    END AS is_high_freight
FROM Olist_DataWarehouse.silver.olist_order_items i;

--==================
--DIM_DATE

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
---------=======================
Distance------------------
---===========================
--================================================================================================================================================================
--===================================================================================================================================================================
### Distance Calculation

**Formula:** Haversine formula calculates the straight-line distance between customer and seller coordinates (latitude and longitude) in kilometres.

- **Earth radius:** 6,371 km
- **Validation:** Recalculated distances matched the original results for 108,056 rows, with 0 mismatches.

**Limitations:**
- Coordinates are approximate ZIP-code-prefix locations, not exact addresses.
- Distance represents straight-line distance, not actual road or courier distance.
- Missing coordinates result in NULL distances.
- Results show estimated geographic distance, not actual delivery distance.
    --========================================================================================================================================================
   ---==================================================================================================================================================================== 
    
  CREATE OR ALTER VIEW gold.vw_order_item_logistics AS
SELECT
    o.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    c.customer_lat,
    c.customer_lng,
    s.seller_lat,
    s.seller_lng,

    CASE
        WHEN c.customer_lat IS NULL
          OR c.customer_lng IS NULL
          OR s.seller_lat IS NULL
          OR s.seller_lng IS NULL
        THEN NULL
        ELSE
            2 * 6371.0 * ASIN(
                SQRT(
                    CASE
                        WHEN h.a > 1 THEN 1
                        WHEN h.a < 0 THEN 0
                        ELSE h.a
                    END))
        END AS distance_km
FROM gold.fact_orders AS o
--join related tables
INNER JOIN gold.fact_order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN gold.dim_customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN gold.dim_sellers AS s
    ON oi.seller_id = s.seller_id
CROSS APPLY (
    SELECT
        POWER(
            SIN(RADIANS(s.seller_lat - c.customer_lat) / 2), 2)
        + COS(RADIANS(c.customer_lat))
        * COS(RADIANS(s.seller_lat))
        * POWER(
            SIN(RADIANS(s.seller_lng - c.customer_lng) / 2), 2
        ) AS a
) AS h;

SELECT * FROM gold.vw_order_item_logistics

