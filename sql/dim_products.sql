use database ecommerce_db;
CREATE OR REPLACE TABLE analytics.dim_products AS
SELECT
    product_id,
    product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM raw.products;
select * from analytics.dim_products limit 5;