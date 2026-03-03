DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    faculty VARCHAR(50),
    age INTEGER CHECK (age >= 16),
    gpa DECIMAL(3,2) CHECK (gpa BETWEEN 0 AND 4.0)
);

INSERT INTO students (name, email, faculty, age, gpa) VALUES
('Avin', 'avin@example.com', 'COM-25', 20, 3.8),
('Beka', 'beka@example.com', 'MED', 19, 3.2),
('Alymbek', 'alymbek@example.com', 'IT', 21, 3.9),
('Timur', 'timur@example.com', 'COM-25', 18, 2.9),
('Meerim', 'meerim@example.com', 'Economics', 22, 3.5);

SELECT * FROM students;

SELECT name, age, faculty
FROM students
WHERE age >= 20 AND faculty IN ('COM-25', 'IT');

SELECT name, email
FROM students
WHERE name LIKE 'A%'  
   OR email ILIKE '%@example.com'; 

SELECT name, gpa
FROM students
WHERE faculty NOT IN ('MED', 'Economics');

SELECT 
    name,
    gpa,
    CASE 
        WHEN gpa >= 3.5 THEN 'Excellent'
        WHEN gpa >= 3.0 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS performance
FROM students;

WITH high_gpa AS (
    SELECT * FROM students WHERE gpa > 3.5
)
SELECT name, faculty, gpa
FROM high_gpa
ORDER BY gpa DESC;

SELECT name, faculty
FROM students s
WHERE EXISTS (
    SELECT 1 FROM students s2 
    WHERE s2.faculty = s.faculty AND s2.gpa > s.gpa
);