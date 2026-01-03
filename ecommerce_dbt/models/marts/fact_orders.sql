/*
Order Fact Table
- One row per order
- Includes order metrics and delivery performance
- Joins with dimensions for analysis
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items_agg as (
    select
        order_id,
        count(*) as item_count,
        sum(price) as total_price,
        sum(freight_value) as total_freight,
        sum(total_item_value) as total_order_value
    from {{ ref('stg_order_items') }}
    group by order_id
)

select
    -- Primary key
    o.order_id,
    
    -- Foreign keys
    o.customer_id,
    
    -- Order attributes
    o.order_status,
    
    -- Timestamps
    o.purchase_timestamp,
    o.approved_at,
    o.delivered_carrier_date,
    o.delivered_customer_date,
    o.estimated_delivery_date,
    
    -- Delivery metrics
    o.days_to_deliver,
    o.delivery_vs_estimate_days,
    
    -- Delivery performance flag
    case 
        when o.delivery_vs_estimate_days < 0 then 'Late'
        when o.delivery_vs_estimate_days = 0 then 'On Time'
        when o.delivery_vs_estimate_days > 0 then 'Early'
        else 'Unknown'
    end as delivery_performance,
    
    -- Order metrics (from aggregated items)
    coalesce(oi.item_count, 0) as item_count,
    coalesce(oi.total_price, 0) as total_price,
    coalesce(oi.total_freight, 0) as total_freight,
    coalesce(oi.total_order_value, 0) as total_order_value,
    
    -- Date dimensions for easy filtering
    date(o.purchase_timestamp) as purchase_date,
    year(o.purchase_timestamp) as purchase_year,
    month(o.purchase_timestamp) as purchase_month,
    dayofweek(o.purchase_timestamp) as purchase_day_of_week,
    
    -- Metadata
    current_timestamp() as last_updated_at

from orders as o
left join order_items_agg as oi
    on o.order_id = oi.order_id



