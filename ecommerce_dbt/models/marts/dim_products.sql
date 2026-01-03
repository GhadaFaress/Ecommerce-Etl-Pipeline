/*
Product Dimension
- One row per product
- Includes category and physical dimensions
- Ready for product analytics
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

select
    -- Primary key
    product_id,
    
    -- Product attributes
    category_name,
    name_length,
    description_length,
    photos_count,
    
    -- Physical dimensions
    weight_grams,
    length_cm,
    height_cm,
    width_cm,
    volume_cm3,
    
    -- Metadata
    current_timestamp() as last_updated_at

from {{ ref('stg_products') }}




