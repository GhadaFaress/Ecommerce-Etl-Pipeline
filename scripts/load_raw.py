import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

engine = create_engine(
    f"snowflake://{os.getenv('SNOWFLAKE_USER')}:"
    f"{os.getenv('SNOWFLAKE_PASSWORD')}@"
    f"{os.getenv('SNOWFLAKE_ACCOUNT')}/"
    f"{os.getenv('SNOWFLAKE_DATABASE')}/RAW?"
    f"warehouse={os.getenv('SNOWFLAKE_WAREHOUSE')}"
)

files = {
    "customers": "data/raw/olist_customers_dataset.csv",
    "order_items": "data/raw/olist_order_items_dataset.csv",
    "products": "data/raw/olist_products_dataset.csv",
    "sellers": "data/raw/olist_sellers_dataset.csv",
    "payments": "data/raw/olist_order_payments_dataset.csv",
    "reviews": "data/raw/olist_order_reviews_dataset.csv",
}

for table, path in files.items():
    df = pd.read_csv(path)
    df.to_sql(table, engine, if_exists="append", index=False)
    print(f"Loaded {table}")
