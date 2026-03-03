DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    faculty VARCHAR(50),
    age INTEGER CHECK (age >= 16)
);

INSERT INTO students (first_name, last_name, faculty, age) VALUES
('Avin', 'LastName', 'COM-25', 20),
('Beka', 'Testov', 'MED', 19),
('Alymbek', 'Example', 'IT', 21);

SELECT * FROM students;


