use database ecommerce_db;
use schema analytics;
-- Row count
SELECT COUNT(*) FROM analytics.fact_order_items;

-- Sample some data
SELECT * FROM analytics.fact_order_items LIMIT 10;

-- Simple aggregations
SELECT SUM(price) AS total_sales, AVG(delivery_delay_days) AS avg_delay
FROM analytics.fact_order_items;

-- Aggregation per dimension example
SELECT customer_id, SUM(price) AS total_sales
FROM analytics.fact_order_items
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
