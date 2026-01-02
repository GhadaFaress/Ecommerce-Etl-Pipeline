use database ecommerce_db;
use schema ANALYTICS;
create table fact_order_items as
select oi.order_id,
o.customer_id,
oi.product_id,
oi.seller_id,
o.order_purchase_timestamp AS order_date,
o.order_delivered_customer_date AS delivery_date,
oi.price,
oi.freight_value,
p.payment_value,
r.review_score,
DATEDIFF(day,o.order_estimated_delivery_date, o.order_delivered_customer_date) as delivery_delay_days
from raw.order_items oi
join raw.orders o on oi.ORDER_ID=o.ORDER_ID
LEFT JOIN raw.payments p
    ON oi.order_id = p.order_id
LEFT JOIN raw.reviews r
    ON oi.order_id = r.order_id;

select * from FACT_ORDER_ITEMS limit 5;




