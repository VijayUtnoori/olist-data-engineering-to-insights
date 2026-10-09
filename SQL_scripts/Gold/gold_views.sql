USE Olist_DataWarehouse
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_customers;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_geolocation;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_order_items;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_order_payments;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_order_reviews;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_products;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_sellers;
SELECT TOP 10 * FROM Olist_DataWarehouse.silver.olist_orders;
--====================
--CUSTOMER
--========================
CREATE VIEW gold.dim_customer AS(
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
-- Derived Geographic Region
    CASE customer_state
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
FROM Olist_DataWarehouse.silver.olist_customers
)
--============================
--GEOLOCATION
--=======================
CREATE VIEW gold.dim_geolocation AS(
SELECT
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
CREATE VIEW gold.dim_sellers AS(
SELECT
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
-- Derived Geographic Region
    CASE seller_state
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
FROM Olist_DataWarehouse.silver.olist_sellers
)
--==========================
--PRODUCT
--
CREATE VIEW gold.dim_products AS(
SELECT * FROM (
SELECT 
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

--=======================
--orders fact
CREATE VIEW gold.fact_orders AS(
SELECT
    --Integer Surrogate Key
    ROW_NUMBER() OVER(ORDER BY o.order_purchase_timestamp, o.order_id) AS order_sk,
    -- Primary Keys
    o.order_id,
    o.customer_id,
    r.review_id,
     -- Status
    o.order_status, 
    -- Order Timeline Milestones
    o.order_purchase_timestamp AS purchased_at,
    o.order_approved_at AS approved_at,
    o.order_delivered_carrier_date AS shipped_at,
    o.order_delivered_customer_date AS delivered_at,
    o.order_estimated_delivery_date AS estimated_delivery_at,  
    -- Aggregated Payment Metrics
    COALESCE(p.payment_sequential, 1) AS total_payment_sequences,
    COALESCE(p.max_payment_installments, 1) AS max_payment_installments,
    COALESCE(p.total_payment_value, 0) AS total_payment_value, 
    -- Review Metrics
    r.review_score,
    r.review_creation_date AS created_at,
    r.review_answer_timestamp AS answered_at,   
    -- Derived Time Metrics
    DATEDIFF(DAY, o.order_purchase_timestamp, o.order_delivered_customer_date) AS order_delivered_days,
    DATEDIFF(DAY, o.order_delivered_customer_date, o.order_estimated_delivery_date) AS delivery_variance_days,
    DATEDIFF(DAY, o.order_purchase_timestamp, o.order_estimated_delivery_date) AS estimated_delivery_days,
    DATEDIFF(HOUR, o.order_purchase_timestamp, o.order_approved_at) AS approval_delay_hours,
    -- Derived Categorical Statuses
    CASE 
        WHEN r.review_score = 5 THEN 'Excellent_score'
        WHEN r.review_score IN (3, 4) THEN 'Average_score'
        WHEN r.review_score IS NOT NULL THEN 'Low_score'
        ELSE 'Unreviewed'
    END AS score_status,   
    CASE 
        WHEN COALESCE(p.total_payment_value, 0) >= 500 THEN 'High payment value'
        WHEN COALESCE(p.total_payment_value, 0) BETWEEN 100 AND 499.99 THEN 'Medium payment value'
        ELSE 'Low payment value'
    END AS payment_status
FROM Olist_DataWarehouse.silver.olist_orders o
-- Pre-aggregated Payments Subquery (Prevents Order Fan-Out)
LEFT JOIN (
    SELECT 
        order_id,
        COUNT(payment_sequential) AS payment_sequential,
        MAX(payment_installments) AS max_payment_installments,
        SUM(payment_value) AS total_payment_value
    FROM Olist_DataWarehouse.silver.olist_order_payments
    WHERE payment_value > 0
    GROUP BY order_id
) p ON o.order_id = p.order_id
-- Reviews Join
LEFT JOIN Olist_DataWarehouse.silver.olist_order_reviews r 
    ON o.order_id = r.order_id);

---====
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

CREATE VIEW gold.dim_date AS
WITH Tally AS (
    -- Generates up to 10,000 numbers instantly using cross joins
    SELECT TOP (365 * 10) 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b),
Dates AS (
    -- Add days to the start date
    SELECT DATEADD(DAY, n, CAST('2016-01-01' AS DATE)) AS full_date
    FROM Tally
    WHERE DATEADD(DAY, n, CAST('2016-01-01' AS DATE)) <= '2025-12-31')
SELECT 
    -- Primary Surrogate Key (YYYYMMDD)
    CAST(FORMAT(full_date, 'yyyyMMdd') AS INT) AS date_key,
       -- Date Attributes
    full_date,
    YEAR(full_date) AS calendar_year,
    MONTH(full_date) AS calendar_month,
    FORMAT(full_date, 'MMMM') AS month_name,
    FORMAT(full_date, 'MMM') AS month_name_short,
    DATEPART(QUARTER, full_date) AS calendar_quarter,
    CONCAT('Q', DATEPART(QUARTER, full_date)) AS quarter_name,
    DATEPART(WEEK, full_date) AS week_of_year,
    DAY(full_date) AS day_of_month,
    DATEPART(WEEKDAY, full_date) AS day_of_week,
    FORMAT(full_date, 'dddd') AS day_name,
    FORMAT(full_date, 'ddd') AS day_name_short,
       -- Business Indicators
    CASE 
        WHEN DATEPART(WEEKDAY, full_date) IN (1, 7) THEN 1 
        ELSE 0 
    END AS is_weekend,    
    CASE 
        WHEN DATEPART(WEEKDAY, full_date) BETWEEN 2 AND 6 THEN 1 
        ELSE 0 
    END AS is_weekday
FROM Dates;
