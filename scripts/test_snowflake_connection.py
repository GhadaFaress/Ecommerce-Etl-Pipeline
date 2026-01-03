"""
Test Snowflake Connection
This script verifies that your Snowflake credentials in .env are working correctly.
"""

import snowflake.connector
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

print("=" * 80)
print("🔌 TESTING SNOWFLAKE CONNECTION")
print("=" * 80)
print()

# Get credentials from .env
snowflake_account = os.getenv('SNOWFLAKE_ACCOUNT')
snowflake_user = os.getenv('SNOWFLAKE_USER')
snowflake_password = os.getenv('SNOWFLAKE_PASSWORD')
snowflake_warehouse = os.getenv('SNOWFLAKE_WAREHOUSE')
snowflake_database = os.getenv('SNOWFLAKE_DATABASE')
snowflake_schema = os.getenv('SNOWFLAKE_SCHEMA')
snowflake_role = os.getenv('SNOWFLAKE_ROLE')

# Check if credentials are loaded
print("📋 Checking environment variables...")
missing = []
if not snowflake_account or snowflake_account == 'your_account_here':
    missing.append('SNOWFLAKE_ACCOUNT')
if not snowflake_user or snowflake_user == 'your_username':
    missing.append('SNOWFLAKE_USER')
if not snowflake_password or snowflake_password == 'your_password':
    missing.append('SNOWFLAKE_PASSWORD')

if missing:
    print("❌ ERROR: Missing or default values in .env file:")
    for item in missing:
        print(f"   - {item}")
    print()
    print("Please update your .env file with actual Snowflake credentials.")
    exit(1)

print(f"   ✓ Account: {snowflake_account}")
print(f"   ✓ User: {snowflake_user}")
print(f"   ✓ Password: {'*' * len(snowflake_password)}")
print(f"   ✓ Warehouse: {snowflake_warehouse}")
print(f"   ✓ Database: {snowflake_database}")
print(f"   ✓ Schema: {snowflake_schema}")
print(f"   ✓ Role: {snowflake_role}")
print()

# Try to connect
print("🔗 Attempting to connect to Snowflake...")
try:
    conn = snowflake.connector.connect(
        account=snowflake_account,
        user=snowflake_user,
        password=snowflake_password,
        warehouse=snowflake_warehouse,
        role=snowflake_role
    )
    
    print("✅ Connection successful!")
    print()
    
    # Test query
    print("🔍 Testing query execution...")
    cursor = conn.cursor()
    cursor.execute("SELECT CURRENT_VERSION(), CURRENT_USER(), CURRENT_ROLE()")
    result = cursor.fetchone()
    
    print(f"   ✓ Snowflake Version: {result[0]}")
    print(f"   ✓ Current User: {result[1]}")
    print(f"   ✓ Current Role: {result[2]}")
    print()
    
    # Check if database and schema exist
    print("📊 Checking database and schema...")
    try:
        cursor.execute(f"USE DATABASE {snowflake_database}")
        print(f"   ✓ Database '{snowflake_database}' exists and accessible")
        
        cursor.execute(f"USE SCHEMA {snowflake_schema}")
        print(f"   ✓ Schema '{snowflake_schema}' exists and accessible")
    except Exception as e:
        print(f"   ⚠️  Database/Schema not found: {str(e)}")
        print("   💡 You may need to create them using the SQL script provided")
    
    cursor.close()
    conn.close()
    
    print()
    print("=" * 80)
    print("✅ SNOWFLAKE CONNECTION TEST PASSED!")
    print("=" * 80)
    print()
    print("You're ready to proceed with loading data into Snowflake!")
    
except Exception as e:
    print(f"❌ CONNECTION FAILED!")
    print()
    print(f"Error: {str(e)}")
    print()
    print("Common issues:")
    print("1. Check your SNOWFLAKE_ACCOUNT format (should be like: abc12345.us-east-1)")
    print("2. Verify your username and password are correct")
    print("3. Make sure your account is active and not suspended")
    print("4. Check if you need to include the region in your account identifier")
    print()
    exit(1)





