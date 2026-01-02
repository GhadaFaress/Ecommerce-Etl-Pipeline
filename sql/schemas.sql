use database ecommerce_db;
create schema if not exists raw;
show schemas;
create schema if not exists analytics;
select count(*) from raw.orders;
show tables in schema raw;
select count(*) from raw.order_items;