use database ecommerce_db;
use schema analytics;
ALTER TABLE fact_order_items
ADD COLUMN date_key INT;
UPDATE fact_order_items f
SET date_key = d.date_key
FROM dim_date d
WHERE DATE(f.order_date) = d.order_date;
SELECT COUNT(*) AS total_rows,
       COUNT(date_key) AS filled_date_keys
FROM fact_order_items;

select * from analytics.fact_order_items fo left join analytics.dim_customers dc
on fo.customer_id=dc.customer_id left join analytics.dim_products dp 
on fo.product_id=dp.product_id 
left join analytics.dim_sellers ds on
fo.seller_id=ds.seller_id
left join analytics.dim_date limit 10;
SELECT
    f.order_id,
    c.customer_city,
    p.product_category_name,
    d.order_date,
    d.month_name
FROM fact_order_items f
LEFT JOIN dim_customers c ON f.customer_id = c.customer_id
LEFT JOIN dim_products p ON f.product_id = p.product_id
LEFT JOIN dim_date d ON f.date_key = d.date_key
LIMIT 10;
