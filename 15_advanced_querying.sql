DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    manager_id INTEGER REFERENCES employees(emp_id),
    department VARCHAR(50)
);

INSERT INTO employees (name, salary, manager_id, department) VALUES
('CEO', 20000, NULL, 'Executive'),
('Manager IT', 12000, 1, 'IT'),
('Manager Sales', 11000, 1, 'Sales'),
('Dev1', 8000, 2, 'IT'),
('Dev2', 7500, 2, 'IT'),
('Sales1', 6000, 3, 'Sales'),
('Sales2', 5800, 3, 'Sales');

SELECT * FROM employees;

SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

WITH dept_avg AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.name, e.department, e.salary, da.avg_salary
FROM employees e
JOIN dept_avg da ON e.department = da.department
WHERE e.salary > da.avg_salary;

WITH RECURSIVE hierarchy AS (
    SELECT 
        emp_id, 
        name, 
        manager_id, 
        name::text AS path,  
        1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.emp_id, 
        e.name, 
        e.manager_id, 
        h.path || ' → ' || e.name, 
        h.level + 1
    FROM employees e
    JOIN hierarchy h ON e.manager_id = h.emp_id
)
SELECT 
    name, 
    path, 
    level
FROM hierarchy
ORDER BY level, name;

SELECT 
    name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_in_dept,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS overall_rank
FROM employees;

SELECT 
    name,
    SUM(CASE WHEN department = 'IT' THEN salary ELSE 0 END) AS it_salary,
    SUM(CASE WHEN department = 'Sales' THEN salary ELSE 0 END) AS sales_salary,
    SUM(CASE WHEN department = 'Executive' THEN salary ELSE 0 END) AS exec_salary
FROM employees
GROUP BY name;

SELECT 
    name,
    department,
    salary,
    LAG(salary) OVER (ORDER BY salary) AS prev_salary,
    LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees
ORDER BY salary;