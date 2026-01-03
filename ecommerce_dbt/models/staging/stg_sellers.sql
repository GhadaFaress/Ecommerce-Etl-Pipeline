/*
Staging model for sellers
- Cleans and standardizes seller information
*/

with source as (
    select * from {{ source('raw', 'SELLERS') }}
),

cleaned as (
    select
        -- Primary key
        seller_id,
        
        -- Location info
        seller_zip_code_prefix as zip_code,
        lower(trim(seller_city)) as city,
        upper(trim(seller_state)) as state
        
    from source
)

select * from cleaned
