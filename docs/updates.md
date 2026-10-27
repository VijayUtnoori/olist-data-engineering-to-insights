## Gold Layer — Summary

### 1. `fact_orders`
- Updated Silver order-cleaning logic to preserve valid orders with missing lifecycle timestamps.
- Excluded chronologically invalid orders and delivered orders missing required timestamps.
- Validated Silver-to-Gold consistency: **98,036 orders**, with zero missing orders between layers.

### 2. `fact_order_items`
- Joined order items with valid Gold orders using `INNER JOIN`.
- Added a surrogate key and calculated total item value, freight ratio, and high-freight flag.
- Validated uniqueness of `(order_id, order_item_id)`.

### 3. `vw_order_item_logistics`
- Added `order_item_id` and calculated seller-to-customer distance using the Haversine formula.
- Excluded missing or invalid coordinates.
- Final result: **110,475 rows, zero duplicate order-item combinations**.
