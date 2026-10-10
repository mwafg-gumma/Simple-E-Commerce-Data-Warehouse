# E-Commerce Data Warehouse & Power BI Dashboard

## Project Overview

This project focuses on building an end-to-end E-Commerce Data Warehouse using Microsoft SQL Server and creating an interactive Power BI dashboard to analyze sales performance

The project transforms raw e-commerce transaction data into a structured data warehouse using a Star Schema, making the data easier to analyze and visualize

## Project Objectives

* Load raw e-commerce data into SQL Server
* Design and implement a Star Schema
* Create dimension and fact tables
* Perform data validation using SQL queries
* Build an interactive Power BI dashboard
* Analyze revenue, quantity, orders, products, countries, and sales trends over time

## Tools & Technologies

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* T-SQL
* Microsoft Power BI Desktop
* DAX
* Data Modeling and Data Visualization

## Data Warehouse Design

The warehouse follows a Star Schema with one central fact table connected to three dimension tables

**Fact Table**

* `FactOrderItem`

**Dimension Tables**

* `DimProduct`
* `DimCustomer`
* `DimDate`

## Dataset Information

The project uses e-commerce transaction data containing invoice numbers, product codes, product descriptions, quantities, invoice dates, unit prices, customer IDs, and countries

* **Staging Records:** 541,909
* **Product Records:** 3,958
* **Customer Records:** 4,372
* **Date Records:** 305
* **Fact Records:** 541,909

## Power BI Dashboard

The dashboard provides interactive analysis through KPI cards, charts, and slicers

Key metrics and visualizations include:

* Total Revenue
* Total Quantity
* Total Orders
* Revenue by Country
* Revenue by Product
* Revenue Over Time
* Revenue by Month
* Date and Country Filters

## Project Structure

* `SQL/` — SQL scripts and data warehouse documentation
* `PowerBI/` — Power BI report documentation and dashboard files
* `Images/` — Dashboard screenshots and project visuals

## Key Learning Outcomes

* Understanding ETL and data loading
* Designing fact and dimension tables
* Implementing a Star Schema
* Writing SQL queries for data validation
* Creating DAX measures
* Building interactive Power BI reports


