use database ecommerce_db;
use schema analytics;
SELECT
    foi.product_id,
    p.product_category_name,
    SUM(foi.order_revenue) AS revenue,
    COUNT(DISTINCT foi.order_id) AS orders_count
FROM (
    SELECT
        order_id,
        product_id,
        MAX(payment_value) AS order_revenue
    FROM analytics.fact_order_items
    GROUP BY order_id, product_id
) foi
LEFT JOIN analytics.dim_products p
    ON foi.product_id = p.product_id
GROUP BY foi.product_id, p.product_category_name
ORDER BY revenue DESC
LIMIT 10;  
