# Sales & Customer Analytics Report

--======================================

DATA SEGMENTATION

--======================================
## 1. Customer Segmentation Breakdown
| customer_segmentation | total_customers |
| :--- | :--- |
| Regular customer | 100 |
| VIP_customer | 17 |
| New customer | 91914 |

**Note:** Spending amount is in Brazilian Real (BRL). Customers are segmented as VIP (at least 12 months history and spending more than R$500), Regular (at least 12 months history and spending R$500 or less), and New (lifespan less than 12 months).

**Exchange Rate Breakdown:**
- **1 BRL to USD:** ~$0.199 USD (1 USD ≈ 5.03 BRL)
- **1 BRL to INR:** ~₹18.81 INR

**Key Insights**:Most of the customers fall under 'New' lifespan less than 12 months and spending R$500 or less
Only 17 customers VIP customers there  least 12 months history and spending more than R$500


  ## 2 Payment Installment Segmentation
| installment_bucket | total_installment_count | total_sales | contribution |
| :--- | :--- | :--- | :--- |
| 1-installment | 56531 | 5131462.25 | 37.65% |
| Short term installment(2-6) | 42531 | 4967885.27 | 36.45% |
| medium term installment(7-15) | 14195 | 3493586.68 | 25.64% |
| long term installment (15 or more) | 111 | 34703.24 | 0.25% |

**Key Insights:** The majority of customers complete their payments in a **single installment (58,617)**, closely followed by **short-term installments (44,091)**. Although single installments account for the highest volume of transactions, the total sales generated are nearly identical between single installments (~R$5.34M) and short-term installment plans (~R$5.18M)
: we can conclude  By this MOST OF THE INSTALLMENT  range bewtween(1 to 6) 37%,36.25%


## 3. Product Segmentation by Sales Price Range
| sales_range | total_product_count |
| :--- | :--- |
| Below 100 | 72146 |
| 100-200 | 27101 |
| 200-500 | 10157 |
| 500-2000 | 3092 |
| Above 2000 | 123 |

**Note:** Products are segmented into price ranges using conditional logic: `WHEN I.price < 100 THEN 'Below 100'`, `WHEN I.price BETWEEN 100 AND 200 THEN '100-200'`, `WHEN I.price BETWEEN 200 AND 500 THEN '200-500'`, `WHEN I.price BETWEEN 500 AND 2000 THEN '500-2000'`, and `ELSE 'Above 2000'`.

--====================

--Part to whole analysis

--======================

## 4. Customer Regional Contribution
| customer_region | total_sales | overall_sales | contribution |
| :--- | :--- | :--- | :--- |
| Southeast | 8534758.30 | 13043848.60 | 65.43% |
| Central-West | 830206.23 | 13043848.60 | 6.36% |
| North | 324674.83 | 13043848.60 | 2.49% |
| South | 1875257.96 | 13043848.60 | 14.38% |
| Northeast | 1478951.28 | 13043848.60 | 11.34% |

**Key Insights:**: Southeast region contribute the most overall 65.43% followed by South 14.38%
---

## 5. Product Category Sales Contribution
| product_category | total_sales | overall_sales | contribution |
| :--- | :--- | :--- | :--- |
| computers accessories | 911954.32 | 1260846.23 | 72.33% |
| audio | 50688.50 | 1260846.23 | 4.02% |
| office furniture | 273960.70 | 1260846.23 | 21.73% |
| drinks | 22428.70 | 1260846.23 | 1.78% |
| arts and craftmanship | 1814.01 | 1260846.23 | 0.14% |

**Key Insights:** : computers accessories products contribution the most in over sales which 72.33% and followed by office furniture 21.73%

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

## 9. Distance vs. Freight Cost Analysis
| distance_range_start | distance_range_end | total_orders | avg_freight_value | min_freight_value | max_freight_value |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 0 | 50 | 18746 | 11.435982 | 0.00 | 135.44 |
| 50 | 100 | 10020 | 11.969914 | 0.00 | 105.33 |
| 100 | 150 | 6560 | 14.165932 | 0.00 | 145.18 |
| 150 | 200 | 3916 | 15.446519 | 0.00 | 207.78 |
| 200 | 250 | 4238 | 17.370868 | 0.00 | 321.46 |

**Note:** We have a total of 68 rows we taken only 5 rows. From the analysis, i found that as distance increases, the average freight cost also generally increases, while the number of orders tends to decrease for longer distances.

--===================

--Performance salaes analysis

--====================

## 10. Yearly Product Category Performance vs. Historical Averages
| Order_year | product_category | avg_sales | previous_sales | avg_sales_status | diff_previous_year | previous_sales_status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 2017 | agro industry and commerce | 35076.550000 | NULL | Below the avg | 1998.99 | N/A |
| 2018 | agro industry and commerce | 35076.550000 | 29179.20 | Above the avg | 26491.91 | profit |
| 2016 | air conditioning | 17571.886666 | NULL | Below the avg | NULL | N/A |
| 2017 | air conditioning | 17571.886666 | 1349.29 | Above the avg | 9727.54 | profit |
| 2018 | air conditioning | 17571.886666 | 27180.21 | Above the avg | -16787.74 | loss |
| 2017 | art | 11731.665000 | NULL | Below the avg | -20197.86 | N/A |
| 2018 | art | 11731.665000 | 8981.34 | Above the avg | 12835.86 | profit |
| 2017 | arts and craftmanship | 899.010000 | NULL | Below the avg | -8829.45 | N/A |
| 2018 | arts and craftmanship | 899.010000 | 151.89 | Above the avg | 1494.24 | profit |
| 2016 | audio | 16417.273333 | NULL | Below the avg | -1192.30 | N/A |
| 2017 | audio | 16417.273333 | 156.99 | Above the avg | -216493.13 | profit |
| 2018 | audio | 16417.273333 | 17452.67 | Above the avg | 7456.00 | profit |
| 2016 | auto | 191035.890000 | NULL | Below the avg | 971.27 | N/A |
| 2017 | auto | 191035.890000 | 1128.26 | Above the avg | 87573.92 | profit |
| 2018 | auto | 191035.890000 | 233945.80 | Above the avg | 306391.45 | profit |

**Note:** There are a total of 170+ rows, and we are showcasing a sample of 15 rows here. Performance is evaluated using conditional logic: `avg_sales_status` compares current sales against the multi-year average (Above the avg, Below the avg, or avg), while `previous_sales_status` evaluates year-over-year growth trends (profit, loss, or no change, with N/A assigned when previous sales data is null).

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
