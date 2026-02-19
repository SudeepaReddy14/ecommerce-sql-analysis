# E-Commerce SQL Analysis

## Project Overview
Analyzed 541,909 e-commerce transactions using SQL Server (SSMS) to identify top customers, revenue trends, and customer segments.

## Key Findings
- **Total Revenue:** $9.7M across all transactions
- **Top Customer:** Customer #14646 spent $279K
- **Customer Segments:** 
  - Gold: 45 customers (1%) generate 40% of revenue
  - Silver: 320 customers (7%)
  - Bronze: 3,950 customers (92%)
- **Top Country:** UK generates 90%+ of revenue
- **Cancellation Rate:** 3% of orders cancelled
- **Peak Month:** November shows highest sales

## Analysis Results

### 1. Total Records
![Total Records](_total_records.png)

### 2. Total Revenue
![Total Revenue](02_total_revenue.png)

### 3. Top 10 Best Selling Products
![Top Products](03_top_products.png)

### 4. Top 10 Most Valuable Customers
![Top Customers](04_top_customers.png)

### 5. Revenue by Country
![Revenue by Country](05_revenue_by_country.png)

### 6. Monthly Revenue Trend
![Monthly Trend](06_monthly_trend.png)

### 7. Cancelled Orders Analysis
![Cancelled Orders](07_cancelled_orders.png)

### 8. RFM Analysis (Recency, Frequency, Monetary)
![RFM Analysis](08_rfm_analysis.png)

### 9. Customer Segmentation
![Customer Segments](09_customer_segments.png)

### 10. Segment Distribution
![Segment Count](10_segment_count.png)

### 11. Average Order Value
![Average Order Value](11_avg_order_value.png)

## SQL Concepts Used
- Aggregations (SUM, COUNT, AVG, ROUND)
- GROUP BY & HAVING clauses
- CTEs (Common Table Expressions)
- Subqueries
- CASE WHEN statements
- Window functions
- Date formatting (FORMAT function)
- String pattern matching (LIKE operator)

## Business Insights
1. **Pareto Principle:** Small customer base drives majority of revenue
2. **Customer Segmentation:** Enables targeted marketing strategies
3. **Seasonal Trends:** November shows peak sales (holiday shopping)
4. **Geographic Focus:** UK market dominates, expansion opportunities exist
5. **Retention Opportunity:** Low-price items have higher return rates

## Tools Used
- SQL Server Management Studio (SSMS)
- Microsoft SQL Server
- T-SQL (Transact-SQL)

## Dataset
**Source:** Kaggle - E-Commerce Data  
**Size:** 541,909 transactions  
**Period:** December 2010 - December 2011  
**Regions:** 38 countries
