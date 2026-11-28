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
	COUNT(DISTINCT(C.customer_unique_id)) AS total_customer_orders,
	ROUND(SUM(total_item_value)*0.25,2) AS Est_profit
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
LEFT JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
WHERE order_status NOT IN ('canceled','unavailable')
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
	ROUND(AVG(total_sales) OVER(ORDER BY purchased_at ASC),1) AS moving_average,
	SUM(total_sales) OVER(ORDER BY purchased_at ASC)*0.25 Running_Est_profit
FROM(
SELECT
	CAST(DATETRUNC(MONTH,O.purchased_at) AS DATE) AS purchased_at,
	SUM(total_item_value) AS total_sales,
	SUM(price) AS total_sales_without_freight_cost
FROM gold.fact_orders O
INNER JOIN gold.fact_order_items I
ON O.order_id=I.order_id
--EXCLUDE cancelled and unavailable orders 
WHERE order_status NOT IN ('canceled','unavailable')
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
LEFT JOIN gold.fact_order_items I  --make sure that only take the match found
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


LEFT JOIN gold.fact_order_items I
ON O.order_id=I.order_id
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id

--EXCLUDE cancelled and unavailable orders
WHERE product_category IS NOT NULL AND order_status NOT IN ('canceled','unavailable')
GROUP BY YEAR(O.purchased_at),P.product_category),


calculated_metrics AS(
SELECT 
	Order_year,
	product_category,
	current_sales_incl_freight_cost,
	--find the overall average of that product
	AVG(current_sales_incl_freight_cost) OVER(PARTITION BY product_category) AS avg_sales_incl_freight_cost,
	LAG(current_sales_incl_freight_cost) OVER(PARTITION BY product_category ORDER BY Order_year) AS previous_sales_incl_freight_cost
FROM yearly_product_sales)

SELECT
	Order_year,
	product_category,
	avg_sales_incl_freight_cost,
	previous_sales_incl_freight_cost,
	--find the difference and categorize the profit,loss,no change buckets
	CASE 
	     WHEN current_sales_incl_freight_cost>avg_sales_incl_freight_cost THEN 'Above the avg'
		 WHEN current_sales_incl_freight_cost<avg_sales_incl_freight_cost THEN 'Below the avg'
		 ELSE 'avg'
		 END AS avg_sales_status,
	current_sales_incl_freight_cost-previous_sales_incl_freight_cost AS diff_previous_year,
	CASE
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
LEFT JOIN gold.dim_customers C
ON O.customer_id=C.customer_id
WHERE order_status NOT IN ('canceled','unavailable')
GROUP BY customer_region)


SELECT
	customer_region,
	total_revenue_with_freight_cost,
	SUM(total_revenue_with_freight_cost) OVER() AS overall_revenue_with_freight_cost,
	CONCAT(CAST((total_revenue_with_freight_cost/SUM(total_revenue_with_freight_cost) OVER())*100 AS DECIMAL (5,2)), '%') AS contribution
FROM Region_sales
ORDER BY total_revenue_with_freight_cost DESC

--Which product category contribute the most in over all sales
WITH product_sales AS(
SELECT 
	P.product_category,
	SUM(i.price) AS total_revenue_without_freight,
	SUM(total_item_value) AS total_revenue_with_freight_cost

FROM gold.fact_orders O 
LEFT JOIN gold.fact_order_items I
ON O.order_id=I.order_id
INNER JOIN gold.dim_products P
ON I.product_id=P.product_id
--exclude the cancelled and unavailable orders 
WHERE order_status NOT IN ('canceled','unavailable')
GROUP BY P.product_category )

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

--===================
--Reporting
--=================

/*Group customers into three segments based on their spending behavior:
    - VIP: Customers with at least 12 months of history and spending more than R$5,00.
    - Regular: Customers with at least 12 months of history but spending R$5,00 or less.
    - New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS (
    SELECT 
        C.customer_unique_id,
        SUM(I.price) AS total_spending,
        DATEDIFF(DAY, MIN(O.purchased_at), MAX(O.purchased_at)) AS lifespan_days
    FROM gold.fact_order_items I
    IN JOIN gold.fact_orders O
        ON I.order_id = O.order_id
    LEFT JOIN gold.dim_customers C
        ON O.customer_id = C.customer_id
    WHERE O.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY C.customer_unique_id
)
SELECT
    customer_segmentation,
    COUNT(customer_unique_id) AS total_customers
FROM (
    SELECT 
        customer_unique_id,
        CASE 
            WHEN lifespan_days >= 365 AND total_spending > 500 THEN 'VIP_customer'
            WHEN lifespan_days >= 365 AND total_spending <= 500 THEN 'Regular customer'
            ELSE 'New_Customer'
        END AS customer_segmentation
    FROM customer_spending
) T
GROUP BY customer_segmentation
ORDER BY total_customers DESC;











