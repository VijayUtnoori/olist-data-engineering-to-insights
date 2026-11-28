# Sales & Customer Analytics Report

--======================================

DATA SEGMENTATION

--======================================
### 1. Customer Segmentation Report

| customer_segmentation | total_customers |
| :--- | :--- |
| New customer | 93890|
| Regular customer | 90 |
| VIP_customer | 16 |

**Note:** Q1.Spending amount is in Brazilian Real (BRL). Customers are segmented as VIP (at least 12 months history and spending more than R$500), Regular (at least 12 months history and spending R$500 or less), and New (lifespan less than 12 months).

**Exchange Rate Breakdown:**
- **1 BRL to USD:** ~$0.199 USD (1 USD ≈ 5.03 BRL)
- **1 BRL to INR:** ~₹18.81 INR

**Key Insights**:Most of the customers fall under 'New' lifespan less than 12 months and spending R$500 or less
Only 16 customers VIP customers there  least 12 months history and spending more than R$500

**Note:** (cancelled and unavalible orders excluded)


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



### 5. Monthly Sales and Order Trends

| order_year | total_revenue_without_freight_cost | total_sales_with_freight_cost | total_orders | total_customer_orders | Est_profit |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2016-09-01 | 72.89 | 136.23 | 1 | 1 | 34.0575 |
| 2016-10-01 | 43849.36 | 50612.99 | 285 | 282 | 12653.2475 |
| 2016-12-01 | 10.90 | 19.62 | 1 | 1 | 4.9050 |
| 2017-01-01 | 119618.22 | 136362.70 | 783 | 750 | 34090.6750 |
| 2017-02-01 | 242863.78 | 281031.35 | 1703 | 1679 | 70257.8375 |
| 2017-03-01 | 366936.88 | 424047.62 | 2610 | 2570 | 106011.9050 |
| 2017-04-01 | 352931.72 | 404761.75 | 2368 | 2337 | 101190.4375 |
| 2017-05-01 | 500915.69 | 579854.62 | 3626 | 3556 | 144963.6550 |
| 2017-06-01 | 419344.97 | 488808.82 | 3195 | 3132 | 122202.2050 |
| 2017-07-01 | 485283.19 | 570900.22 | 3912 | 3839 | 142725.0550 |
| 2017-08-01 | 566728.06 | 660132.87 | 4265 | 4184 | 165033.2175 |
| 2017-09-01 | 617060.60 | 712255.46 | 4207 | 4134 | 178063.8650 |
| 2017-10-01 | 657679.28 | 761853.38 | 4526 | 4460 | 190463.3450 |
| 2017-11-01 | 993423.35 | 1160425.62 | 7370 | 7263 | 290106.4050 |
| 2017-12-01 | 738440.66 | 857375.01 | 5599 | 5532 | 214343.7525 |
| 2018-01-01 | 938505.11 | 1093784.41 | 7135 | 7036 | 273446.1025 |
| 2018-02-01 | 834546.96 | 975729.51 | 6603 | 6447 | 243932.3775 |
| 2018-03-01 | 978752.23 | 1150097.32 | 7151 | 7060 | 287524.3300 |
| 2018-04-01 | 961328.05 | 1118261.49 | 6659 | 6607 | 279565.3725 |
| 2018-05-01 | 987959.17 | 1140338.57 | 6816 | 6758 | 285084.6425 |
| 2018-06-01 | 858190.76 | 1014325.14 | 6109 | 6070 | 253581.2850 |
| 2018-07-01 | 840791.50 | 995679.51 | 5924 | 5866 | 248919.8775 |
| 2018-08-01 | 834861.08 | 981309.86 | 6314 | 6274 | 245327.4650 |
| 2018-09-01 | 145.00 | 166.46 | 1 | 1 | 41.6150 |


**Key Insights:** each monthly total revenue without freight cost , total revenue without freight cost  total orders and revenue most of total customer orders come from in the year of 2017 and 2018




## 6. Monthly Sales Trends Cumulative Sales and Moving Averages

| purchased_at | total_sales | Running_total_without_freight_cost | Running_total_with_freight_cost | moving_average | Running_Est_profit |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 2016-09-01 | 136.23 | 72.89 | 136.23 | 136.200000 | 34.0575 |
| 2016-10-01 | 50612.99 | 43922.25 | 50749.22 | 25374.600000 | 12687.3050 |
| 2016-12-01 | 19.62 | 43933.15 | 50768.84 | 16922.900000 | 12692.2100 |
| 2017-01-01 | 136362.70 | 163551.37 | 187131.54 | 46782.900000 | 46782.8850 |
| 2017-02-01 | 281031.35 | 406415.15 | 468162.89 | 93632.600000 | 117040.7225 |
| 2017-03-01 | 424047.62 | 773352.03 | 892210.51 | 148701.800000 | 223052.6275 |
| 2017-04-01 | 404761.75 | 1126283.75 | 1296972.26 | 185281.800000 | 324243.0650 |
| 2017-05-01 | 579854.62 | 1627199.44 | 1876826.88 | 234603.400000 | 469206.7200 |
| 2017-06-01 | 488808.82 | 2046544.41 | 2365635.70 | 262848.400000 | 591408.9250 |
| 2017-07-01 | 570900.22 | 2531827.60 | 2936535.92 | 293653.600000 | 734133.9800 |
| 2017-08-01 | 660132.87 | 3098555.66 | 3596668.79 | 326969.900000 | 899167.1975 |
| 2017-09-01 | 712255.46 | 3715616.26 | 4308924.25 | 359077.000000 | 1077231.0625 |
| 2017-10-01 | 761853.38 | 4373295.54 | 5070777.63 | 390059.800000 | 1267694.4075 |
| 2017-11-01 | 1160425.62 | 5366718.89 | 6231203.25 | 445085.900000 | 1557800.8125 |
| 2017-12-01 | 857375.01 | 6105159.55 | 7088578.26 | 472571.900000 | 1772144.5650 |
| 2018-01-01 | 1093784.41 | 7043664.66 | 8182362.67 | 511397.700000 | 2045590.6675 |
| 2018-02-01 | 975729.51 | 7878211.62 | 9158092.18 | 538711.300000 | 2289523.0450 |
| 2018-03-01 | 1150097.32 | 8856963.85 | 10308189.50 | 572677.200000 | 2577047.3750 |
| 2018-04-01 | 1118261.49 | 9818291.90 | 11426450.99 | 601392.200000 | 2856612.7475 |
| 2018-05-01 | 1140338.57 | 10806251.07 | 12566789.56 | 628339.500000 | 3141697.3900 |
| 2018-06-01 | 1014325.14 | 11664441.83 | 13581114.70 | 646719.700000 | 3395278.6750 |
| 2018-07-01 | 995679.51 | 12505233.33 | 14576794.21 | 662581.600000 | 3644198.5525 |
| 2018-08-01 | 981309.86 | 13340094.41 | 15558104.07 | 676439.300000 | 3889526.0175 |
| 2018-09-01 | 166.46 | 13340239.41 | 15558270.53 | 648261.300000 | 3889567.6325 |


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
