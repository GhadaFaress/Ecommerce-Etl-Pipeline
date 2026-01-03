/*
Staging model for orders
- Parses timestamps
- Standardizes status values
- Calculates delivery metrics
*/

with source as (
    select * from {{ source('raw', 'ORDERS') }}
),

cleaned as (
    select
        -- Primary key
        order_id,
        
        -- Foreign keys
        customer_id,
        
        -- Order info
        lower(trim(order_status)) as order_status,
        
        -- Timestamps (convert to proper timestamp type)
        to_timestamp(order_purchase_timestamp) as purchase_timestamp,
        to_timestamp(order_approved_at) as approved_at,
        to_timestamp(order_delivered_carrier_date) as delivered_carrier_date,
        to_timestamp(order_delivered_customer_date) as delivered_customer_date,
        to_timestamp(order_estimated_delivery_date) as estimated_delivery_date,
        
        -- Calculated fields
        datediff(day, 
            to_timestamp(order_purchase_timestamp), 
            to_timestamp(order_delivered_customer_date)
        ) as days_to_deliver,
        
        datediff(day,
            to_timestamp(order_delivered_customer_date),
            to_timestamp(order_estimated_delivery_date)
        ) as delivery_vs_estimate_days
        
    from source
)

select * from cleaned
