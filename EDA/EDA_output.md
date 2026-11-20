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

### Customer Region Distribution

| customer_region | NumberOfCustomers |
| :--- | :--- |
| Southeast | 68,266 |
| South | 14,148 |
| Northeast | 9,394 |
| Central-West | 5,782 |
| North | 1,851 |

**Key Insights:** There are a total of 5 regions in Brazil. The majority of customers are concentrated in the Southeast, while the North region has the least number of customers.

---

### Review Score Status Breakdown

| score_status | Count_score_status |
| :--- | :--- |
| Excellent_score | 56,415 |
| Average_score | 26,826 |
| Low_score | 13,560 |

**Key Insights:** Most reviews fall under the excellent score category (ratings 5). Average scores (rating 4 and 3) account for 27,104 reviews, and low scores (ratings 1 and 2) account for 14,396 reviews.

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

### Payment Value Status Breakdown

| payment_status | Count_payment_status |
| :--- | :--- |
| High payment value | 1,108 |
| Medium payment value | 3,056 |
| Low payment value | 97,998 |

**Key Insights:** The maximum transactions fall under the low payment value range (0–499), followed by medium payment values (500–999), with high payment values (1000 and above) recording 1,150 transactions.

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


### 7. Product Catalog Distribution by Size Category

| product_size_category | product_count |
| :--- | :--- |
| Bulky | 144 |
| Large | 1,762 |
| Medium | 2,291 |
| Small | 28,743 |

**Key Insights:**
* **Small-Parcel Dominance:** `Small` items account for ~87.3% (`28,743` out of `32,940` unique products) of the catalog, which helps streamline standard courier shipping and warehouse storage[cite: 7].
* **Minimal Oversized Inventory:** `Bulky` products represent less than 0.5% (`144` items) of the total product catalog[cite: 7].

---

### 8. Seller Distribution by Region

| seller_region | Number_of_sellers |
| :--- | :--- |
| Southeast | 2,264 |
| South | 688 |
| Central-West | 80 |
| Northeast | 57 |
| North | 4 |

**Key Insights:**
* **Severe Supply-Side Centralization:** Together, the **Southeast** (`2,264`) and **South** (`688`) house ~95.4% of all `3,093` sellers[cite: 8].
* **Cross-Regional Shipping Dependency:** While the **Northeast** has `9,394` customers, it only has `57` local sellers—meaning most orders in the Northeast and North (`4` sellers) must be shipped long-distance from the Southeast/South, driving up freight costs and delivery times[cite: 2, 8].

---

### 9. Overall Item Value by Customer Region

| customer_region | overall_item_value |
| :--- | :--- |
| Southeast | 10,098,715.61 |
| South | 2,274,622.32 |
| Northeast | 1,868,313.63 |
| Central-West | 1,014,351.65 |
| North | 408,153.04 |

**Key Insights:**
* **Primary Revenue Engine:** The **Southeast** generates ~64.5% (`10,098,715.61` out of `15,664,156.25`) of total platform value[cite: 9].
* **Higher Average Order Value in Underserved Regions:** Although the **North** (`1,851` customers) and **Northeast** (`9,394` customers) represent smaller customer segments, their per-customer value (`220.50` and `198.88` respectively) is noticeably higher than the **Southeast** (`147.93`), largely driven by higher freight charges and larger basket sizes[cite: 2, 9].

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

---

---=======================================

Ranking

--=====================================

**Key Insights:** Top 5 individual products ranked by category revenue from top to bottom.

---

### Lowest 5 Product Categories by Revenue

| product_category | total_price | Total_Value_Incl_Freight_cost |
| :--- | :--- | :--- |
| security_and_services | 283.29 | 324.51 |
| fashion_childrens_clothing | 569.85 | 665.36 |
| cds_dvds_musicals | 730.00 | 954.99 |
| home_comfort_2 | 760.27 | 1170.58 |
| flowers | 1110.04 | 1598.91 |

**Key Insights:** The lowest-performing product categories by total revenue.

---

### Customer Total Revenue by Region

| customer_region | total_revenue | Total_Value_Incl_Freight_cost |
| :--- | :--- | :--- |
| Southeast | 8771859.94 | 10097773.38 |
| South | 1926969.98 | 2264330.47 |
| Northeast | 1527361.25 | 1857982.65 |

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

| customer_id | customer_state | TotalSales_without_Freight_Cost | Total_Value_Incl_Freight_cost |
| :--- | :--- | :--- | :--- |
| 1617b1357756262bfa56ab541c47bc16 | Rio de Janeiro | 13440.00 | 13664.08 |
| ec5b2ba62e574342386871631fafd3fc | Espirito Santo | 7160.00 | 7274.88 |
| c6e2731c5b391845f6800c97401a43a9 | Mato Grosso do Sul | 6735.00 | 6929.31 |

**Key Insights:** Top spending customers with Rio de Janeiro leading the top state in this segment.
