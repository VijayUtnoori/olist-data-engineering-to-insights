# Olist Brazilian E-Commerce Analysis Report

---

--===============================

--MEASURES EXPLORATION REPORT

--================================

| Measure_name | Measure_value |
| :--- | :--- |
| Avg payment value | 160.59 |
| Total Customer Records | 99441.00 |
| Total Unique Customers | 96096.00 |
| Total reviews count | 96801.00 |
| Distinct customers orders | 97796.00 |
| Total number of sellers | 3093.00 |
| Total number unique products category s | 74.00 |
| Total number of unique order items | 21.00 |
| Total Revenue Including Freight Charges | 15558270.53 |
| Total Revenue excluding Freight Charges | 13340239.41 |
| Est. profit | 3889567.63 |
| Total Freight Charges | 2218031.12 |


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
| delivered | 95455 |
| shipped | 1094 |
| canceled | 625 |
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

| customer_region | overall_item_value |
| :--- | :--- |
| Southeast | 10028216.93 |
| South | 2257428.17 |
| Northeast | 1860097.40 |
| Central-West | 1005042.03 |
| North | 407486.00 |


**Key Insights:**: Overall Item Value by Customer Region most of customer overall_sales generated from southeast we can observed that most of seller concentrated in that southeast region


--------------------------------------


###  Customer State & Regional Performance Report

| customer_state | customer_region | Total_price | Total_Value_Incl_Freight |
| :--- | :--- | :--- | :--- |
| Sao Paulo | Southeast | 5079736.51 | 5784109.19 |
| Rio de Janeiro | Southeast | 1794013.48 | 2095288.65 |
| Minas Gerais | Southeast | 1560120.15 | 1827241.81 |
| Rio Grande do Sul | South | 734600.95 | 867793.45 |
| Parana | South | 669939.33 | 785944.46 |
| Santa Catarina | South | 514953.46 | 603690.26 |
| Bahia | Northeast | 504265.00 | 603352.89 |
| Federal District | Central-West | 298734.93 | 348700.12 |
| Goias | Central-West | 284201.97 | 336371.51 |
| Espirito Santo | Southeast | 272292.87 | 321577.28 |
| Pernambuco | Northeast | 260262.47 | 319013.72 |
| Ceara | Northeast | 222864.82 | 270596.62 |
| Para | North | 177248.27 | 215584.86 |
| Mato Grosso | Central-West | 155603.27 | 185067.86 |
| Maranhao | Northeast | 118808.85 | 150029.23 |
| Paraiba | Northeast | 113682.20 | 138988.81 |
| Mato Grosso do Sul | Central-West | 115829.10 | 134902.54 |
| Piaui | Northeast | 86553.20 | 107608.86 |
| Rio Grande do Norte | Northeast | 83004.74 | 101812.36 |
| Alagoas | Northeast | 79854.82 | 95662.59 |
| Sergipe | Northeast | 58920.85 | 73032.32 |
| Tocantins | North | 49383.00 | 61041.77 |
| Rondonia | North | 46031.64 | 57423.77 |
| Amazonas | North | 22356.84 | 27835.73 |
| Acre | North | 15762.95 | 19388.10 |
| Amapa | North | 13474.30 | 16262.80 |
| Roraima | North | 7739.44 | 9948.97 |


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

### TOP 3 Customer Total Revenue by Region

| customer_region | total_revenue | TotalValueIncludingFreight |
| :--- | :--- | :--- |
| Southeast | 8706163.01 | 10028216.93 |
| South | 1919493.74 | 2257428.17 |
| Northeast | 1528216.95 | 1860097.40 |


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
| 0a0a92112bd4c708ca5fde585afaa872 | Rio de Janeiro | 13440.00 | 13664.08 |
| da122df9eeddfedc1dc1f5349a1a690c | Rio de Janeiro | 7388.00 | 7571.63 |
| 763c8b1c9c68a0229c42c9fc6f662b93 | Espirito Santo | 7160.00 | 7274.88 |


**Key Insights:** Top spending customers with Rio de Janeiro leading the top state in this segment.
