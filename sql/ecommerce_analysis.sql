/* Create Database */
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

/* Drop old tables */
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

/* Create Tables */

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    email       VARCHAR(100),
    city        VARCHAR(50),
    country     VARCHAR(50),
    created_at  DATE
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category     VARCHAR(50),
    unit_price   DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id    INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date  DATE,
    status      VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id      INT,
    product_id    INT,
    quantity      INT,
    price         DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id     INT PRIMARY KEY AUTO_INCREMENT,
    order_id       INT,
    amount         DECIMAL(10,2),
    payment_date   DATE,
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

/* Insert Sample Data */

INSERT INTO customers (first_name, last_name, email, city, country, created_at) VALUES
('Rahul', 'Verma', 'rahul@example.com', 'Delhi', 'India', '2024-01-05'),
('Aisha', 'Khan', 'aisha@example.com', 'Mumbai', 'India', '2024-02-10'),
('John', 'Carter', 'john@example.com', 'New York', 'USA', '2024-03-15'),
('Emily', 'Stone', 'emily@example.com', 'London', 'UK', '2024-04-01'),
('David', 'Lee', 'david@example.com', 'Sydney', 'Australia', '2024-04-12');

INSERT INTO products (product_name, category, unit_price) VALUES
('Smartphone X', 'Electronics', 599.99),
('Laptop Pro', 'Electronics', 1099.50),
('Wireless Earbuds', 'Accessories', 79.90),
('Office Chair', 'Furniture', 159.49),
('Water Bottle', 'Accessories', 12.99);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-03-01', 'Completed'),
(2, '2024-03-05', 'Completed'),
(1, '2024-03-10', 'Completed'),
(4, '2024-03-11', 'Pending'),
(3, '2024-03-12', 'Completed');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 599.99),
(1, 3, 2, 79.90),
(2, 2, 1, 1099.50),
(3, 5, 5, 12.99),
(4, 4, 1, 159.49),
(5, 1, 1, 599.99);

INSERT INTO payments (order_id, amount, payment_date, payment_method) VALUES
(1, 759.79, '2024-03-01', 'Card'),
(2, 1099.50, '2024-03-05', 'UPI'),
(3, 64.95, '2024-03-10', 'Card'),
(5, 599.99, '2024-03-12', 'Card');

/* View data */
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
