# 🛒 E-Commerce ETL Pipeline

[![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)](https://www.python.org/)  
[![License](https://img.shields.io/badge/License-MIT-green)](#)

An **end-to-end analytics engineering project**that builds a **production-style ETL pipeline** using **Python, dbt, Snowflake, and Power BI to deliver business-ready insights** from raw e-commerce data.

---

## 🚀 Project Overview

This project simulates a **real-world e-commerce ETL pipeline**:

1. **Extract**: Load raw e-commerce data using Python
2. **Load**: raw data into Snowflake
3. **Transform**: Use **dbt + Snowflake** to build analytics-ready models
4. **Modeling**: Star schema (fact & dimension tables)
5. **Analytics & Visualize**: insights using **Power BI dashboards**

---

## 🧱 Architecture & Data Models

📐 **[View All Diagrams](./docs/)** - Complete documentation with interactive diagrams

- **[Architecture Flow](./docs/architecture_diagram.md)** - Full ETL pipeline from CSV to Analytics
- **[Star Schema](./docs/star_schema_diagram.md)** - Dimensional model with fact & dimension tables  
- **[ERD Diagram](./docs/erd_diagram.md)** - Complete data lineage across all layers

---
## 🏗️ Data Architecture

- **Snowflake**: Cloud data warehouse
- **dbt**: Transformations, tests, documentation & DAG
- **Python**: Data extraction & loading
- **Power BI**:Business dashboards & KPIs

## 🗂️ Project Structure
```
Ecommerce-Etl-Pipeline/
│
├── ecommerce_dbt/
│   ├── models/
│   │   ├── staging/
│   │   └── marts/
│   ├── tests/
│   └── dbt_project.yml
│
├── scripts/
│   ├── extract.py
│   ├── load_raw.py
│   └── test_snowflake_connection.py
│
├── sql/
│   └── create_tables.sql
│
├── docs/
│   ├── architecture_diagram.md
│   ├── star_schema_diagram.md
│   └── erd_diagram.md
│
├── powerbi/
│   ├── PBIX_files/
│   └── Dashboard_Screenshots
│
├── requirements.txt
├── .gitignore
└── README.md

```
---

## 🛠️ Tech Stack

- **Languages**: Python , SQL
- **Databases**: Snowflake 
- **Transformations**: dbt
- **BI & Visualization:**: Power BI
- **Version Control**: Git & GitHub  

---
## 🧬 dbt Models & Documentation
* **Staging models** for raw data cleanup
*   **Mart models** for analytics:
   *  `fact_orders`
   * `fact_order_items`
   *  `dim_customers`
   *  `dim_products`
   *   `dim_sellers` 
    * **dbt tests** for data quality
    * **dbt documentation & DAG** generated and visualized”
       <img width="1850" height="857" alt="Screenshot 2026-01-28 040019" src="https://github.com/user-attachments/assets/63e91aea-2096-48ba-b187-cb72b51667af" />

<img width="1309" height="838" alt="Screenshot 2026-01-28 040058" src="https://github.com/user-attachments/assets/240925be-dab2-4187-afe2-84b7b5929cc4" />

## 📊 Power BI Dashboards
The Power BI layer consumes **analytics-ready Snowflake tables** and provides business insights such as: 
* Monthly revenue trends
* Top-selling products
* Revenue by product category
* Order and customer behavior analysis

 ### 📷 Dashboards 
<img width="1129" height="643" alt="Screenshot 2026-01-28 032306" src="https://github.com/user-attachments/assets/fff760cf-caf3-4b69-94dc-de10b44c356d" />

<img width="1158" height="654" alt="Screenshot 2026-01-28 032317" src="https://github.com/user-attachments/assets/80809582-b82f-4cfd-a9e8-77518e20af18" />

<img width="1147" height="642" alt="Screenshot 2026-01-28 032329" src="https://github.com/user-attachments/assets/4805e31d-5e93-488a-8cd4-7d89441817e8" />

---

## ▶️ How to Run

1. Install dependencies:

```bash
pip install -r requirements.txt
```
2. Run ETL scripts:

```bash
python scripts/extract.py
python scripts/transform.py
python scripts/load_orders.py
```
3. Run dbt:
```bash
dbt run
dbt test
```
## 📌 Author

**Ghada Fares**  
Data Engineering & Analytics Engineering Enthusiast  

[GitHub](https://github.com/GhadaFaress) | [LinkedIn](https://www.linkedin.com/in/ghada-fares-b78bb3249)
