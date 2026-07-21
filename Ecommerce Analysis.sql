SET GLOBAL local_infile = 1;
USE ecommerce_analysis;
TRUNCATE TABLE transactions;
LOAD DATA LOCAL INFILE 'C:/Users/sirig/Downloads/Cleaned_Data (1).csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country, Revenue);
SHOW WARNINGS;
SELECT ROUND(SUM(Revenue), 2) AS Total_Revenue, COUNT(*) AS Total_Rows
FROM transactions;
SELECT InvoiceDate FROM transactions LIMIT 5;


-- Revenue by country
SELECT Country, ROUND(SUM(Revenue), 2) AS Country_Revenue
FROM transactions
GROUP BY Country
ORDER BY Country_Revenue DESC;

-- UK's % of total revenue
SELECT 
  ROUND(SUM(CASE WHEN Country = 'United Kingdom' THEN Revenue ELSE 0 END) / SUM(Revenue) * 100, 1) AS UK_Percent
FROM transactions;

-- Top 10 customers by revenue
SELECT CustomerID, ROUND(SUM(Revenue), 2) AS Customer_Revenue
FROM transactions
GROUP BY CustomerID
ORDER BY Customer_Revenue DESC
LIMIT 10;

-- Top 10 products by revenue
SELECT Description, ROUND(SUM(Revenue), 2) AS Product_Revenue
FROM transactions
GROUP BY Description
ORDER BY Product_Revenue DESC
LIMIT 10;

-- Average order value
SELECT ROUND(AVG(Revenue), 2) AS Avg_Order_Value FROM transactions;

-- Monthly trend
SELECT 
  DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
  ROUND(SUM(Revenue), 2) AS Monthly_Revenue,
  ROUND(SUM(SUM(Revenue)) OVER (ORDER BY DATE_FORMAT(InvoiceDate, '%Y-%m')), 2) AS Running_Total
FROM transactions
GROUP BY Month
ORDER BY Month;