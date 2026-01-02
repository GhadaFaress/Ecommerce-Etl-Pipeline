import os
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv

load_dotenv()

engine = create_engine(
    f"snowflake://{os.getenv('SNOWFLAKE_USER')}:"
    f"{os.getenv('SNOWFLAKE_PASSWORD')}@"
    f"{os.getenv('SNOWFLAKE_ACCOUNT')}/"
    f"{os.getenv('SNOWFLAKE_DATABASE')}/"
    f"{os.getenv('SNOWFLAKE_SCHEMA')}?"
    f"warehouse={os.getenv('SNOWFLAKE_WAREHOUSE')}"
)

df = pd.read_csv("data/raw/olist_orders_dataset.csv")

df.to_sql(
    "orders",
    engine,
    if_exists="append",
    index=False
)

print("Loaded orders into Snowflake RAW layer")
