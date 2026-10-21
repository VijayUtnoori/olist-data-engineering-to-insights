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
| installment_bucket | total_installment_count | total_sales |
| :--- | :--- | :--- |
| 1-installment | 58617 | 5342623.69 |
| Short term installment(2-6) | 44091 | 5180643.21 |
| medium term installment(7-15) | 14776 | 3650568.86 |
| long term installment (15 or more) | 117 | 35279.58 |

**Key Insights:** The majority of customers complete their payments in a **single installment (58,617)**, closely followed by **short-term installments (44,091)**. Although single installments account for the highest volume of transactions, the total sales generated are nearly identical between single installments (~R$5.34M) and short-term installment plans (~R$5.18M)


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


## 6. Monthly Revenue & Order Volume
| order_year | total_revenue | total_orders | total_customer_orders |
| :--- | :--- | :--- | :--- |
| 2016-09-01 | 134.97 | 1 | 1 |
| 2016-10-01 | 40354.36 | 266 | 266 |
| 2016-12-01 | 10.90 | 1 | 1 |
| 2017-01-01 | 111523.82 | 747 | 747 |
| 2017-02-01 | 232132.37 | 1638 | 1638 |
| 2017-03-01 | 359109.85 | 2545 | 2545 |
| 2017-04-01 | 338839.16 | 2279 | 2279 |
| 2017-05-01 | 487831.45 | 3530 | 3530 |
| 2017-06-01 | 421310.97 | 3130 | 3130 |
| 2017-07-01 | 478598.50 | 3841 | 3841 |
| 2017-08-01 | 553928.41 | 4190 | 4190 |
| 2017-09-01 | 604585.74 | 4136 | 4136 |
| 2017-10-01 | 648247.65 | 4478 | 4478 |
| 2017-11-01 | 987393.07 | 7287 | 7287 |
| 2017-12-01 | 725558.51 | 5508 | 5508 |
| 2018-01-01 | 922192.60 | 7045 | 7045 |
| 2018-02-01 | 824237.86 | 6544 | 6544 |
| 2018-03-01 | 953311.25 | 7001 | 7001 |
| 2018-04-01 | 923081.83 | 6409 | 6409 |
| 2018-05-01 | 966547.76 | 6681 | 6681 |
| 2018-06-01 | 839670.34 | 5973 | 5973 |
| 2018-07-01 | 796706.39 | 5593 | 5593 |
| 2018-08-01 | 828540.84 | 6265 | 6265 |


**Key Insights:** each monthly revenue by year and total orders and revenue most of revenue come from in the year of 2017 and 2018


## 7. Monthly Sales Trends, Running Totals & Moving Averages
| purchased_at | total_sales | Running_total | moving_average |
| :--- | :--- | :--- | :--- |
| 2016-09-01 | 134.97 | 134.97 | 134.970000 |
| 2016-10-01 | 40354.36 | 40489.33 | 20244.665000 |
| 2016-12-01 | 10.90 | 40500.23 | 13500.076666 |
| 2017-01-01 | 111523.82 | 111523.82 | 111523.820000 |
| 2017-02-01 | 232132.37 | 343656.19 | 171828.095000 |
| 2017-03-01 | 359109.85 | 702766.04 | 234255.346666 |
| 2017-04-01 | 338839.16 | 1041605.20 | 260401.300000 |
| 2017-05-01 | 487831.45 | 1529436.65 | 305887.330000 |
| 2017-06-01 | 421310.97 | 1950747.62 | 325124.603333 |
| 2017-07-01 | 478598.50 | 2429346.12 | 347049.445714 |
| 2017-08-01 | 553928.41 | 2983274.53 | 372909.316250 |
| 2017-09-01 | 604585.74 | 3587860.27 | 398651.141111 |
| 2017-10-01 | 648247.65 | 4236107.92 | 423610.792000 |
| 2017-11-01 | 987393.07 | 5223500.99 | 474863.726363 |
| 2017-12-01 | 725558.51 | 5949059.50 | 495754.958333 |
| 2018-01-01 | 922192.60 | 922192.60 | 922192.600000 |
| 2018-02-01 | 824237.86 | 1746430.46 | 873215.230000 |
| 2018-03-01 | 953311.25 | 2699741.71 | 899913.903333 |
| 2018-04-01 | 923081.83 | 3622823.54 | 905705.885000 |
| 2018-05-01 | 966547.76 | 4589371.30 | 917874.260000 |
| 2018-06-01 | 839670.34 | 5429041.64 | 904840.273333 |
| 2018-07-01 | 796706.39 | 6225748.03 | 889392.575714 |
| 2018-08-01 | 828540.84 | 7054288.87 | 881786.108750 |

**Key Insights:**:each Month by year sales trends running total and moving avg 
--============================================================

CUMMULATIVE ANALYSIS

--==========================================================

## 8. Yearly Order Growth & Cumulative Orders
| order_year | number_of_orders | running_orders | moving_avg_orders |
| :--- | :--- | :--- | :--- |
| 2016-01-01 | 268 | 268 | 268 |
| 2017-01-01 | 43309 | 43577 | 21788 |
| 2018-01-01 | 51511 | 95088 | 31696 |

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
| 250 | 300 | 6418 | 17.325440 | 0.00 | 177.94 |
| 300 | 350 | 11799 | 18.979271 | 0.00 | 207.78 |
| 350 | 400 | 9407 | 19.710167 | 0.00 | 306.06 |
| 400 | 450 | 7352 | 19.665733 | 0.00 | 322.10 |
| 450 | 500 | 8798 | 19.338874 | 0.00 | 375.28 |
| 500 | 550 | 6960 | 18.709063 | 0.00 | 193.78 |

**Note:** We have a total of 68 rows. From the analysis, i found that as distance increases, the average freight cost also generally increases, while the number of orders tends to decrease for longer distances.

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
