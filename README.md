# 🛒 E-Commerce ETL Pipeline

[![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)](https://www.python.org/)  
[![License](https://img.shields.io/badge/License-MIT-green)](#)

An **end-to-end E-Commerce ETL pipeline** that extracts, transforms, and loads data into a **PostgreSQL data warehouse** using a **star schema**. Includes analytical queries and visualizations.

---

## 🚀 Project Overview

This project simulates a **real-world e-commerce ETL pipeline**:

1. **Extract**: Load raw data from CSV / external sources  
2. **Transform**: Clean, aggregate, and prepare data using Python (Pandas)  
3. **Load**: Insert data into PostgreSQL **fact** and **dimension** tables  
4. **Analytics**: Generate business insights and visualizations  
5. **Schema**: Star schema design for easy querying  

---

## 🧱 Architecture Diagram

![Star Schema Diagram](./images/star_schema.png)  

---

## 🗂️ Project Structure
```
ecommerce-etl/
├── data/ # Raw & processed data (not in repo)
├── scripts/ # Python ETL scripts
├── sql/ # SQL scripts for tables and queries
├── notebooks/ # Optional Jupyter notebooks
├── .gitignore
├── README.md
├── requirements.txt
```
---

## 🛠️ Tech Stack

- Python 3.x  
- Pandas, Matplotlib, Seaborn  
- PostgreSQL  
- SQL (Star Schema / Analytical Queries)  
- Git & GitHub  

---

## 📊 Example Visualizations
<img width="3000" height="1500" alt="monthly_revenue" src="https://github.com/user-attachments/assets/478a41a7-8f49-4ab1-8673-52f8e0bc14e9" />
<img width="3000" height="1500" alt="top_products" src="https://github.com/user-attachments/assets/7f7e2b11-8beb-4ee8-9ad5-66f64c6df3df" />
<img width="3000" height="1500" alt="category_revenue" src="https://github.com/user-attachments/assets/3b3c474b-1a7b-450a-8fb6-27e217b60c28" />

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
python scripts/visualizations.py
```

## 📌 Author

**Ghada Fares**  
Data Engineering & Data Science Enthusiast  

[GitHub](https://github.com/GhadaFaress) | [LinkedIn](https://www.linkedin.com/in/ghada-fares-b78bb3249)
