# E-Commerce Customer Behaviour Analysis — Excel & SQL

## 📌 Project Overview
This project analyzes customer purchasing behavior for an e-commerce business using **397,884 cleaned transactions** (from 541,909 raw records) spanning **37 countries**. The analysis was built twice — once as an interactive Excel dashboard, and once independently in SQL — to validate findings across both tools and demonstrate end-to-end analytical rigor.

The project delivers insights into:
- Customer purchasing patterns and segmentation
- Revenue performance and country-wise contribution
- Top-performing products and customers
- Order distribution and monthly revenue trends

The goal is to support business decision-making through data visualization (Excel) and independently verified query-based analysis (SQL).

---

## 🛠 Tools & Technologies Used
- **Microsoft Excel** — Pivot Tables, Pivot Charts, Slicers, Conditional Formatting, Data Cleaning & Transformation, Excel Formulas
- **MySQL** — Data import (`LOAD DATA INFILE`), aggregate queries, `GROUP BY`, `CASE WHEN` logic, window functions

---

## 📊 Dashboard Features (Excel)

### 🔹 KPI Cards
- Total Revenue
- Total Orders
- Total Customers
- Average Order Value

### 🔹 Revenue Analysis
- Revenue by Country
- Top 10 Products by Revenue
- Top 10 Customers by Revenue

### 🔹 Customer Behaviour Analysis
Customer segmentation (RFM-based) across six categories:
- Champions
- Loyal Customers
- High Spenders
- Frequent Buyers
- Potential Loyalists
- Regular Customers

### 🔹 Order Analysis
- Orders by Country
- Country-wise sales performance
- Revenue contribution analysis

---

## 🗄️ SQL Analysis

To validate the Excel dashboard independently, the same cleaned dataset was loaded into MySQL and re-analyzed using SQL. Key queries include:

- Total revenue and order volume validation
- Revenue by country (`GROUP BY`, `ORDER BY`)
- UK revenue share (`CASE WHEN` conditional aggregation)
- Top 10 customers and top 10 products by revenue
- Average order value
- Monthly revenue trend with **running total using a window function** (`SUM() OVER`)

Full query file: [`Ecommerce Analysis.sql`](./Ecommerce Analysis.sql

**Sample query — monthly revenue trend with running total:**
```sql
SELECT 
  DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
  ROUND(SUM(Revenue), 2) AS Monthly_Revenue,
  ROUND(SUM(SUM(Revenue)) OVER (ORDER BY DATE_FORMAT(InvoiceDate, '%Y-%m')), 2) AS Running_Total
FROM transactions
GROUP BY Month
ORDER BY Month;
```

---

## 📈 Key Insights
- **United Kingdom** generated the highest revenue contribution — **82.0%** of total revenue, validated via SQL cross-check against the Excel dashboard.
- A small group of customers contributed disproportionately to revenue — the top 10 customers alone account for over **£1.5M** of the £8.9M total.
- Certain products consistently dominated sales — "Paper Craft, Little Birdie" and "Regency Cakestand 3 Tier" were the top two by revenue.
- **Champions** and **Loyal Customers** formed the highest-value segments despite not being the largest in volume.
- Revenue contribution varied significantly across the remaining 36 countries, led by Netherlands, EIRE, and Germany.

---

## 🔍 Data Quality Fix (Found During SQL Validation)
While cross-validating the Excel dashboard in SQL, invoice dates were found stored in two inconsistent formats within the source data — some as Excel date-serial numbers, others as text strings (`MM/DD/YYYY HH:MM`). This caused ~56% of revenue to be misclassified under an invalid date bucket during initial import. The formats were standardized before final analysis, and the resulting monthly revenue trend was verified to sum exactly to the total dataset revenue (£8,911,407.90) across all 397,884 rows.

---

## 🧠 Skills Demonstrated
- Dashboard Design in Excel
- Pivot Table Analysis & Interactive Slicers
- SQL: `GROUP BY`, `CASE WHEN`, subqueries, window functions
- Data Import & Cleaning (`LOAD DATA INFILE`, format standardization)
- Cross-tool Validation (Excel ↔ SQL)
- Customer Segmentation (RFM)
- KPI Development & Data Visualization
- Business Storytelling & Analytical Reporting

---


![Dashboard Preview](Dashboard.png)

---


## 🚀 Business Value
This project helps businesses:
- Identify and prioritize high-value customers
- Understand purchasing behavior and seasonality
- Monitor regional sales performance
- Improve customer retention through segmentation
- Track product-level performance
- Trust their reporting — since findings were independently verified across two tools, catching a real calculation error in the process

---

