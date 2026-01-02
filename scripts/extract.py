import pandas as pd
from pathlib import Path


def extract_all(raw_data_path: str) -> dict:
    """
    Extract all raw CSV files and return them as DataFrames
    """
    raw_path = Path(raw_data_path)

    data = {
        "orders": pd.read_csv(raw_path / "olist_orders_dataset.csv"),
        "customers": pd.read_csv(raw_path / "olist_customers_dataset.csv"),
        "order_items": pd.read_csv(raw_path / "olist_order_items_dataset.csv"),
        "products": pd.read_csv(raw_path / "olist_products_dataset.csv"),
        "sellers": pd.read_csv(raw_path / "olist_sellers_dataset.csv"),
        "geolocation": pd.read_csv(raw_path / "olist_geolocation_dataset.csv"),
    }

    return data


if __name__ == "__main__":
    raw_data_path = r"E:\WORK\data engineering\ecommerce-etl\data\raw"

    datasets = extract_all(raw_data_path)

    for name, df in datasets.items():
        print(f"\n{name.upper()}")
        print(df.shape)
        print(df.head(2))
