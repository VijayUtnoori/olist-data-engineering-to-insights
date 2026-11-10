# Silver Layer Data Cleaning & Transformation Documentation

The Silver layer contains cleaned, standardized, and validated data transformed from the Bronze layer. The main objective is to improve data quality, maintain consistency, handle missing values, and prepare the data for Gold-layer analytics.

## 1. Customers (`silver.olist_customers`)

- Removed quotation marks and trimmed whitespace from customer IDs.
- Standardized customer city names and state abbreviations.
- Validated `customer_id` as NOT NULL and unique.
- Allowed duplicate `customer_unique_id` values because one unique customer can have multiple customer IDs.
- **Grain:** One row per `customer_id`.

## 2. Geolocation (`silver.olist_geolocation`)

- Converted ZIP prefixes and latitude/longitude into appropriate numeric data types.
- Standardized city names by removing accents and converting to lowercase.
- Standardized Brazilian state abbreviations into full state names.
- Removed invalid geographic coordinates.
- Aggregated latitude and longitude using `AVG()` for each ZIP prefix.
- Validated ZIP prefix uniqueness, missing coordinates and Bronze-to-Silver coordinate reconciliation.
- **Grain:** One row per ZIP prefix.
- **Final records:** 19,010.

## 3. Sellers (`silver.olist_sellers`)

- Removed quotation marks and trimmed seller IDs and ZIP prefixes.
- Standardized seller city names using the geolocation table.
- Used the original seller city as a fallback when geolocation data was unavailable.
- Converted Brazilian state abbreviations into full state names.
- Validated seller ID uniqueness and ZIP-prefix relationships.
- **Grain:** One row per `seller_id`.

## 4. Products (`silver.olist_products`)

- Cleaned product IDs and converted numeric attributes into appropriate data types.
- Translated Portuguese product categories into English using the category translation table.
- Used the original category as a fallback when English translation was unavailable.
- Handled missing numeric attributes without automatically replacing NULL values with zero.
- Validated product ID uniqueness and category translation table uniqueness.
- **Grain:** One row per `product_id`.

## 5. Orders (`silver.olist_orders`)

- Cleaned order IDs and customer IDs.
- Standardized order status into lowercase.
- Converted order timestamps into `DATETIME2` and estimated delivery dates into `DATE`.
- Applied mandatory field validation:
  - `order_id` must not be NULL or empty.
  - `order_purchase_timestamp` must not be NULL.
  - `order_delivered_customer_date` must not be NULL.
- Applied chronological validation:
  - Purchase must not occur after approval.
  - Approval must not occur after carrier handoff, when both exist.
  - Carrier handoff must not occur after customer delivery, when both exist.
- Preserved NULL approval and carrier timestamps.
- Separated invalid records into `silver.olist_orders_rejected`, including rejection reasons.
- **Grain:** One row per `order_id`.
- **Expected valid records:** 95,103.
- **Rejected records:** 4,338.

## 6. Order Items (`silver.olist_order_items`)

- Cleaned order, product and seller IDs.
- Converted item IDs into integers and monetary values into decimal data types.
- Validated relationships with Silver Orders, Products and Sellers.
- Applied data-quality rules:
  - Mandatory order, item, product and seller IDs.
  - Price must be greater than zero.
  - Freight value must be zero or greater.
  - Shipping limit date must not be NULL.
  - Shipping limit date must not precede purchase timestamp.
- Separated invalid records into `silver.olist_order_items_rejected`.
- Preserved rejection reasons for future investigation.
- **Grain:** One row per `(order_id, order_item_id)`.
- **Bronze records:** 112,650.
- **Rejected item records:** 4,049.
- **Expected valid item records:** 108,601.

## 7. Rejected Data Summary

| Rejected table | Records |
|---|---:|
| `silver.olist_orders_rejected` | 4,338 |
| `silver.olist_order_items_rejected` | 4,049 |

### Rejected Order Items – Financial Summary

| Metric | Amount (BRL) |
|---|---:|
| Rejected item price | 546,802.11 |
| Rejected freight | 86,266.78 |
| Total rejected value | 633,068.89 |

*Rejected monetary value represents the value associated with excluded records, not necessarily lost revenue.*

## 8. Silver Layer Completion

- Bronze layer preserved without modification.
- Silver tables cleaned, standardized and validated.
- Table grains and key uniqueness checked.
- Referential integrity investigated.
- Rejected records preserved separately with rejection reasons.
- Original source records retained for auditability.

**Next Phase:** Gold Layer – Dimensional Modeling, Fact Tables, Dimension Tables and Business-Ready Data for Power BI.


## Summary

The Silver layer transformations focus on:

- Removing unnecessary quotes and whitespace.
- Standardizing text, city names, state names, and payment categories.
- Converting columns to appropriate data types.
- Handling missing values in review comments and product attributes.
- Removing duplicates and invalid records.
- Validating timestamps and chronological sequences.
- Preparing consistent data for the Gold-layer dimensions, facts, and business analysis.

**Data quality consideration:** All filtering rules and placeholder values should be documented because they can influence downstream analysis, especially customer satisfaction, delivery performance, and product-level metrics.
