# /*

PROJECT: E-Commerce Data Warehouse
DATABASE: ECommerceDW
TOOLS: SQL Server / SSMS
========================

STAR SCHEMA

* FactOrderItem
* DimProduct
* DimCustomer
* DimDate
  */

-- =====================================================
-- 1. DATABASE SETUP
-- =====================================================

CREATE DATABASE ECommerceDW;
GO

USE ECommerceDW;
GO

-- =====================================================
-- 2. STAGING TABLE: INSPECT SOURCE DATA
-- Source columns:
-- InvoiceNo, StockCode, Description, Quantity,
-- InvoiceDate, UnitPrice, CustomerID, Country
-- =====================================================

SELECT TOP 10 *
FROM dbo.stg_ECommerce;

-- Check total number of staging records
SELECT COUNT(*) AS TotalStagingRows
FROM dbo.stg_ECommerce;

-- Check missing values in important columns
SELECT
SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS MissingInvoiceNo,
SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) AS MissingStockCode,
SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) AS MissingInvoiceDate,
SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS MissingQuantity,
SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS MissingUnitPrice,
SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS MissingCustomerID
FROM dbo.stg_ECommerce;

-- Inspect negative quantities
SELECT *
FROM dbo.stg_ECommerce
WHERE Quantity < 0;

-- Inspect negative or zero unit prices
SELECT *
FROM dbo.stg_ECommerce
WHERE UnitPrice <= 0;

-- Check distinct invoices
SELECT COUNT(DISTINCT InvoiceNo) AS TotalDistinctInvoices
FROM dbo.stg_ECommerce;

-- Check distinct customers
SELECT COUNT(DISTINCT CustomerID) AS TotalDistinctCustomers
FROM dbo.stg_ECommerce;

-- =====================================================
-- 3. DIMENSION TABLE VALIDATION
-- =====================================================

-- Check products
SELECT COUNT(*) AS TotalProducts
FROM dbo.DimProduct;

SELECT TOP 10 *
FROM dbo.DimProduct;

-- Check customers
SELECT COUNT(*) AS TotalCustomers
FROM dbo.DimCustomer;

SELECT TOP 10 *
FROM dbo.DimCustomer;

-- Check dates
SELECT COUNT(*) AS TotalDates
FROM dbo.DimDate;

SELECT MIN(FullDate) AS FirstDate,
MAX(FullDate) AS LastDate
FROM dbo.DimDate;

-- =====================================================
-- 4. FACT TABLE VALIDATION
-- =====================================================

SELECT COUNT(*) AS TotalFactRows
FROM dbo.FactOrderItem;

SELECT
SUM(Quantity) AS TotalQuantity,
SUM(TotalSales) AS TotalRecordedRevenue,
COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM dbo.FactOrderItem;

-- Check fact rows without a matched customer
SELECT COUNT(*) AS RowsWithoutCustomer
FROM dbo.FactOrderItem
WHERE CustomerKey IS NULL;

-- Check whether fact rows have missing product or date keys
SELECT
SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS MissingProductKey,
SUM(CASE WHEN DateKey IS NULL THEN 1 ELSE 0 END) AS MissingDateKey
FROM dbo.FactOrderItem;

-- =====================================================
-- 5. REVENUE VALIDATION
-- TotalSales should equal Quantity * UnitPrice
-- =====================================================

SELECT
SUM(Quantity * UnitPrice) AS CalculatedRevenue
FROM dbo.FactOrderItem;

SELECT
SUM(TotalSales) AS RecordedRevenue
FROM dbo.FactOrderItem;

-- =====================================================
-- 6. BUSINESS ANALYSIS QUERIES
-- =====================================================

-- Revenue by country
SELECT
c.Country,
SUM(f.TotalSales) AS TotalRevenue
FROM dbo.FactOrderItem AS f
LEFT JOIN dbo.DimCustomer AS c
ON f.CustomerKey = c.CustomerKey
GROUP BY c.Country
ORDER BY TotalRevenue DESC;

-- Revenue by product
SELECT
p.StockCode,
p.Description,
SUM(f.TotalSales) AS TotalRevenue
FROM dbo.FactOrderItem AS f
JOIN dbo.DimProduct AS p
ON f.ProductKey = p.ProductKey
GROUP BY p.StockCode, p.Description
ORDER BY TotalRevenue DESC;

-- Revenue over time
SELECT
d.FullDate,
SUM(f.TotalSales) AS DailyRevenue
FROM dbo.FactOrderItem AS f
JOIN dbo.DimDate AS d
ON f.DateKey = d.DateKey
GROUP BY d.FullDate
ORDER BY d.FullDate;

-- Revenue by month
SELECT
d.Year,
d.Month,
d.MonthName,
SUM(f.TotalSales) AS MonthlyRevenue
FROM dbo.FactOrderItem AS f
JOIN dbo.DimDate AS d
ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

# /*

# END OF PROJECT SQL DOCUMENTATION

IMPORTANT:
The dimension and fact tables already exist in the
completed project. Verify their definitions before
adding any CREATE TABLE or INSERT statements.

Revenue and quantity totals include negative records
if those records remain in the source data.
*/
