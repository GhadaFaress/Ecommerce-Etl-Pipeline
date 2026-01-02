use database ecommerce_db;
CREATE TABLE analytics.dim_customers as
select customer_id,
customer_city,
customer_state
from raw.customers;
select * from analytics.dim_customers limit 5;

