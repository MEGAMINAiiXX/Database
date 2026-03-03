DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO customers (name, city) VALUES
('Avin', 'Bishkek'),
('Beka', 'Osh'),
('Alymbek', 'Bishkek'),
('Meerim', 'Jalal-Abad');

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders (customer_id, total_amount) VALUES
(1, 1500.00),  -- Avin
(1, 800.50),   -- Avin
(2, 1200.00),  -- Beka
(4, 500.00);   -- Meerim (нет заказа у Alymbek)

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product VARCHAR(100) NOT NULL,
    quantity INTEGER,
    price DECIMAL(8,2)
);

INSERT INTO order_items (order_id, product, quantity, price) VALUES
(1, 'Laptop', 1, 1200.00),
(1, 'Mouse', 2, 25.99),
(2, 'Phone', 1, 800.50),
(3, 'Tablet', 1, 600.00),
(4, 'Headphones', 1, 150.00);

SELECT 'Customers:' AS table_name; SELECT * FROM customers;
SELECT 'Orders:' AS table_name; SELECT * FROM orders;
SELECT 'Order Items:' AS table_name; SELECT * FROM order_items;

SELECT c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.name, o.order_id, o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.name, o.order_id, o.total_amount
FROM customers c
FULL JOIN orders o ON c.customer_id = o.customer_id;

SELECT 
    c.name AS customer,
    o.order_id,
    SUM(oi.quantity * oi.price) AS order_total_items
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.name, o.order_id;

SELECT 
    c1.name AS customer1,
    c2.name AS customer2,
    c1.city
FROM customers c1
JOIN customers c2 ON c1.city = c2.city AND c1.customer_id < c2.customer_id;