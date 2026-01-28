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

### 3. [ERD Diagram](./erd_diagram.md)
**Overview**: Complete entity-relationship diagram across all layers

Shows:
- **Raw Layer**: 7 source tables from CSV
- **Staging Layer**: 5 transformed staging models
- **Analytics Layer**: Star schema (3 dims + 2 facts)
- All relationships and cardinality
- Complete data lineage

**Use this to**: See the complete data transformation journey

---

## 🎯 Quick Reference

| Diagram | Purpose | Best For |
|---------|---------|----------|
| **Architecture** | System overview | Understanding tech stack & data flow |
| **Star Schema** | Analytics data model | Writing queries, BI tools |
| **ERD** | Complete data lineage | Understanding transformations |

---

## 🖼️ How to View

These diagrams use **Mermaid** syntax, which renders automatically on:
- ✅ GitHub
- ✅ GitLab  
- ✅ VS Code (with Mermaid extension)
- ✅ Notion
- ✅ Obsidian

Just open the `.md` files and the diagrams will display beautifully!

---

## 📝 Diagram Updates

When updating the data model:
1. Update the relevant SQL models in `ecommerce_dbt/models/`
2. Update the corresponding diagram in this folder
3. Run dbt tests to ensure integrity
4. Commit both code and diagram changes together

---

## 🔗 Related Files

- **dbt Models**: `../ecommerce_dbt/models/`
- **Python Scripts**: `../scripts/`
- **SQL Queries**: `../sql/`
- **Main README**: `../README.md`

