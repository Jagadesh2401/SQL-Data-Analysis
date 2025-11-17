USE ecommerce_db;
SELECT first_name, last_name, city, country
FROM customers
WHERE country = 'India'
ORDER BY city ASC;

SELECT o.order_id, c.first_name, p.product_name, oi.quantity, oi.price
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON p.product_id = oi.product_id;

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT p.product_id, p.product_name, oi.order_id
FROM order_items oi
RIGHT JOIN products p ON p.product_id = oi.product_id
ORDER BY p.product_id;

SELECT p.category, SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT customer_id, total_spent
FROM (
    SELECT o.customer_id, SUM(oi.price * oi.quantity) AS total_spent
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
) AS t
ORDER BY total_spent DESC
LIMIT 5;

CREATE OR REPLACE VIEW customer_revenue AS
SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS customer,
       SUM(oi.price * oi.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id;

CREATE INDEX idx_customers_city ON customers(city);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orderitems_order ON order_items(order_id);





