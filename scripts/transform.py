import pandas as pd
from pathlib import Path

def transform_orders(df):
    # list of date columns
    date_columns = [
        "order_purchase_timestamp",
        "order_approved_at",
        "order_delivered_carrier_date",
        "order_delivered_customer_date",
        "order_estimated_delivery_date",
    ]

    # convert each column to datetime
    for col in date_columns:
        df[col] = pd.to_datetime(df[col], errors="coerce")

    return df   

orders_clean = transform_orders(orders)

print(orders_clean.dtypes)
