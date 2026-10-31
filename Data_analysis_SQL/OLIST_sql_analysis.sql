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
	SUM(price) AS total_revenue_without_freight_cost,
	SUM(total_item_value) AS total_sales_with_freight_cost,
	COUNT(DISTINCT(O.order_id)) AS total_orders,
	COUNT(DISTINCT(C.customer_unique_id)) AS total_customer_orders
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
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
	SUM(total_sales_without_freight_cost) OVER(ORDER BY purchased_at ASC) AS Running_total_without_freight_cost,
	SUM(total_sales) OVER(ORDER BY purchased_at ASC) AS Running_total_with_freight_cost,
	ROUND(AVG(total_sales) OVER(ORDER BY purchased_at ASC),1) AS moving_average
FROM(
SELECT
	CAST(DATETRUNC(MONTH,O.purchased_at) AS DATE) AS purchased_at,
	SUM(total_item_value) AS total_sales,
	SUM(price) AS total_sales_without_freight_cost
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
GROUP BY DATETRUNC(MONTH,O.purchased_at)
)t
ORDER BY purchased_at ASC

--Calculate the total orders per year and the running order total and moving average orders over time
WITH ordercount AS(
SELECT
	YEAR(purchased_at) AS order_year,
	COUNT(order_id) AS number_of_orders
FROM gold.fact_orders
GROUP BY YEAR(purchased_at)
)
SELECT
	order_year,
	number_of_orders,
	SUM(number_of_orders) OVER(ORDER BY order_year) AS running_orders,
	AVG(number_of_orders) OVER(ORDER BY order_year) AS moving_avg_orders
FROM ordercount;

--find the customer to seller distance w.r.t freight cost


SELECT 
--create bins of 50-50
	FLOOR(L.distance_km/50)*50 AS distance_range_start,
	(FLOOR(L.distance_km/50)*50)+50 AS distance_range_end,
	COUNT(I.order_id) AS total_orders,
	AVG(I.freight_value) AS avg_freight_value,
	MIN(I.freight_value) AS min_freight_value,
	MAX(I.freight_value) AS max_freight_value
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I  --make sure that only take the match found
ON O.order_id=I.order_id
INNER JOIN gold.vw_order_item_logistics L
ON I.order_id=L.order_id
WHERE distance_km IS NOT NULL AND distance_km >0
GROUP BY FLOOR(L.distance_km/50)*50,(FLOOR(L.distance_km/50)*50)+50 --
ORDER BY distance_range_start ASC


--===================
--Performance salaes analysis
--====================

/*"How does our yearly product category revenue compare against historical performance—specifically against our multi-year average and year-over-year growth trends?"*/

WITH yearly_product_sales AS(
SELECT 
--YEARLY categorization 
	YEAR(O.purchased_at) AS Order_year,
	P.product_category,
	SUM(total_item_value) AS current_sales_incl_freight_cost
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id
WHERE product_category IS NOT NULL
GROUP BY YEAR(O.purchased_at),P.product_category),
calculated_metrics AS(
SELECT 
	Order_year,
	product_category,
	current_sales_incl_freight_cost,
	AVG(current_sales_incl_freight_cost) OVER(PARTITION BY product_category) AS avg_sales_incl_freight_cost,
	LAG(current_sales_incl_freight_cost) OVER(PARTITION BY product_category ORDER BY Order_year) AS previous_sales_incl_freight_cost
FROM yearly_product_sales)
SELECT
	Order_year,
	product_category,
	avg_sales_incl_freight_cost,
	previous_sales_incl_freight_cost,
	CASE 
	     WHEN current_sales_incl_freight_cost>avg_sales_incl_freight_cost THEN 'Above the avg'
		 WHEN current_sales_incl_freight_cost<avg_sales_incl_freight_cost THEN 'Below the avg'
		 ELSE 'avg'
		 END AS avg_sales_status,
	current_sales_incl_freight_cost-LAG(current_sales_incl_freight_cost) OVER(ORDER BY Order_year) AS diff_previous_year,
	CASE
	     WHEN previous_sales_incl_freight_cost IS NULL THEN 'N/A'
	     WHEN current_sales_incl_freight_cost>previous_sales_incl_freight_cost THEN 'profit'
		 WHEN current_sales_incl_freight_cost<previous_sales_incl_freight_cost THEN 'loss'
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
	SUM(I.total_item_value) AS 	total_revenue_with_freight_cost
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
INNER JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
GROUP BY customer_region
)
SELECT
	customer_region,
	total_revenue_with_freight_cost,
	SUM(total_revenue_with_freight_cost) OVER() AS overall_revenue_with_freight_cost,
	CONCAT(CAST((total_revenue_with_freight_cost/SUM(total_revenue_with_freight_cost) OVER())*100 AS DECIMAL (5,2)), '%') AS contribution
FROM Region_sales
ORDER BY total_revenue_with_freight_cost DESC


--======================

---Which product category contribute the most in over all sales
WITH product_sales AS(
SELECT
    TOP 5
	P.product_category,
	SUM(i.price) AS total_revenue_without_freight,
	SUM(total_item_value) AS total_revenue_with_freight_cost
FROM gold.fact_order_items I
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id
GROUP BY P.product_category 
)
SELECT 
	product_category,
	total_revenue_without_freight,
	total_revenue_with_freight_cost,
	SUM(total_revenue_with_freight_cost) OVER() AS overall_total_revenue_with_freight_cost,
	CONCAT(CAST((total_revenue_with_freight_cost / SUM(total_revenue_with_freight_cost) OVER()) * 100 AS DECIMAL(5,2)), '%') AS contribution
FROM product_sales
ORDER BY total_revenue_with_freight_cost DESC

--========================
--Data Segmentation
--==========================

--Segmnet product sales range and count how many product category fall in that range
WITH Sales_range AS(
SELECT 
P.product_category_name,
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
COUNT(product_category_name) AS total_product_count
FROM Sales_range
GROUP BY sales_range
ORDER BY total_product_count DESC

---Segment the payment installments and count the installemt fall in that range and there sales

SELECT DISTINCT(payment_installments) FROM gold.fact_payments
--Aggregate items to the order level
WITH order_item_summery AS(
SELECT
	order_id,
	SUM(price) AS order_total_price
FROM gold.fact_order_items
GROUP BY order_id
),
order_payment_summery AS(  --Aggregate payments to the order level
SELECT
	order_id,
	MAX(payment_installments) AS payment_installments
FROM gold.fact_payments 
GROUP BY order_id
),
installment_range AS(  --Combine order-level data and create buckets
SELECT
O.order_id,
P.payment_installments,
I.order_total_price,
CASE 
	WHEN P.payment_installments = 1 THEN '1-installment'
    WHEN P.payment_installments BETWEEN 2 AND 6 THEN 'Short term installment (2-6)'
    WHEN P.payment_installments BETWEEN 7 AND 15 THEN 'Medium term installment (7-15)'
    ELSE 'Long term installment (15 or more)'
    END AS installment_bucket
FROM gold.fact_orders O
INNER JOIN order_item_summery I
ON O.order_id=I.order_id
INNER JOIN order_payment_summery P
ON O.order_id=P.order_id
),
installment_contribution AS(  ---Aggregate by  bucket
SELECT 
        installment_bucket,
        COUNT(order_id) AS total_order_count,
        SUM(order_total_price) AS total_sales
    FROM installment_range
    GROUP BY installment_bucket
)
--Final output with percentage contribution
SELECT 
	installment_bucket,
	total_order_count,
	total_sales,
	CONCAT(CAST((total_sales * 100.0 / SUM(total_sales) OVER()) AS DECIMAL(5,2)), '%') AS contribution
FROM installment_contribution
ORDER BY total_sales DESC;




--===================
--Reporting
--=================

/*Group customers into three segments based on their spending behavior:
    - VIP: Customers with at least 12 months of history and spending more than R$5,00.
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
INNER JOIN gold.dim_customers C
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
ORDER BY total_customers DESC

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
--Gather all of those details
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
INNER JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
WHERE O.purchased_at IS NOT NULL
),
--Aggregate level
Customer_aggregation AS(
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
---segmentation
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






