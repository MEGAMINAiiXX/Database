DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    region VARCHAR(50) NOT NULL,
    sale_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO sales (product, amount, region) VALUES
('Laptop', 1200.00, 'North'),
('Phone', 800.50, 'South'),
('Laptop', 1100.00, 'North'),
('Mouse', 25.99, 'South'),
('Keyboard', 79.99, 'North'),
('Phone', 850.00, 'North'),
('Laptop', 950.00, 'South');

SELECT * FROM sales;

SELECT 
    COUNT(*) AS total_sales,
    COUNT(DISTINCT product) AS unique_products,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_sale,
    MAX(amount) AS max_sale,
    MIN(amount) AS min_sale
FROM sales;

SELECT 
    region,
    COUNT(*) AS sales_count,
    SUM(amount) AS revenue,
    AVG(amount) AS avg_amount,
    ROUND(AVG(amount), 2) AS rounded_avg
FROM sales
GROUP BY region
ORDER BY revenue DESC;

SELECT 
    product,
    COUNT(*) AS sales_count,
    SUM(amount) AS total_revenue
FROM sales
GROUP BY product
HAVING COUNT(*) >= 2
ORDER BY total_revenue DESC;

SELECT 
    region,
    STRING_AGG(product, ', ') AS products_sold
FROM sales
GROUP BY region;

SELECT 
    sale_date,
    COUNT(*) AS daily_sales,
    SUM(amount) AS daily_revenue
FROM sales
GROUP BY sale_date
ORDER BY sale_date;