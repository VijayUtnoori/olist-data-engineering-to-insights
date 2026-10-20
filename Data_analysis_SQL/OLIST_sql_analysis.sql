## 📈 SQL Data Analysis & Reporting Overview

* **Temporal & Cumulative Trends:** Analyzed monthly revenue changes, running totals, and moving averages.
* **Logistics & Freight:** Evaluated freight costs across 50km distance brackets.
* **Sales Performance & YoY:** Compared product category revenues against multi-year averages and tracked year-over-year growth.
* **Part-to-Whole Analysis:** Calculated percentage revenue contributions for regions and top product categories.
* **Data Segmentation:** Grouped products into price brackets and analyzed payment behaviors by installment terms.
* **Customer Reporting & Segmentation:** Built a customer lifetime analytics view incorporating VIP/Regular/New segments, recency, lifespan, AOV, and total spend..

USE Olist_DataWarehouse
--============================
--Chnage over time
--===============================
SELECT TOP 2 * FROM gold.dim_customers
SELECT TOP 2 * FROM gold.dim_products
SELECT TOP 2 * FROM gold.fact_order_items
SELECT TOP 2 * FROM gold.fact_orders
SELECT TOP 2 * FROM gold.fact_payments
SELECT TOP 2 * FROM gold.dim_sellers
SELECT TOP 2 * FROM gold.dim_geolocation

--Analyze how sales change over year in Olist marketplace and count total order and total customer purchased orders 
SELECT
	CAST(DATETRUNC(MONTH,O.purchased_at) AS DATE) AS order_year,
	SUM(I.price) AS total_revenue,
	COUNT(DISTINCT(O.order_id)) AS total_orders,
	COUNT(DISTINCT(C.customer_id)) AS total_customer_orders
FROM gold.fact_orders O
LEFT JOIN gold.fact_order_items I
ON O.order_id=I.order_id
INNER JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
GROUP BY DATETRUNC(MONTH,O.purchased_at)
ORDER BY DATETRUNC(MONTH,O.purchased_at)

--=========================
--Cumulative analysis
--=========================
--Calculate the total sales per month and the running total and moving average of sales over time
SELECT
	purchased_at,
	total_sales,
	SUM(total_sales) OVER(PARTITION BY YEAR(purchased_at) ORDER BY purchased_at ASC) AS Running_total,
	AVG(total_sales) OVER(PARTITION BY YEAR(purchased_at) ORDER BY purchased_at ASC) AS moving_average
FROM(
SELECT
	CAST(DATETRUNC(MONTH,O.purchased_at) AS DATE) AS purchased_at,
	SUM(I.price) AS total_sales,
	ROW_NUMBER() OVER(ORDER BY SUM(I.price)) AS sales_ranking
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
GROUP BY DATETRUNC(MONTH,O.purchased_at)
)t

--Calculate the total orders per year and the running order total and moving average orders over time
WITH ordercount AS(
SELECT
	CAST(DATETRUNC(YEAR,purchased_at)AS DATE)AS order_year,
	COUNT(order_id) AS number_of_orders
FROM gold.fact_orders
GROUP BY DATETRUNC(YEAR,purchased_at)
)
SELECT
	order_year,
	number_of_orders,
	SUM(number_of_orders) OVER(ORDER BY order_year) AS running_orders,
	AVG(number_of_orders) OVER(ORDER BY order_year) AS moving_avg_orders
FROM ordercount;

--find the customer to seller distance w.r.t freight cost
SELECT TOP 2 * FROM gold.vw_order_item_logistics
SELECT TOP 2 * FROM gold.fact_order_items


SELECT 
	FLOOR(L.distance_km/50)*50 AS distance_range_start,
	(FLOOR(L.distance_km/50)*50)+50 AS distance_range_end,
	COUNT(I.order_id) AS total_orders,
	AVG(I.freight_value) AS avg_freight_value,
	MIN(I.freight_value) AS min_freight_value,
	MAX(I.freight_value) AS max_freight_value
FROM gold.fact_order_items I
INNER JOIN gold.vw_order_item_logistics L
ON I.order_id=L.order_id
WHERE distance_km IS NOT NULL AND distance_km >0
GROUP BY FLOOR(L.distance_km/50)*50 
ORDER BY distance_range_start ASC


SELECT TOP 2 * from gold.dim_date

--===================
--Performance salaes analysis
--====================

/*"How does our yearly product category revenue compare against historical performance—specifically against our multi-year average and year-over-year growth trends?"*/

WITH yearly_product_sales AS(
SELECT 
	YEAR(O.purchased_at)AS Order_year,
	P.product_category,
	SUM(I.price) AS current_sales
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
LEFT JOIN gold.dim_products P
ON I.product_id=P.product_id
WHERE product_category IS NOT NULL
GROUP BY YEAR(O.purchased_at),P.product_category
),
calculated_metrics AS(
SELECT 
	Order_year,
	product_category,
	current_sales,
	AVG(current_sales) OVER(PARTITION BY product_category) AS avg_sales,
	LAG(current_sales) OVER(PARTITION BY product_category ORDER BY Order_year) AS previous_sales
FROM yearly_product_sales
)
SELECT
	Order_year,
	product_category,
	avg_sales,
	previous_sales,
	CASE 
	     WHEN current_sales>avg_sales THEN 'Above the avg'
		 WHEN current_sales<avg_sales THEN 'Below the avg'
		 ELSE 'avg'
		 END AS avg_sales_status,
	current_sales-LAG(current_sales) OVER(ORDER BY Order_year) AS diff_previous_year,
	CASE
	     WHEN previous_sales IS NULL THEN 'N/A'
	     WHEN current_sales>previous_sales THEN 'profit'
		 WHEN current_sales<previous_sales THEN 'loss'
		 ELSE 'no change'
		 END AS previous_sales_status
FROM calculated_metrics
ORDER BY product_category,Order_year

--====================
--Part to whole analysis
--======================

--Which customer region contribute the over all sales
WITH Region_sales AS(
SELECT 
    customer_region,
	SUM(I.price) AS total_sales
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
LEFT JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
GROUP BY customer_region
)
SELECT
	customer_region,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(CAST((total_sales/SUM(total_sales) OVER())*100 AS DECIMAL (5,2)), '%') AS contribution
FROM Region_sales
ORDER BY contribution DESC

---Which product category contribute the most in over all sales
WITH product_sales AS(
SELECT
    TOP 5
	P.product_category,
	SUM(I.price) AS total_sales
FROM gold.fact_order_items I
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id
GROUP BY P.product_category 
)
SELECT 
	product_category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(CAST((total_sales / SUM(total_sales) OVER()) * 100 AS DECIMAL(5,2)), '%') AS contribution
FROM product_sales
ORDER BY contribution DESC

--========================
--Data Segmentation
--==========================

--Segmnet product sales range and count how many product fall in that range
WITH Sales_range AS(
SELECT 
P.product_category,
CASE 
	 WHEN I.price<100 THEN 'Below 100'
     WHEN I.price BETWEEN 100 AND 200 THEN '100-200'
	 WHEN I.price BETWEEN 200 AND 500 THEN '200-500'
	 WHEN I.price BETWEEN 500 AND 2000 THEN '500-2000'
	 ELSE 'Above 2000'
	 END AS sales_range
FROM gold.fact_order_items I
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id
)
SELECT 
sales_range,
COUNT(product_category) AS total_product_count
FROM Sales_range
GROUP BY sales_range
ORDER BY total_product_count DESC

---Segment the payment installments and count the installemt fall in that range and there sales

SELECT DISTINCT(payment_installments) FROM gold.fact_payments

WITH installment_range AS(
SELECT
payment_installments,
price,
CASE WHEN payment_installments =1 THEN '1-installment'
     WHEN payment_installments BETWEEN 2 AND 6 THEN 'Short term installment(2-6)'
	 WHEN payment_installments BETWEEN 7 AND 15 THEN 'medium term installment(7-15)'
	 ELSE 'long term installment (15 or more)'
	 END AS installment_bucket

FROM gold.fact_order_items I
INNER JOIN gold.fact_payments P
ON I.order_id=P.order_id
)
SELECT
installment_bucket,
COUNT(*) AS total_installment_count,
SUM(price) AS total_sales
FROM installment_range
GROUP BY installment_bucket
ORDER BY total_installment_count DESC;

--===================
--Reporting
--=================

/*Group customers into three segments based on their spending behavior:
    - VIP: Customers with at least 12 months of history and spending more than R$1,000.
    - Regular: Customers with at least 12 months of history but spending R$5,00 or less.
    - New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS(
SELECT 
	C.customer_unique_id,
	SUM(I.price) AS total_spending,
	MIN(O.purchased_at) AS first_purchase,
	MAX(O.purchased_at) AS last_purchase,
	DATEDIFF(MONTH,MIN(O.purchased_at),MAX(O.purchased_at)) AS lifespan
FROM gold.fact_order_items I
INNER JOIN gold.fact_orders O
ON I.order_id=O.order_id
LEFT JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
GROUP BY C.customer_unique_id
)
SELECT
customer_segmentation,
COUNT(customer_unique_id) AS total_customers
FROM(
SELECT 
customer_unique_id,
CASE WHEN lifespan>=12 AND total_spending>500 THEN 'VIP_customer'
	 WHEN lifespan>=12 AND total_spending<=500 THEN 'Regular customer'
	 ELSE 'New customer'
	 END AS customer_segmentation
FROM customer_spending)T
GROUP BY customer_segmentation 

--=================================================================================
--VIEW REPORTING
/*
Customer Report
===================================================================================

Purpose:
  - This report consolidates key customer metrics and behaviors

Highlights:
  1. Gathers essential fields such as customer_id,customer_unique_id, customer_region
  2. Segments customers into categories (VIP, Regular, New) and age groups.
  3. Aggregates customer-level metrics:
     - total orders
     - total sales
     - total products
     - lifespan (in months)
  4. Calculates valuable KPIs:
     - recency (YEARS since last order)
     - average order value
     - average monthly spend
	 */

--=================================================

WITH Customer_details AS(
SELECT 
	C.customer_unique_id,
	O.order_id,
	P.product_id,
	O.order_status,
	I.price,
	I.total_item_value,
	C.customer_state,
	C.customer_region,
	O.purchased_at,
	O.delivered_at,
	DATEDIFF(DAY,O.purchased_at,O.delivered_at) AS Days_to_deliver
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON I.order_id=O.order_id
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id
LEFT JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
WHERE O.purchased_at IS NOT NULL
),Customer_aggregation AS(
SELECT
	customer_unique_id,
	customer_state,
	customer_region,
	COUNT(DISTINCT(order_id)) AS total_orders,
	SUM(price) AS total_sales,
	COUNT(DISTINCT(product_id)) AS total_product,
	DATEDIFF(MONTH,MIN(purchased_at),MAX(purchased_at)) AS lifespan,
	MAX(purchased_at) AS last_purchase
FROM Customer_details 
GROUP BY 
customer_unique_id,
customer_state,
customer_region
)
SELECT 
	customer_unique_id,
	customer_state,
	customer_region,
	CASE WHEN lifespan>=12 AND total_sales>300 THEN 'VIP_customer'
		 WHEN lifespan>=12 AND total_sales<=300 THEN 'Regular customer'
		 ELSE 'New customer'
	END AS customer_segmentation,
	lifespan,
    DATEDIFF(YEAR,last_purchase,GETDATE()) AS recency,
	total_orders,
	total_product,
	total_sales,
	CASE WHEN total_orders = 0 THEN 0
		ELSE total_sales/total_orders
    END AS avg_order_value -- (Total sales /total no of orders)
FROM Customer_aggregation






