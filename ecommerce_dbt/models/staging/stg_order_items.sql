/*
Staging model for order items
- Cleans and standardizes order line items
- Calculates item-level revenue
*/

with source as (
    select * from {{ source('raw', 'ORDER_ITEMS') }}
),

cleaned as (
    select
        -- Composite key (order + item)
        order_id,
        order_item_id,
        
        -- Foreign keys
        product_id,
        seller_id,
        
        -- Dates
        to_timestamp(shipping_limit_date) as shipping_limit_date,
        
        -- Amounts
        price,
        freight_value,
        price + freight_value as total_item_value
        
    from source
)

select * from cleaned
