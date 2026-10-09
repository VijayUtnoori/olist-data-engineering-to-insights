# Silver Layer Data Cleaning & Transformation Documentation

---

## 1. `silver.olist_customers`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **All Columns** | Text fields contained extra double quotes (`"`). | Stripped out all double-quote characters across all string fields. |
| **`customer_unique_id`** | Multiple rows existed for the same unique customer across different orders, along with `NULL` records. | Filtered out `NULL` records and deduplicated the dataset to keep only the single latest customer record based on the most recent purchase date. |
| **`customer_city`** | Contained unnecessary leading or trailing spaces. | Trimmed extra whitespace around city names. |
| **`customer_state`** | Used 2-letter state abbreviations (e.g., `SP`, `RJ`). | Standardized state codes by converting them into full official state names (e.g., *Sao Paulo*, *Rio de Janeiro*). |

---

## 2. `silver.olist_geolocation`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **`geolocation_zip_code_prefix`** | Multiple duplicate entries existed for a single ZIP code prefix. | Deduplicated records by retaining only one entry per ZIP code prefix, ordered alphabetically by city name. |
| **`geolocation_lat` & `geolocation_lng`** | Stored as text; contained invalid values and coordinates falling outside Brazil's geographic boundaries. | Converted values to decimal format and filtered out invalid coordinates using Brazil’s spatial boundaries (Latitude: -33.75 to 5.25, Longitude: -73.98 to -34.79). |
| **`geolocation_city`** | Inconsistent text casing and special Portuguese accents (e.g., `á`, `ç`, `õ`). | Stripped all accents, normalized special characters to plain ASCII letters, and converted city names to lowercase for consistency. |
| **`geolocation_state`** | Used 2-letter state abbreviations. | Standardized state codes by converting them into full state names. |

---

## 3. `silver.olist_order_items`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **Key Columns** | `order_id`, `product_id`, and `seller_id` contained extra double quotes (`"`). | Stripped out all double-quote characters. |
| **`order_item_id`** | Stored as text data type instead of a numeric identifier. | Converted data type to integer. |
| **`shipping_limit_date`** | Stored as text, included microsecond precision, and contained dates where shipping occurred before the order was placed. | Converted to datetime (dropping microseconds) and filtered out invalid records where shipping limit date preceded order purchase time. |
| **`price` & `freight_value`** | Stored as text; contained non-positive or invalid monetary values. | Converted both columns to numeric decimals and filtered out non-positive values (enforced price > 0 and freight > 0). |

---

## 4. `silver.olist_order_payments`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **`order_id`** | Contained extra double quotes (`"`). | Stripped out double quotes. |
| **`payment_sequential` & `payment_installments`** | Stored as text data types. | Explicitly converted both columns to integer data types. |
| **`payment_type`** | Enclosed in quotes, used Portuguese terminology (`boleto`), and contained undefined categories (`not_defined`). | Normalized text to lowercase, replaced `boleto` with `bank_slip`, and mapped `not_defined` values to `unknown`. |
| **`payment_value`** | Stored as text data type. | Converted values to numeric decimal format. |

---

## 5. `silver.olist_order_reviews`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **`review_id`** | Contained double quotes and duplicate review records for the same review ID. | Stripped quotes and deduplicated records by retaining only the latest review based on the creation date. |
| **`order_id`** | Contained extra double quotes (`"`). | Stripped out double quotes. |
| **`review_score`** | Stored as text; contained non-positive or invalid ratings. | Converted to integer and filtered out scores less than or equal to 0. |
| **`review_creation_date` & `review_answer_timestamp`** | Stored as text data types; contained logical mismatches where the review answer preceded review creation. | Converted both columns to proper date/datetime types and filtered out impossible dates where creation occurred after the answer timestamp. |

---

## 6. `silver.olist_orders`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **`order_id` & `customer_id`** | Contained extra double quotes (`"`). | Stripped out double quotes. |
| **`order_status`** | Inconsistent casing and surrounding spaces. | Cleaned whitespace and converted all status strings to lowercase. |
| **All Milestone Timestamps** | Stored as text; contained `NULL` values; had chronological order errors (e.g., delivery date occurring before purchase date). | Converted all timestamp columns to datetime, removed records missing any milestone timestamp, and enforced a strict chronological order constraint: Purchase <= Approval <= Carrier Delivery <= Customer Delivery. |

---

## 7. `silver.olist_products`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **`product_id`** | Contained extra double quotes (`"`). | Stripped out double quotes. |
| **`product_category_name`** | Portuguese category names; contained `NULL` values; included redundant column `product_name_lenght`. | Dropped the redundant length column, joined with the translation dataset to map Portuguese categories to English, formatted text to lowercase without quotes, and filled `NULL`s as `unknown`. |
| **`product_description_lenght`** | Column name was misspelled (`lenght`), stored as text, and contained missing values. | Corrected the column spelling to `product_description_length`, converted to integer, and replaced missing (`NULL`) values with `0`. |
| **`product_photos_qty`** | Stored as text and contained `NULL` values. | Converted to integer and replaced missing values with `0`. |
| **Dimensions & Weight** (`weight_g`, `length_cm`, `height_cm`, `width_cm`) | Stored as text and contained `NULL` values. | Converted all four physical metrics to decimal format and replaced missing values with `0`. |

---

## 8. `silver.olist_sellers`

| Column | Issue Identified | How It Was Resolved |
| :--- | :--- | :--- |
| **`seller_id` & `seller_zip_code_prefix`** | Contained extra double quotes (`"`). | Stripped out double quotes. |
| **`seller_city`** | Inconsistent casing, Portuguese special accents, and double quotes. | Joined with the cleaned `geolocation` dataset by ZIP code prefix to pull standardized city names; fallback logic stripped quotes, removed accents, and lowercased the original city text. |
| **`seller_state`** | Used 2-letter state abbreviations. | Joined with geolocation dataset and mapped state abbreviations to full state names across all 23 states. |



