"""
Data Exploration Script for Olist E-commerce Dataset
This script explores the raw CSV files to understand the data structure,
quality, and relationships before loading into Snowflake.
"""

import pandas as pd
import os
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Get data path from environment
DATA_PATH = os.getenv('DATA_PATH', 'data/raw')

print("=" * 80)
print("OLIST E-COMMERCE DATA EXPLORATION")
print("=" * 80)
print()

# List all CSV files in the data directory
csv_files = list(Path(DATA_PATH).glob('*.csv'))

if not csv_files:
    print(f"❌ ERROR: No CSV files found in '{DATA_PATH}'")
    print(f"   Please make sure you've downloaded the Olist dataset from Kaggle")
    print(f"   and placed all CSV files in the '{DATA_PATH}' folder.")
    exit(1)

print(f"📁 Found {len(csv_files)} CSV files in '{DATA_PATH}':")
for file in csv_files:
    file_size = os.path.getsize(file) / 1024  # Size in KB
    print(f"   - {file.name} ({file_size:.1f} KB)")
print()

# Dictionary to store dataframes
dataframes = {}

# Load and explore each CSV file
for csv_file in csv_files:
    file_name = csv_file.stem  # Get filename without extension
    print("=" * 80)
    print(f"📊 EXPLORING: {csv_file.name}")
    print("=" * 80)
    
    try:
        # Read CSV file
        df = pd.read_csv(csv_file)
        dataframes[file_name] = df
        
        # Basic information
        print(f"\n📈 Basic Statistics:")
        print(f"   - Total rows: {len(df):,}")
        print(f"   - Total columns: {len(df.columns)}")
        print(f"   - Memory usage: {df.memory_usage(deep=True).sum() / 1024:.1f} KB")
        
        # Column information
        print(f"\n📋 Column Details:")
        print(f"   {'Column Name':<40} {'Data Type':<15} {'Null Count':<12} {'Null %'}")
        print(f"   {'-' * 40} {'-' * 15} {'-' * 12} {'-' * 10}")
        
        for col in df.columns:
            null_count = df[col].isnull().sum()
            null_pct = (null_count / len(df)) * 100
            dtype = str(df[col].dtype)
            print(f"   {col:<40} {dtype:<15} {null_count:<12} {null_pct:.2f}%")
        
        # Sample data
        print(f"\n🔍 Sample Data (first 3 rows):")
        print(df.head(3).to_string())
        
        # Data quality checks
        print(f"\n✅ Data Quality Checks:")
        
        # Check for duplicates
        duplicate_count = df.duplicated().sum()
        print(f"   - Duplicate rows: {duplicate_count:,} ({(duplicate_count/len(df)*100):.2f}%)")
        
        # Check for completely empty rows
        empty_rows = df.isnull().all(axis=1).sum()
        print(f"   - Completely empty rows: {empty_rows:,}")
        
        # Check for columns with all nulls
        all_null_cols = df.columns[df.isnull().all()].tolist()
        if all_null_cols:
            print(f"   - Columns with all nulls: {', '.join(all_null_cols)}")
        else:
            print(f"   - Columns with all nulls: None")
        
        # Identify potential ID columns
        id_cols = [col for col in df.columns if 'id' in col.lower()]
        if id_cols:
            print(f"\n🔑 Potential ID/Key Columns:")
            for id_col in id_cols:
                unique_count = df[id_col].nunique()
                unique_pct = (unique_count / len(df)) * 100
                print(f"   - {id_col}: {unique_count:,} unique values ({unique_pct:.2f}%)")
        
        # Identify date columns
        date_cols = [col for col in df.columns if 'date' in col.lower() or 'time' in col.lower()]
        if date_cols:
            print(f"\n📅 Date/Time Columns:")
            for date_col in date_cols:
                print(f"   - {date_col}")
                # Try to parse dates
                try:
                    date_series = pd.to_datetime(df[date_col], errors='coerce')
                    valid_dates = date_series.notna().sum()
                    if valid_dates > 0:
                        print(f"     • Min date: {date_series.min()}")
                        print(f"     • Max date: {date_series.max()}")
                        print(f"     • Valid dates: {valid_dates:,} ({(valid_dates/len(df)*100):.2f}%)")
                except:
                    print(f"     • Could not parse dates")
        
        print("\n")
        
    except Exception as e:
        print(f"❌ ERROR reading {csv_file.name}: {str(e)}")
        print()

# Summary of all datasets
print("=" * 80)
print("📊 DATASET SUMMARY")
print("=" * 80)
print()
print(f"{'Dataset':<45} {'Rows':<15} {'Columns':<10}")
print(f"{'-' * 45} {'-' * 15} {'-' * 10}")
for name, df in dataframes.items():
    print(f"{name:<45} {len(df):<15,} {len(df.columns):<10}")
print()

# Identify relationships between tables
print("=" * 80)
print("🔗 POTENTIAL TABLE RELATIONSHIPS")
print("=" * 80)
print()
print("Based on common ID columns, here are the likely relationships:")
print()

relationships = [
    ("olist_orders_dataset", "customer_id", "olist_customers_dataset", "customer_id"),
    ("olist_order_items_dataset", "order_id", "olist_orders_dataset", "order_id"),
    ("olist_order_items_dataset", "product_id", "olist_products_dataset", "product_id"),
    ("olist_order_items_dataset", "seller_id", "olist_sellers_dataset", "seller_id"),
    ("olist_order_payments_dataset", "order_id", "olist_orders_dataset", "order_id"),
    ("olist_order_reviews_dataset", "order_id", "olist_orders_dataset", "order_id"),
]

for table1, col1, table2, col2 in relationships:
    if table1 in dataframes and table2 in dataframes:
        df1 = dataframes[table1]
        df2 = dataframes[table2]
        
        if col1 in df1.columns and col2 in df2.columns:
            matching = df1[col1].isin(df2[col2]).sum()
            total = len(df1)
            match_pct = (matching / total) * 100 if total > 0 else 0
            
            print(f"✓ {table1}.{col1} → {table2}.{col2}")
            print(f"  Match rate: {matching:,}/{total:,} ({match_pct:.2f}%)")
            print()

print("=" * 80)
print("✅ DATA EXPLORATION COMPLETE!")
print("=" * 80)
print()
print("Next steps:")
print("1. Review the data quality issues above")
print("2. Decide how to handle missing values")
print("3. Proceed with loading data into Snowflake")
print()

