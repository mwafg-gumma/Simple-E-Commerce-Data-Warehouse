# SQL Server – E-Commerce Data Warehouse

This folder contains the SQL scripts used to build and validate the E-Commerce Data Warehouse project using Microsoft SQL Server.

## Project Tasks

* Create the staging table to load the source e-commerce data.
* Design the Star Schema for analytical reporting.
* Create dimension tables: `DimProduct`, `DimCustomer`, and `DimDate`.
* Create the fact table: `FactOrderItem`.
* Load data from the staging table into the dimension and fact tables.
* Establish relationships between the fact and dimension tables.
* Validate row counts, quantities, and recorded revenue.

## Tools Used

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* SQL (T-SQL)

## Data Model

The warehouse follows a Star Schema, with `FactOrderItem` at the center and the dimension tables connected to it.

## Purpose

The goal is to transform raw e-commerce transaction data into a structured data warehouse that supports business analysis and interactive reporting in Power BI.
