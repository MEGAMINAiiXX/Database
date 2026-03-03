DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age >= 16),
    faculty VARCHAR(50)
);

INSERT INTO students (name, age, faculty) VALUES
('Avin', 20, 'COM-25');

INSERT INTO students (name, age, faculty) VALUES
('Beka', 19, 'MED'),
('Alymbek', 21, 'IT'),
('Timur', 18, 'COM-25');

SELECT * FROM students;

UPDATE students
SET age = 21
WHERE name = 'Avin';

SELECT * FROM students WHERE name = 'Avin';

DELETE FROM students
WHERE name = 'Timur';

SELECT * FROM students;

DELETE FROM students
WHERE age < 20;

SELECT * FROM students;