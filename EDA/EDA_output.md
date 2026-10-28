# Olist Brazilian E-Commerce Analysis Report

---

--===============================
--MEASURES EXPLORATION REPORT
--================================

| Measure_name | Measure_value |
| :--- | :--- |
| Avg payment value | 160.99 |
| Total payment value | 16008872.12 |
| Total Customer Records | 99441.00 |
| Total Unique Customers | 96096.00 |
| Total reviews | 98410.00 |
| Distinct customers orders | 98036.00 |
| Total number of sellers | 3093.00 |
| Total number unique products | 32940.00 |
| Total number of unique order items | 21.00 |
| Total sales | 13411726.58 |
| Total Value Including Freight Charges | 15630505.12 |
| Total Freight Charges | 2218778.54 |

**Key Insights:** These are the core measure names along with their respective measure values.

---

--=================================================
--Magnitude analysis 
--==================================================

### Customer Region Distribution

| customer_region | NumberOfCustomers |
| :--- | :--- |
| Southeast | 68266 |
| South | 14148 |
| Northeast | 9394 |
| Central-West | 5782 |
| North | 1851 |

**Key Insights:** There are a total of 5 regions in Brazil. The majority of customers are concentrated in the Southeast, while the North region has the least number of customers.

---

### Review Score Status Breakdown

| score_status | Count_score_status |
| :--- | :--- |
| Excellent_score | 56910 |
| Average_score | 27104 |
| Low_score | 14396 |

**Key Insights:** Most reviews fall under the excellent score category (ratings 5). Average scores (rating 4 and 3) account for 27,104 reviews, and low scores (ratings 1 and 2) account for 14,396 reviews.

---

### Payment Type Distribution

| payment_type | Count_payment_type |
| :--- | :--- |
| credit_card | 76795 |
| bank_slip | 19784 |
| voucher | 5775 |
| debit_card | 1529 |
| unknown | 3 |

**Key Insights:** Credit cards heavily dominate over other payment types, whereas debit cards represent the least used common payment type.

---

### Payment Value Status Breakdown

| payment_status | Count_payment_status |
| :--- | :--- |
| High payment value | 1150 |
| Medium payment value | 3113 |
| Low payment value | 99623 |

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

---

### Overall Item Value by Order Item Position

| order_item_id | overall_item_values |
| :--- | :--- |
| 1 | 14230791.09 |
| 2 | 1001841.91 |
| 3 | 217770.86 |
| 4 | 91389.89 |
| 5 | 42616.51 |
| 6 | 24120.05 |
| 7 | 6917.92 |
| 8 | 5148.76 |
| 9 | 2798.41 |
| 10 | 2436.39 |
| 11 | 1318.29 |
| 12 | 822.36 |
| 13 | 513.84 |
| 14 | 476.46 |
| 15 | 366.26 |
| 16 | 232.35 |
| 17 | 232.35 |
| 18 | 232.35 |
| 19 | 232.35 |
| 20 | 232.35 |
| 21 | 14.37 |

**Key Insights:** Most purchased items correspond to order item ID 1, while ID 21 has the least. *(Note: Item names is not avaliable).*

---

### Seller Region Distribution

| seller_region | Number_of_sellers |
| :--- | :--- |
| Southeast | 2265 |
| South | 688 |
| Central-West | 80 |
| Northeast | 56 |
| North | 4 |

**Key Insights:** There are 5 regions across Brazil; most sellers originate from the Southeast while the North region has the fewest.

---

### Customer Region Total Spend

| customer_region | TotalValueIncludingFreight |
| :--- | :--- |
| Southeast | 10097773.38 |
| South | 2264330.47 |
| Northeast | 1857982.65 |
| Central-West | 1003227.05 |
| North | 407191.55 |

**Key Insights:** Overall item value combines price and freight cost. The highest spending is generated in the Southeast region.

---


### 2. Customer State & Regional Performance Report

| customer_state | customer_region | Total_price | TotalValueIncludingFreight |
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

| product_category_name | total_price | TotalValueIncludingFreight |
| :--- | :--- | :--- |
| security_and_services | 283.29 | 324.51 |
| fashion_childrens_clothing | 569.85 | 665.36 |
| cds_dvds_musicals | 730.00 | 954.99 |
| home_comfort_2 | 760.27 | 1170.58 |
| flowers | 1110.04 | 1598.91 |

**Key Insights:** The lowest-performing product categories by total revenue.

---

### Customer Total Revenue by Region

| customer_region | total_revenue | TotalValueIncludingFreight |
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

| customer_id | customer_state | TotalSaleswithout_FreightCost | TotalValueIncludingFreight |
| :--- | :--- | :--- | :--- |
| 1617b1357756262bfa56ab541c47bc16 | Rio de Janeiro | 13440.00 | 13664.08 |
| ec5b2ba62e574342386871631fafd3fc | Espirito Santo | 7160.00 | 7274.88 |
| c6e2731c5b391845f6800c97401a43a9 | Mato Grosso do Sul | 6735.00 | 6929.31 |

**Key Insights:** Top spending customers with Rio de Janeiro leading the top state in this segment.
