# Olist E-Commerce Data Platform
## Data Warehouse Naming Conventions & Governance Rules (Olist Dataset Standard)

---

### 1. General Architectural Principles

* **Naming Conventions:** Use strict `snake_case`, with lowercase letters and underscores (`_`) to separate words.
* **Language:** Use English for all object names, table names, and column names.
* **Avoid Reserved Words:** Do not use SQL reserved words (e.g., `order`, `user`, `date`, `group`, `select`) as object names.
* **Source Identifier:** The source system prefix for the Olist dataset is standardized as **`olist`**.

---

### 2. Table Naming Conventions

#### Bronze Rules
All table names must start with the source system name (`olist`), and table names must match their original entity names without re-indexing or re-naming.
* **Pattern:** `olist_<entity>`
* **Example:** `olist_customers` $\rightarrow$ Customer information from the Olist source dataset.

#### Silver Rules
All table names must start with the source system name (`olist`), and table names must match their original entity names without re-naming.
* **Pattern:** `olist_<entity>`
* **Example:** `olist_customers` $\rightarrow$ Cleansed and standardized customer information from the Olist source dataset.

#### Gold Rules
All table names must use meaningful, business-aligned names for tables, starting with the category prefix describing their architectural role.
* **Pattern:** `<category>_<entity>`
* **Category Prefixes:**
  * `dim_`: Dimension table (e.g., `dim_customers`, `dim_products`)
  * `fact_`: Fact table (e.g., `fact_orders`, `fact_order_items`)
  * `report_`: Business report / summary table (e.g., `report_monthly_sales`)

---

### 3. Layer-by-Layer Mapping for Olist Dataset

| Original Olist Dataset Entity | Bronze Layer (`olist_<entity>`) | Silver Layer (`olist_<entity>`) | Gold Layer (`<category>_<entity>`) |
| :--- | :--- | :--- | :--- |
| `olist_customers_dataset` | `olist_customers` | `olist_customers` | `dim_customers` |
| `olist_geolocation_dataset` | `olist_geolocation` | `olist_geolocation` | `dim_geolocation` |
| `olist_products_dataset` | `olist_products` | `olist_products` | `dim_products` |
| `olist_sellers_dataset` | `olist_sellers` | `olist_sellers` | `dim_sellers` |
| `product_category_name_translation` | `olist_product_category_translation` | `olist_product_category_translation` | `dim_product_categories` |
| `olist_orders_dataset` | `olist_orders` | `olist_orders` | `fact_orders` |
| `olist_order_items_dataset` | `olist_order_items` | `olist_order_items` | `fact_order_items` |
| `olist_order_payments_dataset` | `olist_order_payments` | `olist_order_payments` | `fact_order_payments` |
| `olist_order_reviews_dataset` | `olist_order_reviews` | `olist_order_reviews` | `fact_order_reviews` |
| *Aggregated Monthly Sales* | — | — | `report_monthly_sales` |

---

### 4. Column Naming Conventions

#### Surrogate Keys
All primary keys in Gold dimension tables must use the suffix `_key`.
* **Pattern:** `<table_name>_key`
* **Examples:**
  * `customer_key` $\rightarrow$ Primary key in `dim_customers`
  * `product_key` $\rightarrow$ Primary key in `dim_products`
  * `seller_key` $\rightarrow$ Primary key in `dim_sellers`

#### Technical Columns
All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's system purpose.
* **Pattern:** `dwh_<column_name>`
* **Examples:**
  * `dwh_load_date` $\rightarrow$ System-generated column storing the record ingestion timestamp.
  * `dwh_source_file` $\rightarrow$ System-generated column storing the origin file name.
  * `dwh_updated_at` $\rightarrow$ System-generated column storing the last modification timestamp.

#### Natural / Business Keys
Original operational IDs from the source system are retained with the `<entity>_id` pattern across Bronze, Silver, and as natural keys in Gold.
* **Examples:** `order_id`, `customer_id`, `product_id`, `seller_id`

---

### 5. Stored Procedures

All stored procedures used for loading data must follow the naming pattern `load_<layer>`.
* **Pattern:** `load_<layer>`
* **Examples:**
  * `load_bronze` $\rightarrow$ Stored procedure for ingesting raw data into the Bronze layer.
  * `load_silver` $\rightarrow$ Stored procedure for cleansing and loading data into the Silver layer.
  * `load_gold` $\rightarrow$ Stored procedure for orchestrating dimensional loads into the Gold layer.
