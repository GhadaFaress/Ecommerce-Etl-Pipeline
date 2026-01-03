/*
Staging model for products
- Joins with category translation
- Standardizes dimensions
*/

with source as (
    select * from {{ source('raw', 'PRODUCTS') }}
),

cleaned as (
    select
        -- Primary key
        p.product_id,
        
        -- Category (Portuguese only - no translation table)
        p.product_category_name as category_name,
        
        -- Product attributes
        p.product_name_lenght as name_length,
        p.product_description_lenght as description_length,
        p.product_photos_qty as photos_count,
        
        -- Dimensions
        p.product_weight_g as weight_grams,
        p.product_length_cm as length_cm,
        p.product_height_cm as height_cm,
        p.product_width_cm as width_cm,
        
        -- Calculate volume
        (p.product_length_cm * p.product_height_cm * p.product_width_cm) as volume_cm3
        
    from source as p
)

select * from cleaned
