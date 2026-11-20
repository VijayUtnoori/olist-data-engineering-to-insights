# Olist Brazilian E-Commerce Analysis Report

---

--===============================

--MEASURES EXPLORATION REPORT

--================================

| Measure_name | Measure_value |
| :--- | :--- |
| Avg payment value | 160.59 |
| Total payment value | 15,705,288.03 |
| Total Customer Records | 99,441.00 |
| Total Unique Customers | 96,096.00 |
| Total reviews count | 96,801.00 |
| Distinct customers orders | 97,796.00 |
| Total number of sellers | 3,093.00 |
| Total number unique products | 32,940.00 |
| Total number of unique order items | 21.00 |
| Total sales | 13,435,474.68 |
| Total Value Including Freight Charges | 15,664,156.25 |
| Total Freight Charges | 2,228,681.57 |

**Key Insights:** These are the core measure names along with their respective measure values.

---

--=================================================

--Magnitude analysis 

--==================================================

### Customer Count Distribution by Customer Region

| customer_region | NumberOfCustomers |
| :--- | :--- |
| Southeast | 68,266 |
| South | 14,148 |
| Northeast | 9,394 |
| Central-West | 5,782 |
| North | 1,851 |

**Key Insights:** There are a total of 5 regions in Brazil. The majority of customers are concentrated in the Southeast, while the North region has the least number of customers.

---

### Review Score Status count analysis

| score_status | Count_score_status |
| :--- | :--- |
| Excellent_score | 56,415 |
| Average_score | 26,826 |
| Low_score | 13,560 |

**Key Insights:** Most reviews fall under the excellent score category (ratings 5). Average scores (rating 4 and 3) account for 27,104 reviews, and low scores (ratings 1 and 2) account for 13,560 reviews.

---

### Payment Type Distribution

| payment_type | Count_payment_type |
| :--- | :--- |
| credit_card | 75,647 |
| bank_slip | 19,343 |
| voucher | 5,678 |
| debit_card | 1,491 |
| unknown | 3 |

**Key Insights:** Credit cards heavily dominate over other payment types, whereas debit cards represent the least used common payment type.

---

### Payment Value Status count analysis

| payment_status | Count_payment_status |
| :--- | :--- |
| High payment value | 1,108 |
| Medium payment value | 3,056 |
| Low payment value | 97,998 |

**Key Insights:** The maximum transactions fall under the low payment value range (0–499), followed by medium payment values (500–999), with high payment values (1000 and above)

---

### Order Status Distribution

| order_status | count_of_order_status |
| :--- | :--- |
| delivered | 95082 |
| shipped | 1098 |
| canceled | 625 |
| unavailable | 609 |
| invoiced | 314 |
| processing | 301 |
| created | 5 |
| approved | 2 |

**Key Insights:**: In total order most of the orders are deliverd 

###  Product Catalog Distribution by Size Category

| product_size_category | product_count |
| :--- | :--- |
| Bulky | 144 |
| Large | 1,762 |
| Medium | 2,291 |
| Small | 28,743 |

**Key Insights:**: Segmented the product size in 4  bucket most of the product fall under the small size of products 


---

### Seller Distribution by Region

| seller_region | Number_of_sellers |
| :--- | :--- |
| Southeast | 2,264 |
| South | 688 |
| Central-West | 80 |
| Northeast | 57 |
| North | 4 |

**Key Insights:**: Total we have 3093 sellers most of seller concentrated in southeast region followed by south


---

###  Overall Item Value by Customer Region

| customer_region | overall_sales |
| :--- | :--- |
| Southeast | 10,098,715.61 |
| South | 2,274,622.32 |
| Northeast | 1,868,313.63 |
| Central-West | 1,014,351.65 |
| North | 408,153.04 |

**Key Insights:**: Overall Item Value by Customer Region most of customer overall_sales generated from southeast we can observed that most of seller concentrated in that southeast region


--------------------------------------


###  Customer State & Regional Performance Report

| customer_state | customer_region | Total_price | Total_Value_Incl_Freight_cost |
| :--- | :--- | :--- | :--- |
| Sao Paulo | Southeast | 5131750.85 | 5839570.76 |
| Rio de Janeiro | Southeast | 1804719.42 | 2106752.76 |
| Minas Gerais | Southeast | 1563975.55 | 1831076.60 |
| Rio Grande do Sul | South | 740040.54 | 873119.35 |
| Parana | South | 672165.78 | 788092.35 |
| Bahia | Northeast | 505898.65 | 604663.47 |
| Santa Catarina | South | 514763.66 | 603118.77 |
| Federal District | Central-West | 295731.67 | 345281.87 |
| Goias | Central-West | 288917.84 | 341026.34 |
| Espirito Santo | Southeast | 271414.12 | 320373.26 |
| Pernambuco | Northeast | 260874.96 | 319647.18 |
| Ceara | Northeast | 222771.18 | 270371.78 |
| Para | North | 177978.96 | 216347.98 |
| Mato Grosso | Central-West | 153284.22 | 182223.05 |
| Maranhao | Northeast | 118493.40 | 149548.62 |
| Paraiba | Northeast | 113227.89 | 138375.80 |
| Mato Grosso do Sul | Central-West | 115648.09 | 134695.79 |
| Piaui | Northeast | 86011.40 | 106925.90 |
| Rio Grande do Norte | Northeast | 82230.99 | 100787.77 |
| Alagoas | Northeast | 79789.83 | 95578.46 |
| Sergipe | Northeast | 58062.95 | 72083.67 |
| Tocantins | North | 49181.46 | 60711.31 |
| Rondonia | North | 45980.64 | 57370.13 |
| Amazonas | North | 22280.84 | 27734.85 |
| Acre | North | 15576.96 | 19135.09 |
| Amapa | North | 13474.30 | 16262.80 |
| Roraima | North | 7480.43 | 9629.41 |

**Key Insights:** Sao Paulo ranks 1st in total sales across Brazil, while Roraima records the lowest.

---=======================================

Ranking

--=====================================

### Lowest 5 Product Categories by Revenue

| product_category | total_price | TotalValueIncludingFreight |
| :--- | :--- | :--- |
| security and services | 283.29 | 324.51 |
| fashion childrens clothes | 569.85 | 665.36 |
| cds dvds musicals | 730.00 | 954.99 |
| home comfort 2 | 760.27 | 1,170.58 |
| flowers | 1,110.04 | 1,598.91 |


**Key Insights:** The lowest-performing product categories by total revenue.

---

### Customer Total Revenue by Region

| customer_region | total_revenue | TotalValueIncludingFreight |
| :--- | :--- | :--- |
| Southeast | 8,769,267.31 | 10,098,715.61 |
| South | 1,935,163.84 | 2,274,622.32 |
| Northeast | 1,535,501.42 | 1,868,313.63 |

**Key Insights:** The Southeast customer region generates the highest total revenue.

---

### Top 2 Orders per Customer State

| customer_state | order_total | ranking |
| :--- | :--- | :--- |
| Acre | 1200.00 | 1 |
| Acre | 961.60 | 2 |
| Alagoas | 2159.98 | 1 |
| Alagoas | 1798.00 | 2 |

**Key Insights:** Displays the top 2 order totals from selected states out of the 27 total states.

---


### Top Customers by Sales & Freight Value

| customer_unique_id | customer_state | Total_Sales_without_Freight_Cost | Total_Value_Incl_Freight_cost |
| :--- | :--- | :--- | :--- |
| 0a0a92112bd4c708ca5fde585afaa872 | Rio de Janeiro | 13,440.00 | 13,664.08 |
| da122df9eeddfedc1dc1f5349a1a690c | Rio de Janeiro | 7,388.00 | 7,571.63 |
| 763c8b1c9c68a0229c42c9fc6f662b93 | Espirito Santo | 7,160.00 | 7,274.88 |

**Key Insights:** Top spending customers with Rio de Janeiro leading the top state in this segment.
