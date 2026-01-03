"""
Test Queries for Snowflake Data
Run sample queries to verify and explore the loaded data.
"""

import snowflake.connector
import pandas as pd
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Connect to Snowflake
print("=" * 80)
print("🔍 RUNNING TEST QUERIES")
print("=" * 80)
print()

try:
    conn = snowflake.connector.connect(
        account=os.getenv('SNOWFLAKE_ACCOUNT'),
        user=os.getenv('SNOWFLAKE_USER'),
        password=os.getenv('SNOWFLAKE_PASSWORD'),
        warehouse=os.getenv('SNOWFLAKE_WAREHOUSE'),
        database=os.getenv('SNOWFLAKE_DATABASE'),
        schema=os.getenv('SNOWFLAKE_SCHEMA'),
        role=os.getenv('SNOWFLAKE_ROLE')
    )
    print("✅ Connected to Snowflake")
    print()
except Exception as e:
    print(f"❌ Connection failed: {str(e)}")
    exit(1)

# Define test queries
queries = {
    "1. Total Orders": """
        SELECT COUNT(*) as total_orders
        FROM orders
    """,
    
    "2. Orders by Status": """
        SELECT 
            order_status,
            COUNT(*) as order_count,
            ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
        FROM orders
        GROUP BY order_status
        ORDER BY order_count DESC
    """,
    
    "3. Top 10 Cities by Customers": """
        SELECT 
            customer_city,
            customer_state,
            COUNT(*) as customer_count
        FROM customers
        GROUP BY customer_city, customer_state
        ORDER BY customer_count DESC
        LIMIT 10
    """,
    
    "4. Orders Over Time (Monthly)": """
        SELECT 
            DATE_TRUNC('month', order_purchase_timestamp) as month,
            COUNT(*) as orders,
            SUM(COUNT(*)) OVER (ORDER BY DATE_TRUNC('month', order_purchase_timestamp)) as cumulative_orders
        FROM orders
        WHERE order_purchase_timestamp IS NOT NULL
        GROUP BY month
        ORDER BY month
        LIMIT 12
    """,
    
    "5. Average Order Value": """
        SELECT 
            COUNT(DISTINCT oi.order_id) as total_orders,
            SUM(oi.price) as total_revenue,
            ROUND(AVG(oi.price), 2) as avg_item_price,
            ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2) as avg_order_value
        FROM order_items oi
    """,
    
    "6. Top 10 Product Categories": """
        SELECT 
            p.product_category_name,
            pct.product_category_name_english,
            COUNT(DISTINCT oi.order_id) as orders,
            SUM(oi.price) as revenue
        FROM order_items oi
        JOIN products p ON oi.product_id = p.product_id
        LEFT JOIN product_category_translation pct 
            ON p.product_category_name = pct.product_category_name
        WHERE p.product_category_name IS NOT NULL
        GROUP BY p.product_category_name, pct.product_category_name_english
        ORDER BY revenue DESC
        LIMIT 10
    """,
    
    "7. Payment Methods Distribution": """
        SELECT 
            payment_type,
            COUNT(DISTINCT order_id) as orders,
            SUM(payment_value) as total_amount,
            ROUND(AVG(payment_installments), 2) as avg_installments
        FROM order_payments
        GROUP BY payment_type
        ORDER BY orders DESC
    """,
    
    "8. Review Score Distribution": """
        SELECT 
            review_score,
            COUNT(*) as review_count,
            ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
        FROM order_reviews
        WHERE review_score IS NOT NULL
        GROUP BY review_score
        ORDER BY review_score DESC
    """
}

# Execute each query
for query_name, query in queries.items():
    print("=" * 80)
    print(f"📊 {query_name}")
    print("=" * 80)
    
    try:
        df = pd.read_sql(query, conn)
        print(df.to_string(index=False))
        print()
    except Exception as e:
        print(f"❌ Error: {str(e)}")
        print()

conn.close()

print("=" * 80)
print("✅ TEST QUERIES COMPLETE!")
print("=" * 80)





