import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

def load_raw_data():
    """
    ETL function to load raw CSV files into Snowflake.
    This is now Airflow-ready via PythonOperator.
    """
    print("✅ load_raw_data started")
    
    # Load environment variables
    load_dotenv()

    # Create Snowflake engine
    engine = create_engine(
        f"snowflake://{os.getenv('SNOWFLAKE_USER')}:"  # username
        f"{os.getenv('SNOWFLAKE_PASSWORD')}@"         # password
        f"{os.getenv('SNOWFLAKE_ACCOUNT')}/"         # account
        f"{os.getenv('SNOWFLAKE_DATABASE')}/RAW?"    # database / schema
        f"warehouse={os.getenv('SNOWFLAKE_WAREHOUSE')}"
    )

    # CSV files to load
    files = {
        "customers": "data/raw/olist_customers_dataset.csv",
        "order_items": "data/raw/olist_order_items_dataset.csv",
        "products": "data/raw/olist_products_dataset.csv",
        "sellers": "data/raw/olist_sellers_dataset.csv",
        "payments": "data/raw/olist_order_payments_dataset.csv",
        "reviews": "data/raw/olist_order_reviews_dataset.csv",
    }

    # Load each CSV into Snowflake
    for table, path in files.items():
        print(f"Loading {table} from {path}...")
        df = pd.read_csv(path)
        df.to_sql(table, engine, if_exists="append", index=False)
        print(f"✅ Loaded {table}")

    print("✅ load_raw_data finished")
