-- ========================================
-- Create Database and Schema
-- ========================================

-- Create database for e-commerce data
CREATE DATABASE IF NOT EXISTS ECOMMERCE_DB;

-- Use the database
USE DATABASE ECOMMERCE_DB;

-- Create schema for raw data
CREATE SCHEMA IF NOT EXISTS RAW;

-- Use the schema
USE SCHEMA RAW;

-- ========================================
-- Create Tables for Olist E-commerce Data
-- ========================================

-- 1. CUSTOMERS TABLE
CREATE OR REPLACE TABLE customers (
    customer_id VARCHAR(100) PRIMARY KEY,
    customer_unique_id VARCHAR(100),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- 2. SELLERS TABLE
CREATE OR REPLACE TABLE sellers (
    seller_id VARCHAR(100) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

-- 3. PRODUCTS TABLE
CREATE OR REPLACE TABLE products (
    product_id VARCHAR(100) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length NUMBER,
    product_description_length NUMBER,
    product_photos_qty NUMBER,
    product_weight_g NUMBER,
    product_length_cm NUMBER,
    product_height_cm NUMBER,
    product_width_cm NUMBER
);

-- 4. PRODUCT CATEGORY TRANSLATION TABLE
CREATE OR REPLACE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

-- 5. ORDERS TABLE
CREATE OR REPLACE TABLE orders (
    order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP_NTZ,
    order_approved_at TIMESTAMP_NTZ,
    order_delivered_carrier_date TIMESTAMP_NTZ,
    order_delivered_customer_date TIMESTAMP_NTZ,
    order_estimated_delivery_date TIMESTAMP_NTZ,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 6. ORDER ITEMS TABLE
CREATE OR REPLACE TABLE order_items (
    order_id VARCHAR(100),
    order_item_id NUMBER,
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_date TIMESTAMP_NTZ,
    price NUMBER(10, 2),
    freight_value NUMBER(10, 2),
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- 7. ORDER PAYMENTS TABLE
CREATE OR REPLACE TABLE order_payments (
    order_id VARCHAR(100),
    payment_sequential NUMBER,
    payment_type VARCHAR(50),
    payment_installments NUMBER,
    payment_value NUMBER(10, 2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 8. ORDER REVIEWS TABLE
CREATE OR REPLACE TABLE order_reviews (
    review_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100),
    review_score NUMBER,
    review_comment_title VARCHAR(500),
    review_comment_message VARCHAR(5000),
    review_creation_date TIMESTAMP_NTZ,
    review_answer_timestamp TIMESTAMP_NTZ,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 9. GEOLOCATION TABLE
CREATE OR REPLACE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat NUMBER(10, 8),
    geolocation_lng NUMBER(11, 8),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

-- Verify Tables Created

SHOW TABLES;


