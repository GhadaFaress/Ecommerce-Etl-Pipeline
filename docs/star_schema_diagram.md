# Star Schema Diagram - E-Commerce Data Warehouse

```mermaid
erDiagram
    FACT_ORDERS ||--|| DIM_CUSTOMERS : "customer_id"
    FACT_ORDER_ITEMS ||--|| DIM_CUSTOMERS : "customer_id"
    FACT_ORDER_ITEMS ||--|| DIM_PRODUCTS : "product_id"
    FACT_ORDER_ITEMS ||--|| DIM_SELLERS : "seller_id"
    FACT_ORDER_ITEMS }|--|| FACT_ORDERS : "order_id"

    DIM_CUSTOMERS {
        string customer_id PK
        string customer_unique_id
        string zip_code
        string city
        string state
    }

    DIM_PRODUCTS {
        string product_id PK
        string category_name
        int name_length
        int description_length
        int photos_count
        float weight_grams
        float length_cm
        float height_cm
        float width_cm
        float volume_cm3
    }

    DIM_SELLERS {
        string seller_id PK
        string zip_code
        string city
        string state
    }

    FACT_ORDERS {
        string order_id PK
        string customer_id FK
        string order_status
        timestamp purchase_timestamp
        timestamp delivered_customer_date
        timestamp estimated_delivery_date
        int days_to_deliver
        int delivery_vs_estimate_days
        string delivery_performance
        int item_count
        decimal total_price
        decimal total_freight
        decimal total_order_value
        date purchase_date
        int purchase_year
        int purchase_month
    }

    FACT_ORDER_ITEMS {
        string order_id PK_FK
        int order_item_id PK
        string customer_id FK
        string product_id FK
        string seller_id FK
        string order_status
        timestamp purchase_timestamp
        date purchase_date
        decimal price
        decimal freight_value
        decimal total_item_value
        float price_percent_of_total
        float freight_percent_of_total
    }
```

## Schema Description

### Dimension Tables (3)
- **DIM_CUSTOMERS**: Customer master data with location
- **DIM_PRODUCTS**: Product catalog with categories and dimensions
- **DIM_SELLERS**: Seller information with location

### Fact Tables (2)
- **FACT_ORDERS**: Aggregated order-level metrics
- **FACT_ORDER_ITEMS**: Granular line-item level transactions

### Relationships
- One customer can have many orders
- One order can have many order items
- Each order item links to one product and one seller

