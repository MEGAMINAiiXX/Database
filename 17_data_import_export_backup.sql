COPY students TO 'D:\SQL_Lab_Avin\students_export.csv' 
WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

DROP TABLE IF EXISTS students_import_test;

CREATE TABLE students_import_test (
    student_id INTEGER,
    name VARCHAR(100),
    email VARCHAR(150),
    faculty VARCHAR(50),
    age INTEGER,
    gpa DECIMAL(3,2)
);

COPY students_import_test FROM 'D:\SQL_Lab_Avin\students_export.csv' 
WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',');

SELECT * FROM students_import_test LIMIT 5;

SELECT 
    (SELECT COUNT(*) FROM students) AS original_count,
    (SELECT COUNT(*) FROM students_import_test) AS imported_count;

