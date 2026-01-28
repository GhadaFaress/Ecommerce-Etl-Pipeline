# Complete ERD Diagram - E-Commerce ETL Pipeline

## Full Data Flow: Raw → Staging → Analytics

```mermaid
erDiagram

    %% RAW LAYER
    RAW_CUSTOMERS ||--o{ RAW_ORDERS : places
    RAW_ORDERS ||--|{ RAW_ORDER_ITEMS : contains
    RAW_ORDERS ||--o{ RAW_PAYMENTS : paid_by
    RAW_ORDERS ||--o{ RAW_REVIEWS : reviewed_in
    RAW_PRODUCTS ||--o{ RAW_ORDER_ITEMS : ordered_as
    RAW_SELLERS ||--o{ RAW_ORDER_ITEMS : sold_by

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
    DIM_CUSTOMERS ||--o{ FACT_ORDERS : customer_id
    DIM_CUSTOMERS ||--o{ FACT_ORDER_ITEMS : customer_id
    DIM_PRODUCTS ||--o{ FACT_ORDER_ITEMS : product_id
    DIM_SELLERS ||--o{ FACT_ORDER_ITEMS : seller_id
    FACT_ORDERS ||--o{ FACT_ORDER_ITEMS : order_id

    %% RAW TABLES
    RAW_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string customer_city
        string customer_state
    }

    RAW_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        timestamp order_purchase_timestamp
    }

    RAW_ORDER_ITEMS {
        string order_id FK
        int order_item_id
        string product_id FK
        string seller_id FK
        decimal price
        decimal freight_value
    }

    %% STAGING TABLES
    STG_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string city
        string state
    }

    STG_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        timestamp purchase_timestamp
        int days_to_deliver
    }

    STG_ORDER_ITEMS {
        string order_id FK
        int order_item_id
        string product_id FK
        string seller_id FK
        decimal total_item_value
    }

    %% ANALYTICS TABLES
    DIM_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string city
        string state
    }

    DIM_PRODUCTS {
        string product_id PK
        string category_name
        float weight_grams
        float volume_cm3
    }

    DIM_SELLERS {
        string seller_id PK
        string city
        string state
    }

    FACT_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        date purchase_date
        decimal total_order_value
    }

    FACT_ORDER_ITEMS {
        string order_id FK
        int order_item_id
        string product_id FK
        string seller_id FK
        decimal total_item_value
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

