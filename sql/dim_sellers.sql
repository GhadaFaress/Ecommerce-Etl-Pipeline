use database ecommerce_db;
create table analytics.dim_sellers as
select seller_id,
seller_city,
seller_state
from raw.sellers;
select * from analytics.dim_sellers limit 5;