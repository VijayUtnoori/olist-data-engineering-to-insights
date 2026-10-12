# Gold Layer — Derived Columns Documentation

## 1. `gold.dim_customers`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `customer_sk` | `ROW_NUMBER() OVER (ORDER BY customer_id)` | Generates a sequential customer surrogate key. |
| `customer_lat` | `geolocation_lat` | Adds customer latitude from geolocation data. |
| `customer_lng` | `geolocation_lng` | Adds customer longitude from geolocation data. |
| `customer_region` | `CASE` based on `customer_state` | Groups customers into Brazil's geographic regions. |

## 2. `gold.dim_geolocation`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `geolocation_sk` | `ROW_NUMBER() OVER (ORDER BY geolocation_zip_code_prefix)` | Generates a sequential geolocation surrogate key. |
| `geolocation_region` | `CASE` based on `geolocation_state` | Groups locations into Brazil's geographic regions. |

## 3. `gold.dim_sellers`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `seller_sk` | `ROW_NUMBER() OVER (ORDER BY seller_id)` | Generates a sequential seller surrogate key. |
| `seller_lat` | `geolocation_lat` | Adds seller latitude from geolocation data. |
| `seller_lng` | `geolocation_lng` | Adds seller longitude from geolocation data. |
| `seller_region` | `CASE` based on `seller_state` | Groups sellers into Brazil's geographic regions. |

## 4. `gold.dim_products`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `product_sk` | `ROW_NUMBER() OVER (ORDER BY product_id)` | Generates a sequential product surrogate key. |
| `weight_kg` | `ROUND(product_weight_g / 1000.0, 2)` | Converts product weight from grams to kilograms. |
| `product_volume_cm` | `product_length_cm * product_height_cm * product_width_cm` | Calculates product volume in cubic centimetres (cm³). |
| `product_size_category` | `CASE` based on weight in kilograms | Classifies products as `Small`, `Medium`, `Large`, or `Bulky`. |
| Filter: `weight_kg > 0` | Retains products with positive calculated weight. | Excludes products with zero or negative weight. |

**Size classification rules:**

- `Bulky`: weight ≥ 30 kg
- `Large`: weight ≥ 10 kg and less than 30 kg
- `Medium`: weight ≥ 5 kg and less than 10 kg
- `Small`: weight less than 5 kg

## 5. `gold.fact_orders`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `order_sk` | `ROW_NUMBER() OVER (ORDER BY order_purchase_timestamp, order_id)` | Generates a sequential order surrogate key. |
| `purchased_at` | `order_purchase_timestamp` | Standardizes the purchase timestamp name. |
| `approved_at` | `order_approved_at` | Standardizes the approval timestamp name. |
| `shipped_at` | `order_delivered_carrier_date` | Represents the carrier handover timestamp. |
| `delivered_at` | `order_delivered_customer_date` | Represents the customer delivery timestamp. |
| `estimated_delivery_at` | `order_estimated_delivery_date` | Represents the estimated delivery date. |
| `order_delivered_days` | `DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date)` | Calculates elapsed days from purchase to delivery. |
| `delivery_variance_days` | `DATEDIFF(DAY, order_delivered_customer_date, order_estimated_delivery_date)` | Calculates the difference between actual and estimated delivery dates. Positive values indicate early delivery; negative values indicate late delivery. |
| `estimated_delivery_days` | `DATEDIFF(DAY, order_purchase_timestamp, order_estimated_delivery_date)` | Calculates the planned number of days from purchase to estimated delivery. |
| `approval_delay_hours` | `DATEDIFF(HOUR, order_purchase_timestamp, order_approved_at)` | Calculates elapsed hours from purchase to approval. |

## 6. `gold.fact_reviews`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `review_sk` | `ROW_NUMBER() OVER (ORDER BY review_id)` | Generates a sequential review surrogate key. |
| `created_at` | `review_creation_date` | Standardizes the review creation timestamp name. |
| `answered_at` | `review_answer_timestamp` | Standardizes the review response timestamp name. |
| `score_status` | `CASE` based on `review_score` | Classifies scores: 5 = `Excellent_score`; 3–4 = `Average_score`; other non-NULL scores = `Low_score`; NULL = `Unreviewed`. |
| `replay_days` | `DATEDIFF(DAY, review_creation_date, review_answer_timestamp)` | Calculates elapsed days between review creation and response. |

## 7. `gold.fact_payments`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `payment_sk` | `ROW_NUMBER() OVER (ORDER BY order_id, payment_sequential)` | Generates a sequential payment surrogate key. |
| `payment_status` | `CASE` based on `payment_value` | Classifies payment values into bands. |

**Payment value classification rules:**

- `High payment value`: payment value ≥ 1,000
- `Medium payment value`: payment value ≥ 500 and less than 1,000
- `Low payment value`: payment value less than 500

## 8. `gold.fact_order_items`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `order_item_sk` | `ROW_NUMBER() OVER (ORDER BY shipping_limit_date, order_id, order_item_id)` | Generates a sequential order-item surrogate key. |
| `shipping_limit_date_key` | `CAST(FORMAT(shipping_limit_date, 'yyyyMMdd') AS INT)` | Converts the shipping deadline into an integer date key in `YYYYMMDD` format. |
| `total_item_value` | `price + freight_value` | Calculates item price plus freight charge. |
| `freight_ratio_pct` | `ROUND((freight_value / NULLIF(price, 0)) * 100, 2)` | Calculates freight as a percentage of item price. |
| `is_high_freight` | `CASE WHEN freight_value / NULLIF(price, 0) >= 0.30 THEN 1 ELSE 0 END` | Flags items where freight is at least 30% of the item price. `1` = high freight; `0` = not high freight. |

## 9. `gold.dim_date`

| Derived Column | Logic / Formula | Purpose |
|---|---|---|
| `date_key` | `YEAR(full_date) * 10000 + MONTH(full_date) * 100 + DAY(full_date)` | Creates an integer date key in `YYYYMMDD` format. |
| `calendar_year` | `YEAR(full_date)` | Extracts the calendar year. |
| `calendar_month` | `MONTH(full_date)` | Extracts the month number. |
| `month_name` | `DATENAME(MONTH, full_date)` | Extracts the month name. |
| `calendar_quarter` | `DATEPART(QUARTER, full_date)` | Extracts the calendar quarter. |
| `day_of_month` | `DAY(full_date)` | Extracts the day of the month. |
| `day_name` | `DATENAME(WEEKDAY, full_date)` | Extracts the weekday name. |
| `is_weekend` | `CASE WHEN DATENAME(WEEKDAY, full_date) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END` | Flags weekends as `1` and weekdays as `0`. |

**Date range:** 2016-01-01 to 2018-12-31.

---

## Important Notes

- Surrogate keys generated with `ROW_NUMBER()` are recalculated when the view runs; they are not persistent keys.
- `delivery_variance_days` uses estimated date minus actual delivery date, so **positive = early and negative = late**.
- `product_volume_cm` represents cubic centimetres (cm³), not centimetres.
- `total_item_value` is item price plus freight; it is not the complete order total.
- `is_high_freight` uses a threshold of 30% of item price.
- The Haversine `distance_km` calculation belongs to `gold.vw_order_item_logistics`, which is separate from the views defined in this SQL script.
