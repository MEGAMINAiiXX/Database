DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,                  -- Автоинкремент, первичный ключ
    first_name VARCHAR(50) NOT NULL,                -- Строка до 50 символов, обязательно
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,             -- Уникальный email
    faculty VARCHAR(100),
    birth_date DATE,                                -- Дата рождения
    age INTEGER CHECK (age >= 16 AND age <= 100),   -- Возраст с проверкой
    is_active BOOLEAN DEFAULT TRUE                  -- Булевый флаг, по умолчанию true
);

INSERT INTO students (first_name, last_name, email, faculty, birth_date, age) VALUES
('Avin', 'LastName', 'avin@example.com', 'COM-25', '2005-01-15', 21),
('Beka', 'Testov', 'beka@example.com', 'MED', '2006-05-20', 19),
('Alymbek', 'Example', 'alymbek@example.com', 'IT', '2004-11-10', 22);

SELECT * FROM students;

\d students