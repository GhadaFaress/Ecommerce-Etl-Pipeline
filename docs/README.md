# 📐 E-Commerce ETL Pipeline - Diagrams & Documentation

This folder contains all architectural and data modeling diagrams for the E-Commerce ETL pipeline project.

## 📊 Available Diagrams

### 1. [Architecture Diagram](./architecture_diagram.md)
**Overview**: Complete ETL pipeline flow from source to analytics

Shows the full data journey:
- CSV files → Python Extract → PostgreSQL → Snowflake → dbt → Analytics
- All pipeline stages and technologies used
- Data flow between systems

**Use this to**: Understand the overall system architecture

---

### 2. [Star Schema Diagram](./star_schema_diagram.md)
**Overview**: Analytics layer data model (dimensional modeling)

Shows:
- 3 Dimension tables: Customers, Products, Sellers
- 2 Fact tables: Orders (aggregated), Order Items (granular)
- Relationships and foreign keys
- All columns and data types

**Use this to**: Understand the final analytics data model

---

## 🖼️ How to View

These diagrams use **Mermaid** syntax, which renders automatically on:
- ✅ GitHub
- ✅ GitLab  
- ✅ VS Code (with Mermaid extension)
- ✅ Notion
- ✅ Obsidian

 open the `.md` files and the diagrams will display 
 
---
