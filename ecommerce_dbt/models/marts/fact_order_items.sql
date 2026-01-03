/*
Order Items Fact Table
- One row per order line item
- Most granular level of detail
- Includes product and seller information
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select 
        order_id,
        customer_id,
        order_status,
        purchase_timestamp,
        date(purchase_timestamp) as purchase_date
    from {{ ref('stg_orders') }}
)

select
    -- Composite key
    oi.order_id,
    oi.order_item_id,
    
    -- Foreign keys
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    
    -- Order context
    o.order_status,
    o.purchase_timestamp,
    o.purchase_date,
    
    -- Item attributes
    oi.shipping_limit_date,
    
    -- Financial metrics
    oi.price,
    oi.freight_value,
    oi.total_item_value,
    
    -- Calculated metrics
    round(oi.price / nullif(oi.total_item_value, 0) * 100, 2) as price_percent_of_total,
    round(oi.freight_value / nullif(oi.total_item_value, 0) * 100, 2) as freight_percent_of_total,
    
    -- Metadata
    current_timestamp() as last_updated_at

from order_items as oi
inner join orders as o
    on oi.order_id = o.order_id



