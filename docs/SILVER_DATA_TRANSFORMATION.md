# Silver Layer Data Cleaning & Transformation Documentation

The Silver layer contains cleaned, standardized, and validated data transformed from the Bronze layer. The main objective is to improve data quality, maintain consistency, handle missing values, and prepare the data for Gold-layer analytics.

---

## 1. `silver.olist_customers`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| All string columns | Extra double quotes (`"`) in text fields. | Removed unnecessary double-quote characters. |
| `customer_unique_id` | Missing values and multiple records associated with the same unique customer. | Filtered out NULL identifiers and retained the latest customer record based on the most recent purchase date. |
| `customer_city` | Leading and trailing whitespace. | Trimmed unnecessary whitespace. |
| `customer_state` | State abbreviations such as `SP` and `RJ`. | Standardized state codes into full state names, such as `Sao Paulo` and `Rio de Janeiro`. |

---

## 2. `silver.olist_geolocation`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `geolocation_zip_code_prefix` | Multiple records for the same ZIP-code prefix. | Deduplicated records, retaining one representative record per ZIP prefix using alphabetical city ordering. |
| `geolocation_lat`, `geolocation_lng` | Text data types, invalid values, and coordinates outside the selected geographic boundaries. | Converted coordinates to decimal types and filtered invalid coordinates using the configured Brazil bounds: latitude `-33.75` to `5.25`, longitude `-73.98` to `-34.79`. |
| `geolocation_city` | Inconsistent casing and Portuguese accents. | Removed accents, normalized text to ASCII characters, and converted city names to lowercase. |
| `geolocation_state` | Two-letter state abbreviations. | Standardized state codes into full state names. |

---

## 3. `silver.olist_order_items`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `order_id`, `product_id`, `seller_id` | Extra double quotes in identifier columns. | Removed unnecessary double-quote characters. |
| `order_item_id` | Stored as text. | Converted to integer. |
| `shipping_limit_date` | Text format, fractional-second precision, and invalid shipping deadlines preceding the order purchase timestamp. | Converted to a datetime type with the configured precision and filtered records where the shipping limit preceded the purchase timestamp. |
| `price`, `freight_value` | Text data types, invalid values, and non-positive monetary amounts. | Converted to decimal types and filtered records where `price <= 0` or `freight_value <= 0`. |

---

## 4. `silver.olist_order_payments`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `order_id` | Extra double quotes. | Removed unnecessary double-quote characters. |
| `payment_sequential`, `payment_installments` | Stored as text. | Converted to integer types. |
| `payment_type` | Inconsistent casing, Portuguese terminology (`boleto`), and undefined categories (`not_defined`). | Normalized text to lowercase, replaced `boleto` with `bank_slip`, and mapped `not_defined` to `unknown`. |
| `payment_value` | Stored as text. | Converted to a decimal type. |

---

## 5. `silver.olist_order_reviews`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `review_id` | Extra double quotes and duplicate records for the same review identifier. | Removed unnecessary quotes and deduplicated records, retaining the latest record based on the review creation date. |
| `order_id` | Extra double quotes. | Removed unnecessary double-quote characters. |
| `review_score` | Text data type and invalid ratings. | Converted to integer and filtered out scores less than or equal to zero. |
| `review_comment_title` | Missing review titles (`NULL` values). | Replaced missing titles with `No Title` so that missing titles are explicitly identified. |
| `review_comment_message` | Missing review messages (`NULL` values). | Replaced missing messages with `Not Commented` so that missing comments are explicitly identified. |
| `review_creation_date`, `review_answer_timestamp` | Text data types and invalid date sequences. | Converted to appropriate date/datetime types and filtered records where the review creation date occurred after the answer timestamp. |

**Note:** `No Title` and `Not Commented` are placeholders for missing information; they do not represent actual customer feedback.

---

## 6. `silver.olist_orders`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `order_id`, `customer_id` | Extra double quotes. | Removed unnecessary double-quote characters. |
| `order_status` | Inconsistent casing and surrounding whitespace. | Trimmed whitespace and converted status values to lowercase. |
| Order milestone timestamps | Text data types, missing timestamps, and invalid chronological sequences. | Converted timestamps to datetime types, removed records missing required milestone timestamps, and enforced the chronological sequence: purchase → approval → carrier delivery → customer delivery. |
| `order_estimated_delivery_date` | Required date-only representation for the estimated delivery date. | Converted to the `DATE` data type. |

**Note:** Filtering orders with missing milestone timestamps excludes incomplete orders and may affect analyses of cancelled orders and delivery performance.

---

## 7. `silver.olist_products`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `product_id` | Extra double quotes. | Removed unnecessary double-quote characters. |
| `product_category_name` | Portuguese category names, missing values, and redundant name-length field. | Standardized category names using the English translation dataset, normalized text, mapped missing categories to `unknown`, and removed the redundant `product_name_lenght` column. |
| `product_description_length` | Misspelled source column name and missing values. | Corrected the column name from `product_description_lenght`, converted it to integer, and replaced missing values with `0`. |
| `product_photos_qty` | Text data type and missing values. | Converted to integer and replaced missing values with `0`. |
| `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm` | Text data types and missing measurements. | Converted to numeric types and replaced missing values with `0`. |

**Note:** Zero-filled measurements indicate missing source values, not necessarily actual zero-weight or zero-sized products.

---

## 8. `silver.olist_sellers`

| Column | Issue Identified | How It Was Resolved |
|---|---|---|
| `seller_id`, `seller_zip_code_prefix` | Extra double quotes. | Removed unnecessary double-quote characters. |
| `seller_city` | Inconsistent casing, Portuguese accents, and extra quotes. | Used cleaned geolocation data joined by ZIP-code prefix to standardize city names, with fallback text normalization where required. |
| `seller_state` | Two-letter state abbreviations. | Standardized state codes into full state names using the configured state-mapping logic. |

---

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
