/*
Seller Dimension
- One row per seller
- Latest snapshot per seller_id
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

with ranked_sellers as (

    select
        seller_id,

        -- Location attributes
        zip_code,
        city,
        state,

        row_number() over (
            partition by seller_id
            order by seller_id
        ) as rn

    from {{ ref('stg_sellers') }}

)

select
    seller_id,
    zip_code,
    city,
    state

from ranked_sellers
where rn = 1
