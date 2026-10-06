# 🛒 Olist E-Commerce: Data Engineering to Insights

An end-to-end Data Engineering and Analytics project building a **Medallion Data Warehouse** and business dashboards using the Olist E-commerce dataset.

> 🛠️ **Status:** Project Initialization & Setup (Work in Progress)

---

## 🎯 Project Overview

This project transforms raw e-commerce data into structured analytical models to solve real-world business problems:

1. **Data Warehouse (Medallion Architecture):** Loading raw CSVs into Bronze, cleansing in Silver, and building Star Schema views in Gold.
2. **Exploratory Data Analysis (EDA):** Identifying overall order, customer, and revenue trends using SQL.
3. **Problem-Centric Analytics:** Solving specific e-commerce bottlenecks (e.g., delivery delays and customer churn) using SQL and Power BI dashboards.

---

## 📁 Repository Structure

```text
data-engineering-to-insights/
├── dataset/             # Olist Kaggle dataset reference & links
├── docs/                # Architecture diagrams & ERD models
├── SQL_script/          # Medallion Architecture scripts (Bronze -> Silver -> Gold)
├── EDA/                 # Descriptive exploratory SQL queries
├── Data_analysis_SQL/   # SQL solutions for business problem statements
├── Problem_statements/ # Diagnostic frameworks & 15-question problem sets
└── Dashboards/          # Power BI (.pbix) reports & visual exports
