DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS course_enrollments;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,         
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0)
);

INSERT INTO products (name, price) VALUES
('Laptop', 999.99),
('Mouse', 25.99),
('Keyboard', 79.99);

SELECT * FROM products;

CREATE TABLE orders (
    order_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(12,2) NOT NULL
);

INSERT INTO orders (customer_name, amount) VALUES
('Avin', 1500.00),
('Beka', 800.50);

SELECT * FROM orders;

CREATE TABLE course_enrollments (
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    semester VARCHAR(20) NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id, semester) 
);

INSERT INTO course_enrollments (student_id, course_id, semester, grade) VALUES
(1, 101, '2024-Spring', 'A'),
(1, 102, '2024-Spring', 'B+'),
(2, 101, '2024-Spring', 'A-');

SELECT * FROM course_enrollments;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    dept_id INTEGER,
    dept_name VARCHAR(100) NOT NULL
);

ALTER TABLE departments ADD PRIMARY KEY (dept_id);

\d departments