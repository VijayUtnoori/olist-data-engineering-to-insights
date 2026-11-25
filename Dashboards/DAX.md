## Page 1: Olist Marketplace Summary
**Focus:** High-level marketplace KPIs, dynamic profit/revenue toggling via Field Parameters, product-level order volume, and Prior Year (PY) revenue share analysis.

### Core KPIs & Dynamic Parameters
| Measure / Parameter | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **Total Revenue** | Gross marketplace revenue generated across all sold order items. | `Total Revenue = SUM('gold fact_order_items'[total_item_value])` |
| **Est. Profit** | Simulated gross profit calculated dynamically using a What-If parameter for assumed margin %. | `Est.Profit = [Total Revenue] * 'Assumed Margin %'[Assumed Margin % Value]` |
| **Total Order Placed** | Total count of unique customer orders placed on the platform. | `Total Order Placed = DISTINCTCOUNT('gold fact_orders'[order_key])` |
| **Total Customers** | Count of distinct end-customers (`customer_unique_id` prevents double-counting repeat buyers). | `Total Customers = DISTINCTCOUNT('gold dim_customers'[customer_unique_id])` |
| **Seller Count** | Total number of active sellers registered in the marketplace dimension. | `Seller Count = DISTINCTCOUNT('gold dim_sellers'[seller_key])` |
| **Order Count By Products** | Count of distinct orders containing specific products (evaluated at the line-item grain). | `Order Count By Products = DISTINCTCOUNT('gold fact_order_items'[order_id])` |
| **Metric Selector** *(Field Parameter)* | Allows report users to toggle visuals dynamically between **Total Revenue** and **Est. Profit**. | `Metric Selector = { ("Est. Profit", NAMEOF('All Measures'[Est.Profit]), 0), ("Revenue", NAMEOF('All Measures'[Total Revenue]), 1) }` |

### Time Intelligence & Share Analysis
| Measure Name | Business Purpose | DAX Formula |
| :--- | :--- | :--- |
| **PY Total Revenue** | Calculates total revenue for the prior calendar year relative to the active year slicer selection. | <pre>PY Total Revenue = <br>VAR SelectedYear = SELECTEDVALUE('gold dim_date'[year])<br>RETURN<br>IF(<br>    NOT ISBLANK(SelectedYear),<br>    CALCULATE(<br>        [Total Revenue],<br>        REMOVEFILTERS('gold dim_date'),<br>        'gold dim_date'[year] = SelectedYear - 1<br>    )<br>)</pre> |
| **PY % Of Total** | Computes each product category's share of total Prior Year revenue by removing product-level filters in the denominator. | <pre>PY % Of Total = <br>VAR PY_All_Sales = CALCULATE([PY Total Revenue], ALL('gold dim_products'))<br>RETURN<br>DIVIDE([PY Total Revenue], PY_All_Sales)</pre> |
