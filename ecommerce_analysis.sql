

CREATE DATABASE ecommerce_db;

USE ecommerce_db;

SELECT TOP 10 * FROM data;
SELECT COUNT(*) AS total_records FROM data;
SELECT COUNT(DISTINCT CustomerID) AS total_customers FROM data;

ALTER TABLE data ADD InvoiceDateFixed DATETIME2;

UPDATE data SET InvoiceDateFixed = CONVERT(DATETIME2, InvoiceDate, 101);

SELECT TOP 5  InvoiceDate, InvoiceDateFixed FROM data;

SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue FROM data
WHERE Quantity > 0 AND UnitPrice > 0;

SELECT TOP 10 Description AS product_name,SUM(Quantity) AS total_units_sold,
ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue FROM data
WHERE Quantity > 0 AND Description IS NOT NULL
GROUP BY Description
ORDER BY total_units_sold DESC;

SELECT TOP 10 CustomerID,COUNT(DISTINCT InvoiceNo) AS total_orders,
SUM(Quantity) AS total_items_bought,
ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent FROM data
WHERE Quantity > 0 AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC;

SELECT TOP 10 Country,COUNT(DISTINCT CustomerID) AS total_customers,
COUNT(DISTINCT InvoiceNo) AS total_orders,
ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue FROM data
WHERE Quantity > 0
GROUP BY Country
ORDER BY total_revenue DESC;

SELECT FORMAT(InvoiceDateFixed, 'yyyy-MM') AS year_month,
COUNT(DISTINCT InvoiceNo) AS total_orders,
ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue FROM data
WHERE Quantity > 0
GROUP BY FORMAT(InvoiceDateFixed, 'yyyy-MM')
ORDER BY year_month;

SELECT COUNT(*) AS cancelled_orders,
ROUND(SUM(Quantity * UnitPrice), 2) AS revenue_lost
FROM data
WHERE InvoiceNo LIKE 'C%';

SELECT TOP 20 CustomerID,MAX(CAST(InvoiceDateFixed AS DATE)) AS last_order_date,
COUNT(DISTINCT InvoiceNo) AS order_frequency,
ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent FROM data
WHERE Quantity > 0 AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC;

SELECT CustomerID, total_spent,order_frequency,
    CASE 
        WHEN total_spent > 5000 THEN 'Gold Customer'
        WHEN total_spent > 1000 THEN 'Silver Customer'
        ELSE 'Bronze Customer'
    END AS customer_segment
FROM (
    SELECT CustomerID,COUNT(DISTINCT InvoiceNo) AS order_frequency,
        ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent FROM data
    WHERE Quantity > 0 AND CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_summary
ORDER BY total_spent DESC;

SELECT customer_segment,
COUNT(*) AS total_customers,
ROUND(AVG(total_spent), 2) AS avg_spending
FROM (
    SELECT CustomerID,
        ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent,
        CASE 
            WHEN SUM(Quantity * UnitPrice) > 5000 THEN 'Gold Customer'
            WHEN SUM(Quantity * UnitPrice) > 1000 THEN 'Silver Customer'
            ELSE 'Bronze Customer'
        END AS customer_segment
    FROM data
    WHERE Quantity > 0 AND CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS segments
GROUP BY customer_segment
ORDER BY avg_spending DESC;

SELECT ROUND(AVG(order_value), 2) AS avg_order_value
FROM (
    SELECT InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_value FROM data
    WHERE Quantity > 0
    GROUP BY InvoiceNo
) AS order_summary;

WITH CustomerRFM AS (
    SELECT CustomerID,
        MAX(CAST(InvoiceDateFixed AS DATE)) AS last_order_date,
        COUNT(DISTINCT InvoiceNo) AS order_frequency,
        ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent FROM data
    WHERE Quantity > 0 AND CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT CustomerID,last_order_date,order_frequency,total_spent,
    CASE 
        WHEN total_spent > 5000 THEN 'Gold Customer'
        WHEN total_spent > 1000 THEN 'Silver Customer'
        ELSE 'Bronze Customer'
    END AS customer_segment
FROM CustomerRFM
ORDER BY total_spent DESC;

