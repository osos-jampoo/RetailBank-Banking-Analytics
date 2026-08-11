# 🏦 RetailBank – Banking Analytics

## 📌 Project Overview

RetailBank – Banking Analytics is an end-to-end Business Intelligence project built using SQL Server and Power BI.

The project transforms raw banking data into a structured Data Warehouse and an interactive dashboard to provide meaningful insights into customers, merchants, and transactions.

---

## 🎯 Project Objective

The main objective of this project is to:

- Build a structured Banking Data Warehouse.
- Apply Medallion Architecture.
- Perform data cleaning and validation.
- Transform raw data into analytical tables.
- Build a data model suitable for Business Intelligence.
- Create an interactive Power BI dashboard.
- Generate meaningful business insights.

---

## 🏗️ Architecture

The project follows a Medallion Architecture:

**Raw Data → Bronze → Silver → Gold → Power BI → Business Insights**

### Bronze Layer
Contains the raw banking data.

### Silver Layer
Contains cleaned and transformed data.

### Gold Layer
Contains business-ready analytical tables used for reporting and analysis.

---

## 📊 Power BI Dashboard

The final dashboard contains four main analytical pages:

### Executive Overview
Provides a high-level overview of banking performance and key KPIs.

### Customer Analytics
Analyzes customer distribution, spending, and transaction behavior.

### Merchant Analytics
Analyzes merchant performance, transaction activity, and merchant categories.

### Transaction Analytics
Analyzes transaction trends, amounts, categories, and transaction activity.

---

## 🛠️ Tools & Technologies

- SQL Server
- SQL
- Power BI
- DAX
- Power Query
- Data Modeling
- Star Schema
- Medallion Architecture

---

## 📈 Key Analytics

The dashboard provides insights into:

- Total Customers
- Total Merchants
- Total Transactions
- Total Amount
- Average Transaction
- Average Customer Spend
- Transactions per Customer
- Transactions per Merchant
- Monthly Transaction Trends
- Monthly Amount Trends
- Customer Segmentation
- Merchant Performance
- Transaction Categories

---

## 📚 Learning Outcomes

This project was an important learning experience because I expanded my skills beyond dashboard development.

I learned how to work with **SQL Server and Data Warehousing concepts**, starting from raw data and moving through data validation, transformation, modeling, and finally connecting the analytical model to Power BI.

The project helped me understand the complete journey:

**Data → Data Warehouse → Data Model → Analysis → Business Intelligence**

---

## 📁 Project Structure

```text
RetailBank-Banking-Analytics/
│
├── README.md
│
├── RetailBankDWH.sql
│
├── Dashboard sprint 3.pbix
│
└── photos/
    ├── Executive Overview
    ├── Customer Analytics
    ├── Merchant Analytics
    └── Transaction Analytics
