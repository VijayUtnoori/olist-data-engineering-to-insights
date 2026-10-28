##  Exploratory Data Analysis (EDA) Overview

* **Database & Schema:** Audited table structures and metadata across tables like `dim_customers`.
* **Dimensions:** Mapped distinct attributes (customer states, product categories, payment types, and regional seller counts).
* **Dates:** Analyzed temporal ranges, delivery lead times, order approval durations, and estimation accuracy.
* **Core Measures:** Consolidated executive KPIs (reviews, order volumes, revenue totals, and active entity counts).
* **Magnitude Analysis:** Evaluated volume distributions across review scores, payment tiers, order statuses, and regional spend.
* **Rankings (Top-N):** Extracted top-performing products, revenue-driving regions, and state-level top orders using window functions (`ROW_NUMBER`).
USE Olist_DataWarehouse
--========================
--DATA BASE EXPLORATION
--=======================
--Explore all object in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES

--Explore all columns in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_customers'

--==============================
--DIMENTION EXPLORATION
---================================
USE Olist_DataWarehouse

--explore all states over customers belongs
SELECT DISTINCT customer_state FROM gold.dim_customers

--explore all product categorys 
SELECT DISTINCT product_category_name FROM gold.dim_products

--explore all payment types 
SELECT DISTINCT payment_type FROM gold.fact_payments


--customer_region analysis 
SELECT customer_region,COUNT(customer_id) AS No_of_customers FROM gold.dim_customers
GROUP BY customer_region
ORDER BY No_of_customers DESC

--seller_region Analysis
SELECT seller_region,COUNT(seller_id) AS No_of_sellers FROM gold.dim_sellers
GROUP BY seller_region
ORDER BY No_of_sellers DESC

--Number of categorys analysis

SELECT TOP 10 product_category_name,COUNT(product_category_name) AS No_of_categorys FROM gold.dim_products 
GROUP BY product_category_name
ORDER BY No_of_categorys DESC 

---=======================
--DATE EXPLORATION
--==========================
--FIND first_purchase_at,last_purchased_at AND find the range of customer purchase 
SELECT MIN(purchased_at) AS first_purchase_at,
	   MAX(purchased_at) AS last_purchased_date,
	   DATEDIFF(year,MIN(purchased_at),MAX(purchased_at)) AS purchase_range_YEAR
FROM gold.fact_orders;

SELECT TOP 2 * FROM gold.fact_orders;

--FIND purchased_at,delivered_at avg days to take deliverd products
SELECT 
	   AVG(DATEDIFF(day,purchased_at,delivered_at)) AS avg_days_to_deliver
FROM gold.fact_orders;

--find how many hours to take purchased_at,approved_at
SELECT 
	   AVG(DATEDIFF(hour,purchased_at,approved_at)) AS avg_houes_to_approved_order
FROM gold.fact_orders;

--find how many days to product comes early 
SELECT 
	   AVG(DATEDIFF(day,estimated_delivery_at,delivered_at)) AS avg_days_between_deliverd_at_estimated_deliverey
FROM gold.fact_orders;



--===============================
--MEASURES EXPLORATION REPORT
--================================
WITH orders AS(
SELECT order_id,SUM(payment_value) AS total_payment_value 
FROM gold.fact_payments
GROUP BY order_id)
SELECT
'Avg payment value'AS Measure_name ,AVG(total_payment_value) AS Measure_value
FROM orders
UNION ALL
SELECT 'Total payment value'AS Measure_name,SUM(payment_value) AS Measure_value FROM gold.fact_payments
UNION ALL
SELECT 'Total Customer Records'AS Measure_name,COUNT(customer_id) AS Measure_value FROM gold.dim_customers
UNION ALL
SELECT 'Total Unique Customers' AS Measure_name ,COUNT(DISTINCT(customer_unique_id)) AS measure_name 
FROM gold.dim_customers
UNION ALL
SELECT 'Total reviews' AS Measure_name, COUNT(review_id) AS Measure_value  FROM gold.fact_reviews
UNION ALL
SELECT 'Distinct customers orders'AS Measure_name,COUNT(DISTINCT(customer_id)) AS Measure_value FROM gold.fact_orders
UNION ALL
SELECT 'Total number of sellers' AS Measure_name,COUNT(seller_id) AS measure_value
FROM gold.dim_sellers
UNION ALL
SELECT 'Total number unique products'AS Measure_name,COUNT(DISTINCT(product_id)) AS Measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total number of unique order items' AS Measure_name,COUNT(DISTINCT(order_item_id)) AS measure_name 
FROM gold.fact_order_items
UNION ALL
SELECT 'Total sales' AS Measure_name,SUM(price) AS measure_name 
FROM gold.fact_order_items
UNION ALL
SELECT 'Total Value Including Freight Charges' AS Measure_name,SUM(total_item_value) AS measure_name 
FROM gold.fact_order_items
UNION ALL
SELECT 'Total Freight Charges' AS Measure_name,SUM(freight_value) AS measure_name 
FROM gold.fact_order_items

--=================================================
--Magnitude analysis 
--==================================================
--Total customer by region
SELECT 
	customer_region,
	COUNT(customer_id) AS NumberOfCustomers
FROM gold.dim_customers
GROUP BY customer_region
ORDER BY NumberOfCustomers DESC

--Total number of review status(In Dataset we set 4 and 5 as excellent ,3 as average_score and 1 and 2 set as low score
SELECT 
	score_status,
	COUNT(score_status) AS Count_score_status
FROM gold.fact_reviews 
GROUP BY score_status
ORDER BY Count_score_status DESC

--Total count of payment_type 
SELECT 
	payment_type,
	COUNT(payment_type) AS Count_payment_type
FROM gold.fact_payments 
GROUP BY payment_type
ORDER BY Count_payment_type DESC


--Total count payment_status(set 1000 above as high payment value,between 1000 to 500 Medium payment value and below the 500 set low payment value)
SELECT 
	payment_status,
	COUNT(payment_status) AS Count_payment_status
FROM gold.fact_payments 
GROUP BY payment_status
ORDER BY Count_payment_status ASC


--Overall_item_value by each order_item
SELECT 
	order_item_id,
	SUM(total_item_value) AS TotalValueIncludingFreight
FROM gold.fact_order_items
GROUP BY order_item_id
ORDER BY TotalValueIncludingFreight DESC

--Count total order status
SELECT
	order_status,
	COUNT(order_status) AS count_of_order_status
FROM gold.fact_orders
GROUP BY order_status
ORDER BY count_of_order_status DESC 

SELECT 
product_size_category,
COUNT(product_size_category) AS product_size_category
FROM gold.dim_products
GROUP BY product_size_category

SELECT TOP 2 * FROM gold.fact_orders


--total number of sellers by seller region
SELECT
	seller_region,
	COUNT(seller_id) AS Number_of_sellers
FROM gold.dim_sellers
GROUP BY seller_region
ORDER BY Number_of_sellers DESC

--Find Customer region wise Total Customer Outflow

SELECT 
	C.customer_region,
	SUM(I.total_item_value) AS overall_item_value
FROM gold.fact_order_items I
INNER JOIN gold.fact_orders O
ON I.order_id=O.order_id
INNER JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
GROUP BY C.customer_region
ORDER BY overall_item_value DESC

--Find The total gross sales generated by products across brazil state 
SELECT 
	C.customer_state,
	C.customer_region,
	SUM(I.price) AS Total_price,
    SUM(total_item_value) AS TotalValueIncludingFreight
FROM gold.fact_order_items I
INNER JOIN gold.fact_orders O
ON I.order_id=O.order_id
INNER JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
GROUP BY C.customer_state,C.customer_region
ORDER BY TotalValueIncludingFreight DESC


--=======================================================
--Ranking analysis Top N bottom N 
--===========================================
--Top 5 product which generate the highest revenue
SELECT TOP 2 * FROM gold.dim_products
SELECT TOP 5
P.product_id,
P.product_category_name,
SUM(O.price) AS total_price,
SUM(total_item_value) AS TotalValueIncludingFreight
FROM gold.fact_order_items O
LEFT JOIN gold.dim_products P
ON O.product_id=P.product_id
GROUP BY P.product_id,P.product_category_name
ORDER BY total_price DESC


--Top 5 worst product which generate the highest revenue
SELECT TOP 5
P.product_category_name,
SUM(O.price) AS total_price,
SUM(total_item_value) AS TotalValueIncludingFreight
FROM gold.fact_order_items O
LEFT JOIN gold.dim_products P
ON O.product_id=P.product_id
GROUP BY P.product_category_name
ORDER BY total_price ASC

-- Top 3 customer regions generating the highest revenue

SELECT TOP 3
    C.customer_region,
    SUM(I.price) AS total_revenue,
    SUM(total_item_value) AS TotalValueIncludingFreight
FROM gold.fact_order_items AS I
INNER JOIN gold.fact_orders AS O
    ON I.order_id = O.order_id
INNER JOIN gold.dim_customers AS C
    ON O.customer_id = C.customer_id
GROUP BY
    C.customer_region
ORDER BY
    total_revenue DESC;

--TOP 2 orders with in the customer state 

WITH OrderTotals AS (
    SELECT
		O.order_id,
        C.customer_state,
        SUM(I.price) AS order_total
    
    FROM gold.fact_order_items I
    INNER JOIN gold.fact_orders O 
        ON I.order_id = O.order_id
    INNER JOIN gold.dim_customers C 
        ON O.customer_id = C.customer_id
    GROUP BY
		O.order_id,
        C.customer_state),
RankedOrders AS (
    SELECT
        customer_state,
        order_total,
        ROW_NUMBER() OVER (PARTITION BY customer_state ORDER BY order_total DESC) AS ranking
    FROM OrderTotals)
SELECT *
FROM RankedOrders
WHERE ranking <= 2;

--top 3 customers by spending 
SELECT TOP 3
    C.customer_id,    C.customer_state,
    SUM(price) AS TotalSaleswithout_FreightCost,
    SUM(total_item_value) AS TotalValueIncludingFreight
FROM gold.fact_order_items AS I
INNER JOIN gold.fact_orders AS O
    ON I.order_id = O.order_id
INNER JOIN gold.dim_customers AS C
    ON O.customer_id = C.customer_id
GROUP BY
    C.customer_id,
    C.customer_state
ORDER BY
    TotalSaleswithout_FreightCost DESC;














