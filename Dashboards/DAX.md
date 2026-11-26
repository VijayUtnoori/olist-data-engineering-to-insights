## Page 1: Olist Marketplace Summary
**Focus:** High-level marketplace KPIs, dynamic profit/revenue toggling via Field Parameters, product-level order volume, and Prior Year (PY) revenue share analysis.

### Core KPIs & Dynamic Parameters
| Measure / Parameter | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **Total Revenue** | Realized marketplace revenue generated across fulfilled/active order items (excluding `canceled` and `unavailable` orders). | `Total Revenue = CALCULATE(SUM('gold fact_order_items'[total_item_value]), KEEPFILTERS(NOT('gold fact_orders'[order_status] IN {"canceled", "unavailable"})))` |
| **Est. Profit** | Simulated realized profit calculated dynamically using a What-If parameter for assumed margin %. | `Est.Profit = [Total Revenue] * 'Assumed Margin %'[Assumed Margin % Value]` |
| **Total Order Placed** | Total count of unique customer orders placed on the platform (gross demand including canceled/unavailable orders). | `Total Order Placed = DISTINCTCOUNT('gold fact_orders'[order_key])` |
| **Total Customers** | Count of distinct end-customers (`customer_unique_id` prevents double-counting repeat buyers across filtered orders). | `Total Customers = CALCULATE(DISTINCTCOUNT('gold dim_customers'[customer_unique_id]), CROSSFILTER('gold fact_orders'[customer_key], 'gold dim_customers'[customer_key], Both))` |
| **Seller Count** | Total number of active sellers fulfilling orders within the selected filter context (using bidirectional cross-filtering). | `Seller Count = CALCULATE(DISTINCTCOUNT('gold dim_sellers'[seller_key]), CROSSFILTER('gold fact_order_items'[order_key], 'gold fact_orders'[order_key], Both), CROSSFILTER('gold fact_order_items'[seller_key], 'gold dim_sellers'[seller_key], Both))` |
| **Order Count By Products** | Count of distinct orders containing specific products (evaluated at the line-item grain). | `Order Count By Products = DISTINCTCOUNT('gold fact_order_items'[order_id])` |
| **Metric Selector** *(Field Parameter)* | Allows report users to toggle visuals dynamically between **Total Revenue** and **Est. Profit**. | `Metric Selector = { ("Est. Profit", NAMEOF('All Measures'[Est.Profit]), 0), ("Revenue", NAMEOF('All Measures'[Total Revenue]), 1) }` |

### Time Intelligence & Share Analysis
| Measure Name | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **PY Total Revenue** | Calculates total revenue for the prior calendar year relative to the active year slicer selection. | <pre>PY Total Revenue = <br>VAR SelectedYear = SELECTEDVALUE('gold dim_date'[year])<br>RETURN<br>IF(<br>    NOT ISBLANK(SelectedYear),<br>    CALCULATE(<br>        [Total Revenue],<br>        REMOVEFILTERS('gold dim_date'),<br>        'gold dim_date'[year] = SelectedYear - 1<br>    )<br>)</pre> |
| **PY % Of Total** | Computes each product category's share of total Prior Year revenue by removing product-level filters in the denominator. | <pre>PY % Of Total = <br>VAR PY_All_Sales = CALCULATE([PY Total Revenue], ALL('gold dim_products'))<br>RETURN<br>DIVIDE([PY Total Revenue], PY_All_Sales)</pre> |



--=============================================================


## Page 2:Olist Marketplace Customer Analytics
**Focus:** Customer lifetime value (CLV), repeat purchase behavior, regional revenue concentration (Southeast Brazil), and cross-grain customer penetration across product categories and sellers.

### Core Customer & Regional KPIs
| Measure Name | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **Unique Customers** | Counts distinct active buyers who placed orders by activating bi-directional filtering from `fact_orders` to `dim_customers`. | <pre>Unique Customers = <br>CALCULATE(<br>    DISTINCTCOUNT('gold dim_customers'[customer_unique_id]),<br>    CROSSFILTER('gold fact_orders'[customer_key], 'gold dim_customers'[customer_key], Both)<br>)</pre> |
| **CLV** *(Customer Lifetime Value)* | Average gross revenue generated per unique active customer. | `CLV = DIVIDE([Total Revenue], [Unique Customers])` |
| **Repeat Customer Rate %** | Percentage of unique customers who placed more than one order, calculated via virtual table iteration (`ADDCOLUMNS` + `FILTER`). | <pre>Repeat Customer Rate % = <br>VAR CustomerOrders = <br>    ADDCOLUMNS(VALUES('gold dim_customers'[customer_unique_id]), "ordercount", [Total Order Placed])<br>VAR RepeatCustomers = <br>    COUNTROWS(FILTER(CustomerOrders, [ordercount] > 1))<br>RETURN<br>DIVIDE(RepeatCustomers, [Unique Customers])</pre> |
| **SouthEast Region Revenue Share %** | Share of total marketplace revenue originating from customers in the Southeast region. | SouthEast Region Revenue Share % = 
DIVIDE(
    CALCULATE(
        [Total Revenue],
        'gold dim_customers'[customer_region] = "Southeast"
    ),
    CALCULATE(
        [Total Revenue],
        REMOVEFILTERS('gold dim_customers'[customer_region], 'gold dim_customers'[customer_state])
    )
)
|

### Cross-Grain Customer Reach (Product & Seller Level)
| Measure Name | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **Customer(Item Level)** | Bridges line-item dimensions (`dim_products`, `dim_sellers`) to `dim_customers` by chaining two `CROSSFILTER` modifiers across `fact_order_items` and `fact_orders`. | <pre>Customer(Item Level) = <br>CALCULATE(<br>    DISTINCTCOUNT('gold dim_customers'[customer_unique_id]),<br>    CROSSFILTER('gold fact_order_items'[order_key], 'gold fact_orders'[order_key], Both),<br>    CROSSFILTER('gold fact_orders'[customer_key], 'gold dim_customers'[customer_key], Both)<br>)</pre> |
| **Revenue per bayer** | Average item-level revenue generated per unique buyer within a given product or seller context. | `Revenue per bayer = DIVIDE([Total Revenue], [Customer(Item Level)])` |
| **Category Customer Share %** | Percentage of total item-level buyers who purchased from a specific product category. | <pre>Category Customer Share % = <br>DIVIDE(<br>    [Customer(Item Level)],<br>    CALCULATE([Customer(Item Level)], ALL('gold dim_products'))<br>)</pre> |
| **Seller Customer Share %** | Percentage of total item-level buyers who purchased from a specific seller. | <pre>Seller Customer Share % = <br>DIVIDE(<br>    [Customer(Item Level)],<br>    CALCULATE([Customer(Item Level)], ALL('gold dim_sellers'))<br>)</pre> |



--==================================================================================


## Page 3: Olist Marketpalce Review analysis

**Focus:** Customer review sentiment (CSAT vs. negative review rates), survey response times, and the impact of late deliveries, shipping distance tiers, and freight costs on customer ratings.

### Core CSAT & Review KPIs
| Measure Name | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **Overall CSAT %** | Percentage of total reviews with positive scores (4 or 5 stars). | `Overall CSAT % = DIVIDE([Review count 4 & 5], [Total review count])` |
| **Negative Review %** | Percentage of total reviews with poor scores (1 or 2 stars). | `Negative Review % = DIVIDE([Review Count 1 & 2], [Total review count])` |
| **Late Delivery Impact %** | Share of all negative reviews (1 & 2 stars) that came from orders delivered late. | `Late Delivery Impact % = DIVIDE([Late orders review count], [Review Count 1 & 2])` |
| **Avg. Survey Response Days** | Average number of days customers take to submit a survey after receiving the review prompt. | `Avg. Survey Response Days = AVERAGE('gold fact_reviews'[replay_days])` |
| **5 Star Review Count** | Total count of top-rated (5-star) customer reviews. | `5 Star Review Count = CALCULATE(COUNT('gold fact_reviews'[review_score]), 'gold fact_reviews'[review_score] = 5)` |
| **Review count** | Total count of submitted review scores in the active filter context. | `Review count = COUNT('gold fact_reviews'[review_score])` |

### Cross-Grain Logistics & Freight Impact Measures
| Measure Name | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **Avg Freight Cost** | Average shipping freight cost per order, bridged across `fact_reviews` and `fact_orders` via `CROSSFILTER`. | <pre>Avg Freight Cost = <br>CALCULATE(<br>    DIVIDE(SUM('gold fact_order_items'[freight_value]), DISTINCTCOUNT('gold fact_order_items'[order_key])),<br>    CROSSFILTER('gold fact_reviews'[order_key], 'gold fact_orders'[order_key], Both)<br>)</pre> |
| **Avg Freight Ratio %** | Average freight-to-item-price ratio across reviewed orders using bi-directional virtual filtering. | <pre>Avg Freight Ratio % = <br>CALCULATE(<br>    AVERAGE('gold fact_order_items'[freight_ratio_pct]),<br>    CROSSFILTER('gold fact_reviews'[order_key], 'gold fact_orders'[order_key], Both)<br>)</pre> |
| **Distance Avg** | Average delivery duration (in days) across distance tiers by bridging `fact_order_items` to `fact_orders`. | <pre>Distance Avg = <br>CALCULATE(<br>    'All Measures'[Avg. Delivered Days],<br>    CROSSFILTER('gold fact_order_items'[order_key], 'gold fact_orders'[order_key], Both)<br>)</pre> |
| **Distance CSAT %** | Evaluates Overall CSAT % segmented by seller-to-customer Haversine distance tiers. | <pre>Distance CSAT % = <br>CALCULATE(<br>    [Overall CSAT %],<br>    CROSSFILTER('gold fact_order_items'[order_key], 'gold fact_orders'[order_key], Both)<br>)</pre> |

### Calculated Columns (Segmentation & Bucketing)
| Column Name | Table | Business Purpose | DAX Formula |
| :--- | :--- | :--- | :--- |
| **deliverd_status** | `'gold fact_orders'` | Classifies each order's fulfillment outcome into **Not Delivered**, **On-Time / Early**, or **Late** based on delivery variance days. | <pre>deliverd_status = <br>SWITCH(<br>    TRUE(),<br>    ISBLANK('gold fact_orders'[delivery_variance_days]), "Not Delivered",<br>    'gold fact_orders'[delivery_variance_days] >= 0, "On-Time / Early",<br>    "Late"<br>)</pre> |
| **distance_status** | `'gold fact_order_items'` | Segments Haversine seller-to-customer distance (`distance_km`) into 4 logistics tiers: **Local** (0–250 km), **Regional** (251–750 km), **Long distance** (751–1500 km), and **Remote** (>1500 km). | <pre>distance_status = <br>SWITCH(<br>    TRUE(),<br>    'gold fact_order_items'[distance_km] >= 0 && 'gold fact_order_items'[distance_km] <= 250, "Local",<br>    'gold fact_order_items'[distance_km] > 250 && 'gold fact_order_items'[distance_km] <= 750, "Regional",<br>    'gold fact_order_items'[distance_km] > 750 && 'gold fact_order_items'[distance_km] <= 1500, "Long distance",<br>    "Remote"<br>)</pre> |
