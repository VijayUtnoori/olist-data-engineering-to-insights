# Power BI Data Model – Validation Summary

## 1. Current Model Relationships

The model uses a multi-fact dimensional architecture with shared dimensions.

### Active relationships

| One side | Many side | Relationship |
|---|---|---|
| `dim_customers` | `dim_orders` | 1:* |
| `dim_date` | `dim_orders` | 1:* |
| `dim_orders` | `fact_orders` | 1:1 |
| `dim_orders` | `fact_order_items` | 1:* |
| `dim_orders` | `fact_payments` | 1:* |
| `dim_orders` | `fact_reviews` | 1:* |
| `dim_products` | `fact_order_items` | 1:* |
| `dim_sellers` | `fact_order_items` | 1:* |
| `dim_products` | `bridge_order_products` | 1:* |
| `dim_orders` | `bridge_order_products` | 1:* |

### Relationships requiring DAX

With the current single-direction filter paths, product-category filters cannot directly propagate from `dim_products` to `fact_orders` or `fact_reviews`.

Therefore, we used DAX `TREATAS` to transfer selected order IDs through `bridge_order_products`.

This was required for:
- Average delivery days by product category.
- Average review score by product category.

**Direct filtering that works through relationships:**
- Product category → order items.
- Seller region → order items.
- Customer region → orders and payments.
- Order status → delivery and reviews.
- Date → orders and connected fact tables.

## 2. What We Found

- The original logistics view excluded 4,506 order items because of INNER JOINs and coordinate restrictions.
- 3,980 order-item records had no matching customer record.
- 3 order-item records had no matching seller record.
- 523 records had missing customer or seller coordinates.
- 1,395 reviews had no matching order.
- 6 canceled orders contained delivery timestamps.
- Some customer and seller records had missing regional information.

## 3. What We Fixed

- Added `bridge_order_products` to support product-to-order analysis.
- Used DAX `TREATAS` where normal relationships could not propagate product filters.
- Changed the logistics view from INNER JOINs to LEFT JOINs.
- Moved coordinate validation into the distance calculation.
- Preserved all order-item records.
- Kept unavailable distances as NULL instead of zero.
- Used delivered orders for delivery-duration reporting.

## 4. Final Validation Results

| Validation | Result |
|---|---:|
| Total order items | 111,025 |
| Valid distance records | 106,519 |
| Missing distance records | 4,506 |
| Unmatched order-item keys after correction | 0 |
| Average delivered-order duration | 12.56 days |
| Total review records | 98,410 |
| Total orders | 98,036 |
| Total payment records | 103,886 |

SQL Server and Power BI distance counts reconciled successfully.

## 5. Remaining Data Quality Issues

- 4,506 order items have unavailable distances.
- 1,395 reviews have no matching order.
- 6 canceled orders contain delivery timestamps.
- Missing customer and seller regional information needs investigation.
- Payment value reconciliation remains pending.

## 6. Conclusion

The model successfully passed several structural, aggregation and filter-propagation tests.

The logistics view was corrected to preserve all 111,025 order-item records.

DAX `TREATAS` was necessary for product-category analysis of order-level delivery performance and customer reviews because the existing single-direction relationships did not provide those filter paths.

SQL Server and Power BI results reconciled successfully. Remaining data-quality issues have been documented for further investigation.
