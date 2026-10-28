# Olist Brazilian E-Commerce Analysis Report

---

### Measures Exploration Report

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

| customer_region | overall_item_value |
| :--- | :--- |
| Southeast | 10097773.38 |
| South | 2264330.47 |
| Northeast | 1857982.65 |
| Central-West | 1003227.05 |
| North | 407191.55 |

**Key Insights:** Overall item value combines price and freight cost. The highest spending is generated in the Southeast region.

---

### State-Wise Gross Sales Breakdown

| customer_state | customer_region | Total_price |
| :--- | :--- | :--- |
| Sao Paulo | Southeast | 5131750.85 |
| Rio de Janeiro | Southeast | 1804719.42 |
| Minas Gerais | Southeast | 1563975.55 |
| Rio Grande do Sul | South | 740040.54 |
| Parana | South | 672165.78 |
| Santa Catarina | South | 514763.66 |
| Bahia | Northeast | 505898.65 |
| Federal District | Central-West | 295731.67 |
| Goias | Central-West | 288917.84 |
| Espirito Santo | Southeast | 271414.12 |
| Pernambuco | Northeast | 260874.96 |
| Ceara | Northeast | 222771.18 |
| Para | North | 177978.96 |
| Mato Grosso | Central-West | 153284.22 |
| Maranhao | Northeast | 118493.40 |
| Mato Grosso do Sul | Central-West | 115648.09 |
| Paraiba | Northeast | 113227.89 |
| Piaui | Northeast | 86011.40 |
| Rio Grande do Norte | Northeast | 82230.99 |
| Alagoas | Northeast | 79789.83 |
| Sergipe | Northeast | 58062.95 |
| Tocantins | North | 49181.46 |
| Rondonia | North | 45980.64 |
| Amazonas | North | 22280.84 |
| Acre | North | 15576.96 |
| Amapa | North | 13474.30 |
| Roraima | North | 7480.43 |

**Key Insights:** Sao Paulo ranks 1st in total sales across Brazil, while Roraima records the lowest.

---

### TOP 5 Products by Revenue

| product_id | product_category_name | total_price |
| :--- | :--- | :--- |
| bb50f2e236e5eea0100680137654686c | health_beauty | 63225.00 |
| 6cdd53843498f92890544667809f1595 | health_beauty | 54002.20 |
| d6160fb7873f184099d9bc95e30376af | computers | 48899.34 |
| d1c427060a0f73f6b889a5c7c61f2ac4 | computers_accessories | 46039.56 |
| 99a4788cb24856965c36a24e339b6058 | bed_bath_table | 42626.06 |

**Key Insights:** Top 5 individual products ranked by category revenue from top to bottom.

---

### Lowest 5 Product Categories by Revenue

| product_category_name | total_price |
| :--- | :--- |
| security_and_services | 283.29 |
| fashion_childrens_clothes | 569.85 |
| cds_dvds_musicals | 730.00 |
| home_comfort_2 | 760.27 |
| flowers | 1110.04 |

**Key Insights:** The lowest-performing product categories by total revenue.

---

### Customer Total Revenue by Region

| customer_region | total_revenue |
| :--- | :--- |
| Southeast | 8771859.94 |
| South | 1926969.98 |
| Northeast | 1527361.25 |

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

### Top 3 Highest Spending Customers

| customer_id | customer_state | Total_sales |
| :--- | :--- | :--- |
| 1617b1357756262bfa56ab541c47bc... | Rio de Janeiro | 13440.00 |
| ec5b2ba62e574342386871631fafd3fc | Espirito Santo | 7160.00 |
| c6e2731c5b391845f6800c97401a43... | Mato Grosso | 6735.00 |

**Key Insights:** Top spending customers with Rio de Janeiro leading the top state in this segment.
