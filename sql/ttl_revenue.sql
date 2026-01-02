use database ecommerce_db;
use schema analytics;
select * from analytics.fact_order_items limit 10;
select sum(payment_value) as ttl_revenue
from analytics.fact_order_items;
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM fact_order_items;

SELECT
    order_id,
    COUNT(*) AS items_in_order,
    COUNT(DISTINCT payment_value) AS payment_variations
FROM fact_order_items
GROUP BY order_id
LIMIT 10;
SELECT
    order_id,
    COUNT(*) AS items_in_order,
    COUNT(DISTINCT payment_value) AS payment_variations
FROM fact_order_items
GROUP BY order_id
LIMIT 10;
SELECT
    SUM(order_revenue) AS total_revenue
FROM (
    SELECT
        order_id,
        MAX(payment_value) AS order_revenue
    FROM fact_order_items
    GROUP BY order_id
);
