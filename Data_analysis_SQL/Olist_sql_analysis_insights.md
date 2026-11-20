# Sales & Customer Analytics Report

--======================================

DATA SEGMENTATION

--======================================
### 1. Customer Segmentation Report

| customer_segmentation | total_customers |
| :--- | :--- |
| New customer | 94,302 |
| Regular customer | 107 |
| VIP_customer | 19 |

**Note:** Spending amount is in Brazilian Real (BRL). Customers are segmented as VIP (at least 12 months history and spending more than R$500), Regular (at least 12 months history and spending R$500 or less), and New (lifespan less than 12 months).

**Exchange Rate Breakdown:**
- **1 BRL to USD:** ~$0.199 USD (1 USD ≈ 5.03 BRL)
- **1 BRL to INR:** ~₹18.81 INR

**Key Insights**:Most of the customers fall under 'New' lifespan less than 12 months and spending R$500 or less
Only 19 customers VIP customers there  least 12 months history and spending more than R$500


### 2.Installment Bucket Analysis Report

| installment_bucket | total_order_count | total_sales | contribution |
| :--- | :--- | :--- | :--- |
| Short term installment (2-6) | 38,416 | 5,090,004.47 | 37.88% |
| 1-installment | 47,256 | 4,737,352.69 | 35.26% |
| Medium term installment (7-15) | 11,871 | 3,572,837.94 | 26.59% |
| Long term installment (15 or more) | 81 | 35,279.58 | 0.26% |

**Key Insights:** The majority of customers complete their payments in a **Short term installment (5,090,0047)**, closely followed by **1-installment (4737353.69)**. 
with generated sales




### 3. Sales Range & Product Count Distribution Report

| sales_range | total_product_count |
| :--- | :--- |
| Below 100 | 71,352 |
| 100-200 | 26,802 |
| 200-500 | 10,066 |
| 500-2000 | 3,051 |
| Above 2000 | 122 |

**Note:** Products are segmented into price ranges using conditional logic: `WHEN I.price < 100 THEN 'Below 100'`, `WHEN I.price BETWEEN 100 AND 200 THEN '100-200'`, `WHEN I.price BETWEEN 200 AND 500 THEN '200-500'`, `WHEN I.price BETWEEN 500 AND 2000 THEN '500-2000'`, and `ELSE 'Above 2000'`.

--====================

--Part to whole analysis

--======================


### 4. Regional Sales Contribution (Gross Merchandise Value)

| customer_region | total_revenue_with_freight_cost | overall_revenue_with_freight_cost | contribution |
| :--- | :--- | :--- | :--- |
| Southeast | 10,098,715.61 | 15,664,156.25 | 64.47% |
| South | 2,274,622.32 | 15,664,156.25 | 14.52% |
| Northeast | 1,868,313.63 | 15,664,156.25 | 11.93% |
| Central-West | 1,014,351.65 | 15,664,156.25 | 6.48% |
| North | 408,153.04 | 15,664,156.25 | 2.61% |

**Key Insights:**: Southeast region contribute the most overall 64.47% followed by South 14.52%

---===================================

CHANGE OVER TIME

--====================================



# 5. Monthly Sales and Order Trends

| order_year | total_revenue_without_freight_cost | total_sales_with_freight_cost | total_orders | total_customer_orders |
| :--- | :--- | :--- | :--- | :--- |
| 2016-09-01 | 267.36 | 354.75 | 3 | 3 |
| 2016-10-01 | 48920.72 | 56150.00 | 304 | 301 |
| 2016-12-01 | 10.90 | 19.62 | 1 | 1 |
| 2017-01-01 | 120038.33 | 136866.91 | 786 | 753 |
| 2017-02-01 | 245211.99 | 283856.96 | 1718 | 1693 |
| 2017-03-01 | 374255.30 | 431934.52 | 2640 | 2600 |
| 2017-04-01 | 358096.71 | 410101.13 | 2367 | 2335 |
| 2017-05-01 | 504564.34 | 584414.11 | 3644 | 3573 |
| 2017-06-01 | 432426.20 | 502237.54 | 3212 | 3149 |
| 2017-07-01 | 494904.47 | 581029.96 | 3937 | 3863 |
| 2017-08-01 | 573200.39 | 667276.76 | 4290 | 4208 |
| 2017-09-01 | 621587.76 | 717292.20 | 4229 | 4156 |
| 2017-10-01 | 664219.43 | 769312.37 | 4568 | 4501 |
| 2017-11-01 | 1009899.07 | 1178737.40 | 7449 | 7340 |
| 2017-12-01 | 743439.49 | 862982.52 | 5619 | 5552 |
| 2018-01-01 | 947557.97 | 1104249.64 | 7195 | 7095 |
| 2018-02-01 | 841949.45 | 984404.01 | 6682 | 6525 |
| 2018-03-01 | 983168.44 | 1155055.29 | 7186 | 7094 |
| 2018-04-01 | 944974.83 | 1099241.68 | 6541 | 6490 |
| 2018-05-01 | 985520.75 | 1137002.00 | 6785 | 6727 |
| 2018-06-01 | 848716.79 | 1003221.87 | 6034 | 5996 |
| 2018-07-01 | 824000.36 | 973491.28 | 5704 | 5650 |
| 2018-08-01 | 844650.53 | 991106.14 | 6366 | 6325 |
| 2018-09-01 | 145.00 | 166.46 | 1 | 1 |

**Key Insights:** each monthly total revenue without freight cost , total revenue without freight cost  total orders and revenue most of total customer orders come from in the year of 2017 and 2018




## 6. Monthly Sales Trends Cumulative Sales and Moving Averages

| purchased_at | total_sales | Running_total_without_freight_cost | Running_total_with_freight_cost | moving_average |
| :--- | :--- | :--- | :--- | :--- |
| 2016-09-01 | 211.29 | 132.39 | 211.29 | 211.300000 |
| 2016-10-01 | 53,926.82 | 46,974.42 | 54,138.11 | 27,069.100000 |
| 2016-12-01 | 19.62 | 46,985.32 | 54,157.73 | 18,052.600000 |
| 2017-01-01 | 136,607.73 | 166,818.14 | 190,765.46 | 47,691.400000 |
| 2017-02-01 | 283,750.28 | 412,025.59 | 474,515.74 | 94,903.100000 |
| 2017-03-01 | 430,478.25 | 784,965.45 | 904,993.99 | 150,832.300000 |
| 2017-04-01 | 411,335.38 | 1,143,981.42 | 1,316,329.37 | 188,047.100000 |
| 2017-05-01 | 583,334.74 | 1,647,809.06 | 1,899,664.11 | 237,458.000000 |
| 2017-06-01 | 492,119.62 | 2,070,276.02 | 2,391,783.73 | 265,753.700000 |
| 2017-07-01 | 577,118.11 | 2,561,303.39 | 2,968,901.84 | 296,890.200000 |
| 2017-08-01 | 666,433.95 | 3,133,757.34 | 3,635,335.79 | 330,485.100000 |
| 2017-09-01 | 715,551.65 | 3,753,803.72 | 4,350,887.44 | 362,574.000000 |
| 2017-10-01 | 766,409.72 | 4,415,522.81 | 5,117,297.16 | 393,638.200000 |
| 2017-11-01 | 1,167,377.71 | 5,415,355.39 | 6,284,674.87 | 448,905.300000 |
| 2017-12-01 | 859,395.47 | 6,155,526.43 | 7,144,070.34 | 476,271.400000 |
| 2018-01-01 | 1,099,166.29 | 7,098,605.61 | 8,243,236.63 | 515,202.300000 |
| 2018-02-01 | 983,152.31 | 7,939,435.85 | 9,226,388.94 | 542,728.800000 |
| 2018-03-01 | 1,152,567.15 | 8,920,350.46 | 10,378,956.09 | 576,608.700000 |
| 2018-04-01 | 1,121,710.64 | 9,884,733.28 | 11,500,666.73 | 605,298.200000 |
| 2018-05-01 | 1,144,433.93 | 10,876,338.38 | 12,645,100.66 | 632,255.000000 |
| 2018-06-01 | 1,016,620.35 | 11,736,387.92 | 13,661,721.01 | 650,558.100000 |
| 2018-07-01 | 1,014,623.96 | 12,594,642.37 | 14,676,344.97 | 667,106.600000 |
| 2018-08-01 | 987,644.82 | 13,435,329.68 | 15,663,989.79 | 681,043.000000 |
| 2018-09-01 | 166.46 | 13,435,474.68 | 15,664,156.25 | 652,673.200000 |

**Key Insights:**:Each monthly sales with freight cost by year, cumulative revenue exclude freight,cumulative include freight cost and running average monthly sales

--============================================================

CUMMULATIVE ANALYSIS

--==========================================================

### 7. Yearly Orders Running Total & Moving Average Report

| order_year | number_of_orders | running_orders | moving_avg_orders |
| :--- | :--- | :--- | :--- |
| 2016 | 316 | 316 | 316 |
| 2017 | 44,433 | 44,749 | 22,374 |
| 2018 | 53,047 | 97,796 | 32,598 |

**Key Insights:**: year by year number of orders,running orders count ,moving avg count. over sales performance increase over the time
---

### 8 Distance Range vs. Freight Value Analysis Report

| distance_range_start | distance_range_end | total_orders | avg_freight_value | min_freight_value | max_freight_value |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 50 | 19,262 | 11.411089 | 0.00 | 135.44 |
| 50 | 100 | 10,242 | 11.996929 | 0.00 | 105.33 |
| 100 | 150 | 6,658 | 14.214137 | 0.00 | 145.18 |
| 150 | 200 | 3,990 | 15.550814 | 0.00 | 207.78 |
| 200 | 250 | 4,325 | 17.411179 | 0.00 | 321.46 |
| 250 | 300 | 6,449 | 17.354476 | 0.00 | 162.92 |
| 300 | 350 | 12,292 | 18.950122 | 0.00 | 207.78 |
| 350 | 400 | 9,680 | 19.858177 | 0.00 | 306.06 |
| 400 | 450 | 7,467 | 19.752936 | 0.00 | 375.28 |
| 450 | 500 | 9,036 | 19.442563 | 0.00 | 375.28 |

---

### **Key Insights:**
* **Total Bins:** There are **69 bins** but displayed only 10 and evaluated in the complete distance distribution analysis.
* **Distance vs. Order Volume:** Generally, as the delivery distance increases, the volume of total orders tends to decrease, showing that most customer orders are concentrated within closer proximity ranges.
* **Distance vs. Freight Cost:** As the distance increases, the average freight cost (`avg_freight_value`) generally exhibits an upward trend, reflecting higher shipping expenses for longer-distance deliveries.

--===================

--Performance salaes analysis

--====================

### 9 Product Category Yearly Sales & Performance Comparison Report

| Order_year | product_category | avg_sales_incl_freight_cost | previous_sales_incl_freight_cost | avg_sales_status | diff_previous_year | previous_sales_status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 2017 | agro industry and commerce | 39,063.295000 | NULL | Below the avg | 231.96 | N/A |
| 2018 | agro industry and commerce | 39,063.295000 | 31,111.89 | Above the avg | 29,548.62 | profit |
| 2016 | air conditioning | 20,469.470000 | NULL | Below the avg | NULL | N/A |
| 2017 | air conditioning | 20,469.470000 | 1,904.91 | Above the avg | 10,922.85 | profit |
| 2018 | air conditioning | 20,469.470000 | 30,879.93 | Above the avg | -18,391.13 | loss |
| 2017 | art | 13,883.130000 | NULL | Below the avg | -20,811.71 | N/A |
| 2018 | art | 13,883.130000 | 10,300.18 | Above the avg | 15,457.16 | profit |
| 2017 | arts and craftmanship | 1,092.070000 | NULL | Below the avg | -10,124.96 | N/A |
| 2018 | arts and craftmanship | 1,092.070000 | 175.22 | Above the avg | 1,833.70 | profit |
| 2016 | audio | 18,545.343333 | NULL | Below the avg | -1,721.88 | N/A |


**Note:** There are a total of 170+ rows, and we are showcasing a sample of 10 rows here. Performance is evaluated using conditional logic: `avg_sales_status` compares current sales against the multi-year average (Above the avg, Below the avg, or avg), while `previous_sales_status` evaluates year-over-year growth trends (profit, loss, or no change, with N/A assigned when previous sales data is null).

---===========================================

REPORTING CUSTOMER LEVEL

--=============================================

### 10 Customer Lifetime Value & Behavioral Analysis Report

| customer_unique_id | customer_state | customer_region | customer_segmentation | lifespan | recency | total_orders | total_product | total_sales | avg_order_value |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0000366f3b9a7992bf8c76cfdf3221e2 | Sao Paulo | Southeast | New customer | 0 | 8 | 1 | 1 | 129.90 | 129.900000 |
| 0000b849f77a49e4a4ce2b2a4ca5be3f | Sao Paulo | Southeast | New customer | 0 | 8 | 1 | 1 | 18.90 | 18.900000 |
| 0000f46a3911fa3c080544483337064 | Santa Catarina | South | New customer | 0 | 9 | 1 | 1 | 69.00 | 69.000000 |
| 0000f6ccb0745a6a4b88665a16c9f078 | Para | North | New customer | 0 | 9 | 1 | 1 | 25.99 | 25.990000 |
| 0004aac84e0df4da2b147fca70cf8255 | Sao Paulo | Southeast | New customer | 0 | 9 | 1 | 1 | 180.00 | 180.000000 |

**Note:** only shown 5 records ,Customers are segmented using the logic: `CASE WHEN lifespan >= 12 AND total_sales > 300 THEN 'VIP_customer' WHEN lifespan >= 12 AND total_sales <= 300 THEN 'Regular customer' ELSE 'New customer'`. Recency is measured in years since the last order.
