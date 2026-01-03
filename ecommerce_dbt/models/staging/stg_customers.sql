/*
Staging model for customers
- Cleans column names
- Standardizes data types
- Adds basic transformations
*/

with source as (
    select * from {{ source('raw', 'CUSTOMERS') }}
),

cleaned as (
    select
        -- Primary key
        customer_id,
        customer_unique_id,
        
        -- Location info
        customer_zip_code_prefix as zip_code,
        lower(trim(customer_city)) as city,
        upper(trim(customer_state)) as state
        
    from source
)

select * from cleaned
