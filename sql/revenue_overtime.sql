use database ecommerce_db;
use schema analytics;

SELECT
    dd.year,
    dd.month,
    SUM(foi.order_revenue) AS monthly_revenue,
    COUNT(DISTINCT foi.order_id) AS orders_count
FROM (
    SELECT
        order_id,
        date_key,
        MAX(payment_value) AS order_revenue
    FROM analytics.fact_order_items
    GROUP BY order_id, date_key
) foi
LEFT JOIN analytics.dim_date dd
    ON foi.date_key = dd.date_key
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;
