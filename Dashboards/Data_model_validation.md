# Power BI Data Model Validation & Data Quality Report

## 1. Project Overview

**Dataset:** Brazilian E-Commerce Public Dataset by Olist  
**Tools:** SQL Server, Power Query, Power BI, DAX  
**Architecture:** Multi-fact dimensional model (fact constellation)  
**Validation focus:** Relationships, filter propagation, aggregation accuracy, data preservation and data quality.

### Business Problem

How do logistics friction points, including delivery delays, freight costs and seller-to-customer distances, impact customer satisfaction (`review_score`) across different product categories and geographic regions?

The objective of this validation was to ensure that the Power BI semantic model produces reliable analytical results without losing records or introducing incorrect aggregations.

---

## 2. Data Model Overview

The model contains the following tables.

### Dimension tables
- `dim_customers`
- `dim_sellers`
- `dim_products`
- `dim_date`
- `dim_orders`

### Fact tables
- `fact_orders`
- `fact_order_items`
- `fact_payments`
- `fact_reviews`

### Bridge table
- `bridge_order_products`

The `bridge_order_products` table connects orders and products through their distinct combinations of `order_id` and `product_id`.

### Main relationship paths

- `dim_customers` → `dim_orders`
- `dim_date` → `dim_orders`
- `dim_orders` → `fact_orders`
- `dim_orders` → `fact_order_items`
- `dim_orders` → `fact_payments`
- `dim_orders` → `fact_reviews`
- `dim_products` → `fact_order_items`
- `dim_sellers` → `fact_order_items`
- `dim_products` → `bridge_order_products`
- `dim_orders` → `bridge_order_products`

The model uses shared dimensions to connect multiple fact tables rather than directly connecting fact tables.

---

## 3. Grain and Record Count Validation

A critical part of dimensional modelling is understanding the grain of each table.

| Table | Grain | Records |
|---|---|---:|
| `dim_customers` | One row per customer record | 96,096 |
| `dim_sellers` | One row per seller | 3,093 |
| `dim_products` | One row per product | 32,940 |
| `dim_date` | One row per calendar date | 1,096 |
| `dim_orders` | One row per order | 98,036 |
| `fact_orders` | One row per order | 98,036 |
| `fact_order_items` | One row per order item | 111,025 |
| `fact_payments` | One row per payment record | 103,886 |
| `fact_reviews` | One row per review | 98,410 |
| `bridge_order_products` | One row per distinct order-product combination | 100,932 |

### Key validations

- `fact_orders`: 98,036 unique order IDs.
- `fact_order_items`: 111,025 unique `(order_id, order_item_id)` combinations.
- `fact_payments`: 103,886 unique `(order_id, payment_sequential)` combinations.
- `fact_reviews`: 98,410 unique review IDs.
- `dim_products`: 32,940 unique product IDs.
- `dim_sellers`: 3,093 unique seller IDs.
- `dim_date`: 1,096 unique date keys.

The order-item table contains 111,025 records but only 97,261 distinct orders. This confirms that one order can contain multiple purchased items.

---

## 4. Power BI Filter Propagation Validation

The purpose was to confirm that dimension filters correctly affect the intended fact tables.

| Test | Result | Status |
|---|---|---|
| Product category → order items | Sales and item counts changed by category | Passed |
| Product category → reviews | Review scores changed by category using DAX | Passed |
| Product category → delivery days | Delivery averages changed by category using DAX | Passed |
| Customer region → payments | Payment values changed by region | Passed |
| Seller region → order items | Sales, freight and item counts changed by region | Passed |
| Order status → delivery measures | Delivery averages responded to order status | Passed |
| Order status → review measures | Review scores and review counts responded to order status | Passed |

### Important filter-propagation finding

Product-category filters did not directly propagate from `dim_products` to `fact_orders` or `fact_reviews` through the original single-direction relationships.

We addressed the analytical requirement using `TREATAS`.

Example:

```DAX
Average Delivery Days by Category =
CALCULATE(
    AVERAGE(fact_orders[order_delivered_days]),
    TREATAS(
        VALUES(bridge_order_products[order_id]),
        fact_orders[order_id]
    )
)
```

This transfers the selected order IDs to the order-level fact table.

**Analytical limitation:** An order containing multiple product categories contributes its delivery duration to each associated category. Category-level delivery averages therefore overlap.

---

## 5. Sales, Freight and Payment Validation

### Sales and freight

| Measure | Power BI result |
|---|---:|
| Total product sales | 1,34,11,726.58 |
| Total item value | 1,56,30,505.12 |
| Total freight | 22,18,778.54 |

The following reconciliation was successful:

Product sales + freight = Total item value.

1,34,11,726.58 + 22,18,778.54 = 1,56,30,505.12

### Freight aggregation

Average freight per order: 22.81

Total freight calculated using order-level iteration: 22,18,778.54

The iterated total matched the original freight total.

### Payment validation

| Measure | Result |
|---|---:|
| Total payment records | 103,886 |
| Total payment value | 1,60,08,872.12 |

The payment record count matched SQL Server.

Payment value did not equal product sales plus freight. The difference was 3,78,367.00 and was not fully reconciled during this validation.

These measures should not be treated as interchangeable.

---

## 6. Major Data Quality Investigation: Missing Seller Distance

### Initial finding

In Power BI, the following results were observed:

| Metric | Initial result |
|---|---:|
| Average seller distance | 597.86 km |
| Maximum seller distance | 3,577.80 km |
| Missing distance records | 4,506 |

The distance was originally calculated in a separate SQL logistics view and then merged into `fact_order_items` using Power Query.

### Root cause

The original SQL view used:

- INNER JOINs between orders, customers, sellers and order items.
- WHERE conditions requiring all four coordinates to be non-null.
- Geographic validity restrictions on latitude and longitude.

These conditions excluded order-item records when matching customer or seller information was unavailable.

### Original join problem

```sql
INNER JOIN gold.dim_customers c
    ON o.customer_id = c.customer_id

INNER JOIN gold.dim_sellers s
    ON oi.seller_id = s.seller_id
```

The coordinate restrictions also required:

```sql
c.customer_lat IS NOT NULL
AND c.customer_lng IS NOT NULL
AND s.seller_lat IS NOT NULL
AND s.seller_lng IS NOT NULL
```

Consequently, order-item records without matching dimension records or valid coordinates were excluded from the view.

### Diagnostic results

A complete diagnostic query was executed using LEFT JOINs to classify all 111,025 original order-item records.

| Diagnostic category | Order-item records |
|---|---:|
| Missing order | 0 |
| Missing customer record | 3,980 |
| Missing seller record | 3 |
| Missing customer coordinates | 287 |
| Missing seller coordinates | 236 |
| Invalid coordinates | 0 |
| Valid distance available | 106,519 |
| **Total** | **111,025** |

The categories were mutually exclusive in the diagnostic query.

Additional customer investigation found:
- Customer dimension records: 96,096.
- Distinct customer IDs in dimension: 96,096.
- Distinct customer IDs in orders: 98,036.
- Distinct unmatched customer IDs: 3,319.

The missing customer mappings were an important contributor to the distance issue.

---

## 7. SQL Correction Implemented

The original logistics view was modified.

### Changes made

1. Replaced INNER JOINs with LEFT JOINs.
2. Removed coordinate availability restrictions from the WHERE clause.
3. Moved geographic coordinate validation inside the CASE expression used for distance calculation.
4. Preserved every original order-item record.
5. Returned NULL when distance could not be calculated.

### New distance calculation logic

```sql
CASE
    WHEN c.customer_lat BETWEEN -90 AND 90
     AND c.customer_lng BETWEEN -180 AND 180
     AND s.seller_lat BETWEEN -90 AND 90
     AND s.seller_lng BETWEEN -180 AND 180
    THEN
        2 * 6371.0 * ASIN(
            SQRT(
                CASE
                    WHEN h.a > 1 THEN 1.0
                    WHEN h.a < 0 THEN 0.0
                    ELSE h.a
                END
            )
        )
    ELSE NULL
END AS distance_km
```

### Why NULL instead of zero?

Zero kilometres represents an actual distance of zero. It must not be used to represent missing coordinates or unavailable distance calculations.

NULL correctly represents an unknown or unavailable distance.

---

## 8. SQL Server and Power BI Reconciliation

After modifying the SQL view, we performed another merge validation in Power Query.

### Before correction

| Metric | Records |
|---|---:|
| Original order items | 111,025 |
| Matching records | 106,519 |
| Unmatched records | 4,506 |

### After correction

| Metric | Records |
|---|---:|
| Original order items | 111,025 |
| Matching records | 111,025 |
| Unmatched records | 0 |

The merge was performed using a Left Outer join on:

- `order_id`
- `order_item_id`

The composite key was unique in the logistics view.

### Final Power BI distance validation

| Measure | SQL Server | Power BI |
|---|---:|---:|
| Total order items | 111,025 | 111,025 |
| Valid distances | 106,519 | 106,519 |
| Missing distances | 4,506 | 4,506 |

**Result:** SQL Server and Power BI reconciled successfully.

All original order-item records were preserved.

---

## 9. Order Delivery and Review Validation

We created a table using `dim_orders[order_status]` and the following measures:

- Total Orders
- Average Delivery Days
- Average Review Score
- Total Review Records

### Observed results

| Order status | Total orders | Average delivery days | Average review score | Review records |
|---|---:|---:|---:|---:|
| Approved | 2 | Blank | 2.50 | 2 |
| Canceled | 625 | 20.33 | 1.75 | 573 |
| Created | 5 | Blank | 2.33 | 3 |
| Delivered | 95,082 | 12.56 | 4.16 | 94,216 |
| Invoiced | 314 | Blank | 1.64 | 311 |
| Processing | 301 | Blank | 1.26 | 295 |
| Shipped | 1,098 | Blank | 2.01 | 1,026 |
| Unavailable | 609 | Blank | 1.51 | 589 |
| Unmatched order status | — | Blank | 4.29 | 1,395 |
| **Total** | **98,036** | **12.56** | **4.09** | **98,410** |

### Review and order matching issue

There are 1,395 review records without a matching order in the current order dimension.

These records remain in the review fact table and appear under a blank order-status member.

They should not be deleted simply to remove the blank row.

### Six canceled orders with delivery dates

A separate investigation identified six canceled orders with non-null delivered timestamps.

Their calculated delivery durations were:

7, 36, 31, 30, 7 and 11 days.

Their average was:

20.33 days.

This explains the canceled-order delivery average.

The records have conflicting status and timestamp information. We did not change their source status or delete them.

### Correct delivery KPI

For delivery performance reporting, use delivered orders only:

```DAX
Average Delivered Days =
CALCULATE(
    AVERAGE(fact_orders[order_delivered_days]),
    KEEPFILTERS(
        dim_orders[order_status] = "delivered"
    )
)
```

The delivered-order average observed in the table was 12.56 days.

The KPI should be explicitly labelled as the average delivery duration for delivered orders.

---

## 10. Other Data Quality Observations

### A. Seller region missing

The seller-region analysis showed:

- 3 order items in the blank seller-region category.
- Product sales: 856.44.
- Freight: 923.19.

These records should remain in the model until their seller mapping is investigated.

### B. Customer region missing

The payment-by-region table contained a blank region category:

- Payment records: 4,956.
- Payment value: 7,15,042.05.

The customer-region mapping needs further investigation.

### C. Missing seller distance

4,506 order items (approximately 4.06%) have unavailable distance values.

This limitation must be disclosed in any analysis involving seller-to-customer distance.

### D. Payment reconciliation

The difference between payment value and total item value was not fully explained.

This requires a separate reconciliation of order coverage, payment records and business definitions.

---

## 11. Final Validation Summary

| Validation area | Status |
|---|---|
| Dimension key uniqueness | Passed |
| Fact table grain checks | Passed |
| Order-item composite key | Passed |
| Product category filtering | Passed |
| Seller region filtering | Passed |
| Customer region payment filtering | Passed |
| Order status filtering | Passed |
| Sales and freight reconciliation | Passed |
| Payment record count | Passed |
| Distance merge row preservation | Passed |
| SQL Server to Power BI distance reconciliation | Passed |
| Review and order unmatched records | Documented |
| Six canceled orders with delivery timestamps | Documented |
| Payment value reconciliation | Pending |
| Missing distance recovery | Pending |
| Blank customer and seller regions | Pending |

---

## 12. Conclusion

The validation process identified and corrected a significant data-preservation issue in the logistics view.

The original SQL implementation excluded 4,506 order-item records because of INNER JOINs and coordinate availability restrictions.

By changing to LEFT JOINs and applying coordinate validation within the distance calculation, we preserved all 111,025 order-item records.

The corrected SQL view and Power BI results reconciled exactly:

- 111,025 total order items.
- 106,519 valid distances.
- 4,506 unavailable distances.
- Zero unmatched order-item keys after the correction.

We also identified six canceled orders with delivery timestamps, 1,395 reviews without matching order records, and other regional and payment data-quality issues.

**Overall assessment:** The model has passed several important structural, aggregation and filter-propagation checks. It is not yet fully certified for final business reporting because the outstanding data-quality and payment-reconciliation issues still require investigation.

The key lesson from this validation was that a successful relationship or merge does not automatically guarantee accurate business analysis. Grain, filter propagation, data completeness and business definitions must all be validated independently.
