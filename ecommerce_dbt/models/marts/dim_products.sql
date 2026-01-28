/*
Product Dimension
- One row per product
- Latest snapshot per product_id
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

with ranked_products as (

    select
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

        -- Deduplication logic
        row_number() over (
            partition by product_id
            order by product_id
        ) as rn

    from {{ ref('stg_products') }}

)

select
    product_id,
    category_name,
    name_length,
    description_length,
    photos_count,
    weight_grams,
    length_cm,
    height_cm,
    width_cm,
    volume_cm3

from ranked_products
where rn = 1
