/*
Customer Dimension
- One row per customer
- Includes location information
- Ready for analytics and reporting
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

select
    -- Primary key
    customer_id,
    customer_unique_id,
    
    -- Location attributes
    zip_code,
    city,
    state,
    
    -- Aggregated metrics (could be useful for segmentation)
    current_timestamp() as last_updated_at

from {{ ref('stg_customers') }}



