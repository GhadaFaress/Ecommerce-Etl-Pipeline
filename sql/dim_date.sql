use database ecommerce_db;
USE SCHEMA analytics;

CREATE OR REPLACE TABLE dim_date AS
SELECT
    ROW_NUMBER() OVER (ORDER BY order_date) AS date_key,
    order_date,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    DAY(order_date) AS day,
    DAYOFWEEK(order_date) AS weekday_number,
    DAYNAME(order_date) AS weekday_name,
    MONTHNAME(order_date) AS month_name
FROM (
    SELECT DISTINCT CAST(order_date AS DATE) AS order_date
    FROM fact_order_items
);

SELECT COUNT(*) FROM dim_date;
SELECT * FROM dim_date LIMIT 10;
