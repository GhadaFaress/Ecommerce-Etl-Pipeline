/*
Customer Dimension
- One row per real customer
- Primary key: customer_unique_id
*/

{{ config(
    materialized='table',
    schema='analytics'
) }}

with customers_deduplicated as (

    select
		customer_id,
        customer_unique_id,

        -- Choose ONE representative location per customer
        -- We use the most recent record (can be changed if needed)
        zip_code,
        city,
        state,

        row_number() over (
            partition by customer_unique_id
            order by customer_id desc
        ) as row_num

    from {{ ref('stg_customers') }}

)

select
-- Technical key (used for joins)
    customer_id,
    -- Primary key
    customer_unique_id,

    -- Descriptive attributes
    zip_code,
    city,
    state,

    -- Metadata
    current_timestamp() as last_updated_at

from customers_deduplicated
where row_num = 1
