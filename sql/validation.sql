use database ecommerce_db;
use schema analytics;
select count(*) from analytics.fact_order_items;

select count(*) from raw.order_items;
select count(*) from analytics.dim_customers;
select count(*) from analytics.dim_products;
select count(*) from analytics.dim_date;
select count(*) from analytics.dim_sellers;
select count(customer_id) from 
analytics.fact_order_items 
where customer_id is NULL;
select count(product_id) from 
analytics.fact_order_items 
where product_id is NULL;
select count(product_id) from 
analytics.fact_order_items 
where product_id is NULL;
select * from analytics.fact_order_items limit 5;
