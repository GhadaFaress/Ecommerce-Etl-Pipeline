# Complete ERD Diagram - E-Commerce ETL Pipeline

## Full Data Flow: Raw → Staging → Analytics

```mermaid
erDiagram
    %% RAW LAYER
    RAW_CUSTOMERS ||--o{ RAW_ORDERS : "places"
    RAW_ORDERS ||--|{ RAW_ORDER_ITEMS : "contains"
    RAW_ORDERS ||--o{ RAW_PAYMENTS : "paid_by"
    RAW_ORDERS ||--o{ RAW_REVIEWS : "reviewed_in"
    RAW_PRODUCTS ||--o{ RAW_ORDER_ITEMS : "ordered_as"
    RAW_SELLERS ||--o{ RAW_ORDER_ITEMS : "sold_by"

    %% STAGING TO ANALYTICS
    RAW_CUSTOMERS ||--|| STG_CUSTOMERS : transforms
    STG_CUSTOMERS ||--|| DIM_CUSTOMERS : loads
    
    RAW_PRODUCTS ||--|| STG_PRODUCTS : transforms
    STG_PRODUCTS ||--|| DIM_PRODUCTS : loads
    
    RAW_SELLERS ||--|| STG_SELLERS : transforms
    STG_SELLERS ||--|| DIM_SELLERS : loads
    
    RAW_ORDERS ||--|| STG_ORDERS : transforms
    STG_ORDERS ||--|| FACT_ORDERS : loads
    
    RAW_ORDER_ITEMS ||--|| STG_ORDER_ITEMS : transforms
    STG_ORDER_ITEMS ||--|| FACT_ORDER_ITEMS : loads

    %% ANALYTICS RELATIONSHIPS
    FACT_ORDERS ||--|| DIM_CUSTOMERS : "customer_id"
    FACT_ORDER_ITEMS }|--|| FACT_ORDERS : "order_id"
    FACT_ORDER_ITEMS ||--|| DIM_CUSTOMERS : "customer_id"
    FACT_ORDER_ITEMS ||--|| DIM_PRODUCTS : "product_id"
    FACT_ORDER_ITEMS ||--|| DIM_SELLERS : "seller_id"

    %% RAW TABLES (Source)
    RAW_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string customer_zip_code_prefix
        string customer_city
        string customer_state
    }

    RAW_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        timestamp order_purchase_timestamp
        timestamp order_approved_at
        timestamp order_delivered_carrier_date
        timestamp order_delivered_customer_date
        timestamp order_estimated_delivery_date
    }

    RAW_ORDER_ITEMS {
        string order_id FK
        int order_item_id
        string product_id FK
        string seller_id FK
        timestamp shipping_limit_date
        decimal price
        decimal freight_value
    }

    RAW_PRODUCTS {
        string product_id PK
        string product_category_name
        int product_name_length
        int product_description_length
        int product_photos_qty
        float product_weight_g
        float product_length_cm
        float product_height_cm
        float product_width_cm
    }

    RAW_SELLERS {
        string seller_id PK
        string seller_zip_code_prefix
        string seller_city
        string seller_state
    }

    RAW_PAYMENTS {
        string order_id FK
        int payment_sequential
        string payment_type
        int payment_installments
        decimal payment_value
    }

    RAW_REVIEWS {
        string review_id PK
        string order_id FK
        int review_score
        string review_comment_title
        string review_comment_message
        timestamp review_creation_date
        timestamp review_answer_timestamp
    }

    %% STAGING TABLES
    STG_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string zip_code
        string city
        string state
    }

    STG_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        timestamp purchase_timestamp
        int days_to_deliver
        int delivery_vs_estimate_days
    }

    STG_ORDER_ITEMS {
        string order_id FK
        int order_item_id
        string product_id FK
        string seller_id FK
        decimal price
        decimal freight_value
        decimal total_item_value
    }

    STG_PRODUCTS {
        string product_id PK
        string category_name
        float weight_grams
        float volume_cm3
    }

    STG_SELLERS {
        string seller_id PK
        string zip_code
        string city
        string state
    }

    %% ANALYTICS TABLES (Final)
    DIM_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string zip_code
        string city
        string state
        timestamp last_updated_at
    }

    DIM_PRODUCTS {
        string product_id PK
        string category_name
        int name_length
        int description_length
        int photos_count
        float weight_grams
        float volume_cm3
        timestamp last_updated_at
    }

    DIM_SELLERS {
        string seller_id PK
        string zip_code
        string city
        string state
        timestamp last_updated_at
    }

    FACT_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        timestamp purchase_timestamp
        int days_to_deliver
        string delivery_performance
        int item_count
        decimal total_order_value
        date purchase_date
        int purchase_year
        int purchase_month
        timestamp last_updated_at
    }

    FACT_ORDER_ITEMS {
        string order_id PK_FK
        int order_item_id PK
        string customer_id FK
        string product_id FK
        string seller_id FK
        decimal price
        decimal freight_value
        decimal total_item_value
        timestamp last_updated_at
    }
```

## Data Pipeline Layers

### 1. **RAW Layer** (PostgreSQL/Snowflake Raw Schema)
- 7 source tables loaded from CSV files
- No transformations, original data structure preserved
- Source: Olist Brazilian E-Commerce Dataset

### 2. **STAGING Layer** (dbt Staging Models)
- 5 staging models with data cleansing
- Column renaming and standardization
- Data quality tests (unique, not_null, relationships)
- Basic calculated fields

### 3. **ANALYTICS Layer** (dbt Marts - Star Schema)
- 3 Dimension tables (SCD Type 1)
- 2 Fact tables (transaction grain)
- Business logic and metrics
- Optimized for analytical queries

## Key Relationships

| From Table | To Table | Relationship | Cardinality |
|------------|----------|--------------|-------------|
| dim_customers | fact_orders | customer_id | 1:N |
| dim_customers | fact_order_items | customer_id | 1:N |
| dim_products | fact_order_items | product_id | 1:N |
| dim_sellers | fact_order_items | seller_id | 1:N |
| fact_orders | fact_order_items | order_id | 1:N |

