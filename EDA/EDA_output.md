# Brazilian E-Commerce Exploratory Data Analysis (EDA) Report

---

## 1. Measures Exploration Report

| Measure_name | Measure_value |
| :--- | :--- |
| Total reviews | 98,410.00 |
| Distinct customers orders | 95,088.00 |
| Customers orders | 95,088.00 |
| Total payment value | 16,008,872.12 |
| Avg payment value | 154.10 |
| Total customers | 99,441.00 |
| Total number of sellers | 3,093.00 |
| Total number of products | 32,940.00 |
| Total number of unique order items | 21.00 |
| Total sales | 13,591,643.70 |

* **Key Insight:** Summary of fundamental platform metrics and core exploratory performance values across customers, sellers, orders, products, and overall revenue.

---

## 2. Customer Region Distribution

| customer_region | No_of_customers |
| :--- | :--- |
| Southeast | 68,266 |
| South | 14,148 |
| Northeast | 9,394 |
| Central-West | 5,782 |
| North | 1,851 |

* **Key Insight:** Across the 5 geographic regions of Brazil, the vast majority of customers reside in the Southeast region,
*  whereas the North region registers the smallest customer presence.

---

## 3. Seller Region Distribution

| seller_region | No_of_sellers |
| :--- | :--- |
| Southeast | 2,265 |
| South | 688 |
| Central-West | 80 |
| Northeast | 56 |
| North | 4 |

* **Key Insight:** Similar to customer distribution, sellers are heavily concentrated in the Southeast region,
*  while the North region accounts for the lowest number of active sellers.

---

## 4. Top 10 Product Categories by Volume

| product_category | No_of_categorys |
| :--- | :--- |
| bed bath table | 3,025 |
| sports leisure | 2,867 |
| furniture decor | 2,653 |
| health beauty | 2,444 |
| housewares | 2,335 |
| auto | 1,900 |
| computers accessories | 1,639 |
| toys | 1,411 |
| watches gifts | 1,329 |
| telephony | 1,134 |

* **Key Insight:** Out of 72 distinct product categories present in the dataset, the catalog is led by "bed bath table",
*  followed closely by sports/leisure and furniture/decor.

---

## 5. Review Score Status Breakdown

| score_status | Count_score_status |
| :--- | :--- |
| Excellent_score | 56,910 |
| Average_score | 27,104 |
| Low_score | 14,396 |

* **Key Insight:** The majority of customer reviews fall under "Excellent_score" (ratings of 4 and 5).
*  "Average_score" (rating 3) stands at 27,104, while "Low_score" (ratings 1 and 2) accounts for 14,396 reviews.

---

## 6. Payment Type Distribution

| payment_type | Count_payment_type |
| :--- | :--- |
| credit_card | 76,795 |
| bank_slip | 19,784 |
| voucher | 5,775 |
| debit_card | 1,529 |
| unknown | 3 |

* **Key Insight:** Credit card is overwhelmingly the dominant payment method chosen by customers,
*  whereas debit card accounts for the lowest usage among defined payment modes.

---

## 7. Payment Value Status Breakdown

| payment_status | Count_payment_status |
| :--- | :--- |
| High payment value | 1,150 |
| Medium payment value | 3,113 |
| Low payment value | 99,623 |

* **Key Insight:** The highest transaction volume belongs to the low payment value tier (range 0–499 BRL).
*  Medium payment values (500–999 BRL) follow next, while high payment values (1,000 BRL and above) represent 1,150 transactions.

---

## 8. Product Size Category Distribution

| product_size_category | count_of_products |
| :--- | :--- |
| Bulky | 144 |
| Large | 1,762 |
| Medium | 2,291 |
| Small | 28,743 |

* **Key Insight:** Most products fall into the "Small" size category (below 5 kg).
*  Medium covers 5 kg–9 kg, Large covers 10 kg–29 kg, and Bulky accounts for items exceeding 30 kg.

---

## 9. Overall Item Value by Order Item Position

| order_item_id | overall_item_values |
| :--- | :--- |
| 1 | 14,421,639.62 |
| 2 | 1,019,452.73 |
| 3 | 220,089.96 |
| 4 | 92,629.73 |
| 5 | 43,285.96 |
| 6 | 24,453.51 |
| 7 | 6,944.84 |
| 8 | 5,148.76 |
| 9 | 2,798.41 |
| 10 | 2,436.39 |
| 11 | 1,318.29 |
| 12 | 822.36 |
| 13 | 513.84 |
| 14 | 476.46 |
| 15 | 366.26 |
| 18 | 232.35 |
| 19 | 232.35 |
| 16 | 232.35 |
| 17 | 232.35 |
| 20 | 232.35 |
| 21 | 14.37 |

* **Key Insight:** Primary items (`order_item_id = 1`) generate the vast majority of overall monetary value,
*  while higher item positions occur with decreasing frequency. *(Note: Product names are not present in this table).*

---

## 10. Order Status Distribution

| order_status | count_of_order_status |
| :--- | :--- |
| delivered | 95,082 |
| canceled | 6 |

* **Key Insight:** Nearly all recorded orders were successfully delivered, reflecting high fulfillment efficiency and customer satisfaction with order completion.

---

## 11. Customer Region Total Spend

| customer_region | overall_item_value |
| :--- | :--- |
| Southeast | 9,829,195.28 |
| South | 2,205,956.64 |
| Northeast | 1,799,726.43 |
| Central-West | 976,242.37 |
| North | 398,138.24 |

* **Key Insight:** Overall item value (which combines product price and freight costs) is highest in the Southeast region,
*  aligning with its dominant customer volume.

---

## 12. State-Wise Gross Sales Breakdown

| customer_state | customer_region | Total_sales |
| :--- | :--- | :--- |
| Sao Paulo | Southeast | 4,996,838.54 |
| Rio de Janeiro | Southeast | 1,740,821.16 |
| Minas Gerais | Southeast | 1,532,078.34 |
| Rio Grande do Sul | South | 718,754.98 |
| Parana | South | 655,145.53 |
| Santa Catarina | South | 501,357.45 |
| Bahia | Northeast | 488,132.80 |
| Federal District | Central-West | 289,626.14 |
| Goias | Central-West | 277,292.36 |
| Espirito Santo | Southeast | 265,020.26 |
| Pernambuco | Northeast | 249,976.42 |
| Ceara | Northeast | 215,273.85 |
| Para | North | 173,501.74 |
| Mato Grosso | Central-West | 149,022.31 |
| Maranhao | Northeast | 115,854.56 |
| Mato Grosso do Sul | Central-West | 114,265.42 |
| Paraiba | Northeast | 110,546.63 |
| Piaui | Northeast | 83,818.32 |
| Rio Grande do Norte | Northeast | 81,301.67 |
| Alagoas | Northeast | 78,330.74 |
| Sergipe | Northeast | 55,716.29 |
| Tocantins | North | 47,962.23 |
| Rondonia | North | 45,522.76 |
| Amazonas | North | 22,079.84 |
| Acre | North | 15,524.98 |
| Amapa | North | 13,374.81 |
| Roraima | North | 6,708.47 |

* **Key Insight:** São Paulo ranks #1 among all Brazilian states by total sales revenue, whereas Roraima generates the lowest overall revenue.

---

## 13. Lowest 5 Product Categories by Revenue

| product_category | total_price |
| :--- | :--- |
| security and services | 283.29 |
| fashion childrens clothes | 569.85 |
| cds dvds musicals | 730.00 |
| home comfort 2 | 760.27 |
| flowers | 1,110.04 |

* **Key Insight:** These 5 categories generate the lowest cumulative revenue across the platform (bottom to top).

---

## 14. Top 3 Highest Spending Customers

| customer_id | customer_state | Total_sales |
| :--- | :--- | :--- |
| 1617b1357756262bfa56ab541c47bc... | Rio de Janeiro | 13,440.00 |
| ec5b2ba62e574342386871631fafd3fc | Espirito Santo | 7,160.00 |
| c6e2731c5b391845f6800c97401a43... | Mato Grosso ... | 6,735.00 |

* **Key Insight:** Out of the top spending individual customers, the single highest total order value belongs to a customer in Rio de Janeiro.

---

## 15. Top 2 Orders per Customer State

| customer_state | orders_total | ranking |
| :--- | :--- | :--- |
| Acre | 1,200.00 | 1 |
| Acre | 961.60 | 2 |
| Alagoas | 2,159.98 | 1 |
| Alagoas | 1,798.00 | 2 |
| Amapa | 1,437.00 | 1 |
| Amapa | 1,358.24 | 2 |
| Amazonas | 1,688.00 | 1 |

* **Key Insight:** Top 2 individual order totals calculated per state across all 27 Brazilian states (sample of 4 states shown above).
