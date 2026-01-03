/*
Seller Dimension
- One row per seller
- Includes location information
- Ready for seller analytics
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

select
    -- Primary key
    seller_id,
    
    -- Location attributes
    zip_code,
    city,
    state,
    
    -- Metadata
    current_timestamp() as last_updated_at

from {{ ref('stg_sellers') }}



