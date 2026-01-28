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
),

customers as (
    select
        customer_id,
        customer_unique_id
    from {{ ref('dim_customers') }}
)

select
    oi.order_id,
    oi.order_item_id,
    c.customer_unique_id,
    oi.product_id,
    oi.seller_id,
    o.order_status,
    o.purchase_timestamp,
    o.purchase_date,
    oi.price,
    oi.freight_value,
    oi.total_item_value,
    current_timestamp() as last_updated_at
from order_items oi
inner join orders o
    on oi.order_id = o.order_id
inner join customers c
    on o.customer_id = c.customer_id
