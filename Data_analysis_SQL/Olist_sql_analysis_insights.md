# Sales & Customer Analytics Report

--======================================

DATA SEGMENTATION

--======================================
### Customer Segmentation Report[cite: 17]

| customer_segmentation | total_customers |
| :--- | :--- |
| New customer | 93956 |
| Regular customer | 105 |
| VIP_customer | 18 |

**Note:** Spending amount is in Brazilian Real (BRL). Customers are segmented as VIP (at least 12 months history and spending more than R$500), Regular (at least 12 months history and spending R$500 or less), and New (lifespan less than 12 months).

**Exchange Rate Breakdown:**
- **1 BRL to USD:** ~$0.199 USD (1 USD ≈ 5.03 BRL)
- **1 BRL to INR:** ~₹18.81 INR

**Key Insights**:Most of the customers fall under 'New' lifespan less than 12 months and spending R$500 or less
Only 17 customers VIP customers there  least 12 months history and spending more than R$500


### 2.Installment Bucket Analysis Report[cite: 16]

| installment_bucket | total_order_count | total_sales | contribution |
| :--- | :--- | :--- | :--- |
| Short term installment (2-6) | 38200 | 5067030.04 | 37.78% |
| 1-installment | 47136 | 4730588.10 | 35.27% |
| Medium term installment (7-15) | 11845 | 3579079.23 | 26.69% |
| Long term installment (15 or more) | 79 | 34894.24 | 0.26% |

**Key Insights:** The majority of customers complete their payments in a **Short term installment (5067030)**, closely followed by **1-installment (4730588.10)**. 
with generated sales




### 3. Sales Range & Product Count Distribution Report

| sales_range | total_product_count |
| :--- | :--- |
| Below 100 | 71099 |
| 100-200 | 26669 |
| 200-500 | 10047 |
| 500-2000 | 3058 |
| Above 2000 | 121 |

**Note:** Products are segmented into price ranges using conditional logic: `WHEN I.price < 100 THEN 'Below 100'`, `WHEN I.price BETWEEN 100 AND 200 THEN '100-200'`, `WHEN I.price BETWEEN 200 AND 500 THEN '200-500'`, `WHEN I.price BETWEEN 500 AND 2000 THEN '500-2000'`, and `ELSE 'Above 2000'`.

--====================

--Part to whole analysis

--======================

### 4 Customer Region Sales Contribution Report[cite: 13]

| customer_region | total_sales | overall_sales | contribution |
| :--- | :--- | :--- | :--- |
| Southeast | 8771859.94 | 13411726.58 | 65.40% |
| South | 1926969.98 | 13411726.58 | 14.37% |
| Northeast | 1527361.25 | 13411726.58 | 11.39% |
| Central-West | 853581.82 | 13411726.58 | 6.36% |
| North | 331953.59 | 13411726.58 | 2.48% |

**Key Insights:**: Southeast region contribute the most overall 65.40% followed by South 14.37%
---

### 5 Product Category Sales Contribution Report[cite: 14]

| product_category_name | total_sales | overall_sales | contribution |
| :--- | :--- | :--- | :--- |
| fixed_telephony | 59583.00 | 126315.40 | 47.17% |
| audio | 49369.72 | 126315.40 | 39.08% |
| fashion_male_clothing | 10797.82 | 126315.40 | 8.55% |
| books_imported | 4509.87 | 126315.40 | 3.57% |
| la_cuisine | 2054.99 | 126315.40 | 1.63% |

**Key Insights:** : fixed telephony products contribution the most in over sales which 47.17% and followed by office furniture 39.08%

---===================================

CHANGE OVER TIME

--====================================



### 6. Monthly Revenue, Orders & Customer Trends

| order_year | total_revenue | total_orders | total_customer_orders |
| :--- | :--- | :--- | :--- |
| 2016-09-01 | 267.36 | 3 | 3 |
| 2016-10-01 | 48920.72 | 304 | 301 |
| 2016-12-01 | 10.90 | 1 | 1 |
| 2017-01-01 | 120038.33 | 786 | 753 |
| 2017-02-01 | 245211.99 | 1718 | 1693 |
| 2017-03-01 | 374255.30 | 2640 | 2600 |
| 2017-04-01 | 358096.71 | 2367 | 2335 |
| 2017-05-01 | 504564.34 | 3644 | 3573 |
| 2017-06-01 | 432426.20 | 3212 | 3149 |
| 2017-07-01 | 494904.47 | 3937 | 3863 |
| 2017-08-01 | 573200.39 | 4290 | 4208 |
| 2017-09-01 | 621587.76 | 4229 | 4156 |
| 2017-10-01 | 664219.43 | 4568 | 4501 |
| 2017-11-01 | 1009899.07 | 7449 | 7340 |
| 2017-12-01 | 743439.49 | 5619 | 5552 |
| 2018-01-01 | 947557.97 | 7195 | 7095 |
| 2018-02-01 | 841949.45 | 6682 | 6525 |
| 2018-03-01 | 983168.44 | 7186 | 7094 |
| 2018-04-01 | 944974.83 | 6541 | 6490 |
| 2018-05-01 | 985520.75 | 6785 | 6727 |
| 2018-06-01 | 848716.79 | 6034 | 5996 |
| 2018-07-01 | 824000.36 | 5704 | 5650 |
| 2018-08-01 | 844650.53 | 6366 | 6325 |
| 2018-09-01 | 145.00 | 1 | 1 |


**Key Insights:** each monthly revenue by year and total orders and revenue most of revenue come from in the year of 2017 and 2018


## 7. Monthly Sales Trends, Running Totals & Moving Averages

| purchased_at | total_sales | Running_total | moving_average |
| :--- | :--- | :--- | :--- |
| 2016-09-01 | 267.36 | 267.36 | 267.400000 |
| 2016-10-01 | 48920.72 | 49188.08 | 24594.000000 |
| 2016-12-01 | 10.90 | 49198.98 | 16399.700000 |
| 2017-01-01 | 120038.33 | 169237.31 | 42309.300000 |
| 2017-02-01 | 245211.99 | 414449.30 | 82889.900000 |
| 2017-03-01 | 374255.30 | 788704.60 | 131450.800000 |
| 2017-04-01 | 358096.71 | 1146801.31 | 163828.800000 |
| 2017-05-01 | 504564.34 | 1651365.65 | 206420.700000 |
| 2017-06-01 | 432426.20 | 2083791.85 | 231532.400000 |
| 2017-07-01 | 494904.47 | 2578696.32 | 257869.600000 |
| 2017-08-01 | 573200.39 | 3151896.71 | 286536.100000 |
| 2017-09-01 | 621587.76 | 3773484.47 | 314457.000000 |
| 2017-10-01 | 664219.43 | 4437703.90 | 341361.800000 |
| 2017-11-01 | 1009899.07 | 5447602.97 | 389114.500000 |
| 2017-12-01 | 743439.49 | 6191042.46 | 412736.200000 |
| 2018-01-01 | 947557.97 | 7138600.43 | 446162.500000 |
| 2018-02-01 | 841949.45 | 7980549.88 | 469444.100000 |
| 2018-03-01 | 983168.44 | 8963718.32 | 497984.400000 |
| 2018-04-01 | 944974.83 | 9908693.15 | 521510.200000 |
| 2018-05-01 | 985520.75 | 10894213.90 | 544710.700000 |
| 2018-06-01 | 848716.79 | 11742930.69 | 559187.200000 |
| 2018-07-01 | 824000.36 | 12566931.05 | 571224.100000 |
| 2018-08-01 | 844650.53 | 13411581.58 | 583112.200000 |
| 2018-09-01 | 145.00 | 13411726.58 | 558821.900000 |

**Key Insights:**:each Month by year sales trends running total and moving avg 
--============================================================

CUMMULATIVE ANALYSIS

--==========================================================

### 8. Yearly Orders Running Total & Moving Average Report[cite: 10]

| order_year | number_of_orders | running_orders | moving_avg_orders |
| :--- | :--- | :--- | :--- |
| 2016 | 325 | 325 | 325 |
| 2017 | 44981 | 45306 | 22653 |
| 2018 | 52730 | 98036 | 32678 |

**Key Insights:**: year by year number of orders,running orders count ,moving avg count. over sales performance increase over the time
---

### 9 Distance Range vs. Freight Value Analysis Report[cite: 11]

| distance_range_start | distance_range_end | total_orders | avg_freight_value | min_freight_value | max_freight_value |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 50 | 19304 | 11.410809 | 0.00 | 135.44 |
| 50 | 100 | 10271 | 12.011942 | 0.00 | 105.33 |
| 100 | 150 | 6697 | 14.160665 | 0.00 | 145.18 |
| 150 | 200 | 4005 | 15.572926 | 0.00 | 207.78 |
| 200 | 250 | 4284 | 17.401122 | 0.00 | 321.46 |
| 250 | 300 | 6557 | 17.325558 | 0.00 | 177.94 |
| 300 | 350 | 12020 | 19.009111 | 0.00 | 207.78 |
| 350 | 400 | 9662 | 19.806445 | 0.00 | 306.06 |
| 400 | 450 | 7468 | 19.698847 | 0.00 | 322.10 |
| 450 | 500 | 8990 | 19.508666 | 0.00 | 375.28 |

---

### **Key Insights:**
* **Total Bins:** There are **69 bins** but displayed only 10 and evaluated in the complete distance distribution analysis[cite: 11].
* **Distance vs. Order Volume:** Generally, as the delivery distance increases, the volume of total orders tends to decrease, showing that most customer orders are concentrated within closer proximity ranges[cite: 11].
* **Distance vs. Freight Cost:** As the distance increases, the average freight cost (`avg_freight_value`) generally exhibits an upward trend, reflecting higher shipping expenses for longer-distance deliveries[cite: 11].

--===================

--Performance salaes analysis

--====================

### 10 Product Category Yearly Sales & Performance Comparison Report

| Order_year | product_category_name | avg_sales | previous_sales | avg_sales_status | diff_previous_year | previous_sales_status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 2017 | agro_industry_and_commerce | 36058.735000 | NULL | Below the avg | 1015.19 | N/A |
| 2018 | agro_industry_and_commerce | 36058.735000 | 29179.20 | Above the avg | 28221.39 | profit |
| 2016 | air_conditioning | 18139.020000 | NULL | Below the avg | NULL | N/A |
| 2017 | air_conditioning | 18139.020000 | 1707.09 | Above the avg | 10593.44 | profit |
| 2018 | air_conditioning | 18139.020000 | 28164.01 | Above the avg | -18392.31 | loss |
| 2017 | art | 12004.335000 | NULL | Below the avg | -19887.41 | N/A |
| 2018 | art | 12004.335000 | 9291.79 | Above the avg | 13070.75 | profit |
| 2017 | arts_and_craftmanship | 899.010000 | NULL | Below the avg | -9139.90 | N/A |
| 2018 | arts_and_craftmanship | 899.010000 | 151.89 | Above the avg | 1494.24 | profit |
| 2016 | audio | 16456.573333 | NULL | Below the avg | -1550.10 | N/A |
| 2017 | audio | 16456.573333 | 156.99 | Above the avg | -225080.85 | profit |
| 2018 | audio | 16456.573333 | 17570.57 | Above the avg | 7096.20 | profit |

**Note:** There are a total of 170+ rows, and we are showcasing a sample of 12 rows here. Performance is evaluated using conditional logic: `avg_sales_status` compares current sales against the multi-year average (Above the avg, Below the avg, or avg), while `previous_sales_status` evaluates year-over-year growth trends (profit, loss, or no change, with N/A assigned when previous sales data is null).

---===========================================

REPORTING CUSTOMER LEVEL

--=============================================

## 11. Customer Reporting View Sample
| customer_unique_id | customer_state | customer_region | customer_segmentation | lifespan | recency | total_orders | total_products | total_sales | avg_order_value |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 0000366f3b9a7992bf8c76cfdf3221e2 | Sao Paulo | Southeast | New customer | 0 | 8 | 1 | 1 | 129.90 | 129.900000 |
| 0000b84977a49e4a4ce2b2a4ca5be3f | Sao Paulo | Southeast | New customer | 0 | 8 | 1 | 1 | 18.90 | 18.900000 |
| 0000f46a3911fa3c0805444483337064 | Santa Catarina | South | New customer | 0 | 9 | 1 | 1 | 69.00 | 69.000000 |
| 0000f6ccb0745a6a4b8865a16c9f078 | Para | North | New customer | 0 | 9 | 1 | 1 | 25.99 | 25.990000 |
| 004aac84e0df4da2b147fca70cf8255 | Sao Paulo | Southeast | New customer | 0 | 9 | 1 | 1 | 180.00 | 180.000000 |

**Note:** Customers are segmented using the logic: `CASE WHEN lifespan >= 12 AND total_sales > 300 THEN 'VIP_customer' WHEN lifespan >= 12 AND total_sales <= 300 THEN 'Regular customer' ELSE 'New customer'`. Recency is measured in years since the last order.
