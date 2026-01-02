import os
from dotenv import load_dotenv
import snowflake.connector
import pandas as pd
import matplotlib.pyplot as plt

# ---------------------------
# Load environment variables
# ---------------------------
load_dotenv()

conn = snowflake.connector.connect(
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database=os.getenv("SNOWFLAKE_DATABASE"),
    schema=os.getenv("SNOWFLAKE_SCHEMA")
)

# ---------------------------
# Monthly Revenue Query
# ---------------------------
monthly_revenue = pd.read_sql("""
SELECT
    dd.year,
    dd.month,
    SUM(foi.order_revenue) AS monthly_revenue
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
""", conn)

# Normalize column names
monthly_revenue.columns = monthly_revenue.columns.str.lower()

monthly_revenue["month_str"] = (
    monthly_revenue["year"].astype(str)
    + "-"
    + monthly_revenue["month"].astype(str).str.zfill(2)
)

# ---------------------------
# Revenue by Product Category
# ---------------------------
category_revenue = pd.read_sql("""
SELECT
    p.product_category_name,
    SUM(foi.order_revenue) AS revenue
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
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;
""", conn)

category_revenue.columns = category_revenue.columns.str.lower()

# ---------------------------
# Top Products by Revenue
# ---------------------------
top_products = pd.read_sql("""
SELECT
    foi.product_id,
    p.product_category_name,
    SUM(foi.order_revenue) AS revenue
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
""", conn)

top_products.columns = top_products.columns.str.lower()

conn.close()

# ---------------------------
# Plot 1: Monthly Revenue
# ---------------------------
plt.figure(figsize=(10, 5))
plt.plot(monthly_revenue["month_str"], monthly_revenue["monthly_revenue"], marker="o")
plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("monthly_revenue.png", dpi=300)
plt.show()

# ---------------------------
# Plot 2: Revenue by Category
# ---------------------------
plt.figure(figsize=(10, 5))
plt.bar(category_revenue["product_category_name"], category_revenue["revenue"])
plt.title("Top 10 Product Categories by Revenue")
plt.xlabel("Category")
plt.ylabel("Revenue")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("category_revenue.png", dpi=300)
plt.show()

# ---------------------------
# Plot 3: Top Products
# ---------------------------
plt.figure(figsize=(10, 5))
plt.bar(top_products["product_id"], top_products["revenue"])
plt.title("Top 10 Products by Revenue")
plt.xlabel("Product ID")
plt.ylabel("Revenue")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("top_products.png", dpi=300)
plt.show()
