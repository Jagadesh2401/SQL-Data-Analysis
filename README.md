# SQL for Data Analysis  
**Data Analyst Internship Project**

## 🧾 Project Overview

This project is part of my **Data Analyst Internship – Task 3: SQL for Data Analysis**.  
The goal is to use **SQL** to query, analyze, and extract insights from an **E-Commerce relational database**.

The database contains multiple related tables:

- `customers`
- `products`
- `orders`
- `order_items`
- `payments`

Using this data, I applied core SQL concepts like **SELECT, WHERE, ORDER BY, GROUP BY, JOINS, subqueries, views, and indexes**.

---

## 🛠 Tools & Technologies

- **Database:** MySQL (InnoDB)
- **Client:** MySQL Workbench / VS Code SQLTools
- **Language:** SQL
- **Version Control:** Git & GitHub

---

## 📂 Project Structure

```bash
Task-3-SQL-Data-Analysis/
│
├── sql/
│   └── ecommerce_analysis.sql        # All SQL queries (DDL + DML + analysis)
│
├── dataset/
│   ├── Ecommerce_SQL_customers.csv 
│   ├── Ecommerce_SQL_products.csv   
│   ├── Ecommerce_SQL_oders.csv
│   ├── Ecommerce_SQL_oder_items.csv
│   ├── Ecommerce_SQL_payments.csv
│   └── SQL_queries dataset/
│       ├── Ecommerce_SQL_INNER_JOIN.csv
│       ├── Ecommerce_SQL_LEFT JOIN.csv
│       ├── Ecommerce_SQL_RIGHT_JOIN.csv
│       └── Ecommerce_SQL_SELECT.csv
├── screenshots/                      
│   ├── (Your 7 screenshots here)
│
└── README.md                         

Database Schema

1. customers
  Stores customer information.

  Column	Type	Description
  customer_id	INT PK, AI	Unique customer ID
  first_name	VARCHAR(50)	First name
  last_name	VARCHAR(50)	Last name
  email	VARCHAR(100)	Unique email
  city	VARCHAR(50)	City
  country	VARCHAR(50)	Country
  created_at	DATE	Registration date
  
2. products
  Stores product catalog.

  Column	Type	Description
  product_id	INT PK, AI	Unique product ID
  product_name	VARCHAR(100)	Name of product
  category	VARCHAR(50)	Product category
  unit_price	DECIMAL(10,2)	Unit price

3. orders
  Stores customer orders.

  Column	Type	Description
  order_id	INT PK, AI	Unique order ID
  customer_id	INT FK	References customers
  order_date	DATE	Date of order
  status	VARCHAR(20)	Completed/Pending/etc

4. order_items
  Line items per order.

  Column	Type	Description
  order_item_id	INT PK, AI	Unique line item ID
  order_id	INT FK	References orders
  product_id	INT FK	References products
  quantity	INT	Quantity purchased
  price	DECIMAL(10,2)	Price at time of order

5. payments
  Payment details per order.

  Column	Type	Description
  payment_id	INT PK, AI	Unique payment ID
  order_id	INT FK	References orders
  amount	DECIMAL(10,2)	Paid amount
  payment_date	DATE	Payment date
  payment_method	VARCHAR(20)	Card/UPI/COD/etc

🧪 SQL Concepts Covered
  This project demonstrates:

    SELECT, WHERE, ORDER BY

    GROUP BY, HAVING

    INNER JOIN, LEFT JOIN, RIGHT JOIN

    Aggregate functions: SUM, AVG, COUNT, MAX, MIN

    Subqueries (nested queries)

    Views (CREATE VIEW, OR REPLACE VIEW)

Index optimization (CREATE INDEX)

🔍 Sample Queries Used
  1️⃣ Basic SELECT + WHERE + ORDER BY
  Get customers from India, ordered by city:

    sql
    SELECT first_name, last_name, city, country
    FROM customers
    WHERE country = 'India'
    ORDER BY city ASC;
  2️⃣ INNER JOIN (Orders + Customers + Products)
  Show orders with customer names and product details:

    sql
    SELECT 
        o.order_id,
        o.order_date,
        c.first_name,
        c.last_name,
        p.product_name,
          oi.quantity,
      oi.price
    FROM orders o
    INNER JOIN customers c ON o.customer_id = c.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    INNER JOIN products p ON p.product_id = oi.product_id
    ORDER BY o.order_id;
  3️⃣ LEFT JOIN (Customers with/without orders)
    sql

    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        o.order_id
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    ORDER BY c.customer_id;
  4️⃣ RIGHT JOIN (Products with/without order items)
    sql
    SELECT 
        p.product_id,
        p.product_name,
        oi.order_id
    FROM order_items oi
    RIGHT JOIN products p ON p.product_id = oi.product_id
    ORDER BY p.product_id;
  5️⃣ GROUP BY + Aggregate (Revenue by Category)
    sql
    SELECT 
        p.category,
    SUM(oi.quantity * oi.price) AS total_revenue
    FROM order_items oi
    INNER JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.category
    ORDER BY total_revenue DESC;
  6️⃣ Subquery – Top 5 Customers by Spend
    sql
    SELECT customer_id, total_spent
    FROM (
        SELECT 
            o.customer_id,
        SUM(oi.price * oi.quantity) AS total_spent
        FROM orders o
        INNER JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY o.customer_id
        ) AS t
        ORDER BY total_spent DESC
        LIMIT 5;
  7️⃣ View – Customer Revenue View
    sql
    CREATE OR REPLACE VIEW customer_revenue AS
    SELECT 
        c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer,
    SUM(oi.price * oi.quantity) AS revenue
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id;
  View usage:

    sql
    SELECT * 
    FROM customer_revenue
    ORDER BY revenue DESC
    LIMIT 10;
  8️⃣ Index Optimization
    sql
    CREATE INDEX idx_customers_city ON customers(city);
    CREATE INDEX idx_orders_customer ON orders(customer_id);
    CREATE INDEX idx_orderitems_order ON order_items(order_id);
    These indexes help speed up frequent queries involving filtering and joins on those columns.

📸 Screenshots (Proof of Work)
  The screenshots/ folder contains:

    01_customers_preview.png – First few rows from customers

    02_filter_indian_customers.png – SELECT + WHERE + ORDER BY

    03_top_products_by_price.png – ORDER BY on products

    04_join_orders_customers_products.png – INNER JOIN output

    05_revenue_by_category.png – GROUP BY + aggregate result

    06_top_spending_customers.png – Subquery result

    07_view_customer_revenue.png – View query output

🧠 SQL Interview Topics Covered
  This project helps answer:

    Difference between WHERE and HAVING

    WHERE filters rows before grouping

    HAVING filters groups after GROUP BY

  Types of Joins

    INNER JOIN – matching rows in both tables

    LEFT JOIN – all rows from left table + matches from right

    RIGHT JOIN – all rows from right table + matches from left

  Average Revenue Per User (ARPU)

    Example:

    sql
    SELECT 
        SUM(oi.price * oi.quantity) / COUNT(DISTINCT o.customer_id) AS arpu
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id;

🚀 How to Run
  Start MySQL Server

  Open MySQL Workbench or VS Code SQLTools

  Run:

    sql
    CREATE DATABASE IF NOT EXISTS ecommerce_db;
    USE ecommerce_db;
    Execute all statements from:

    text
    sql/ecommerce_analysis.sql
    Run the analysis queries and compare with screenshots.

📥 Dataset
  A synthetic E-Commerce dataset was created manually using SQL INSERT statements for learning and analysis purposes.
  It simulates real-world customers, products, orders, and payment patterns.

👤 Author
  Name: Damarasingu Jagadesh
  Role: Data Analyst Intern
