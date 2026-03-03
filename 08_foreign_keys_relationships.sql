DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS enrollments;

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

INSERT INTO departments (dept_name) VALUES
('IT'), ('Medicine'), ('Economics');

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id) ON DELETE SET NULL
);

INSERT INTO employees (name, dept_id) VALUES
('Avin', 1),
('Beka', 1),
('Test', 2);

SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO users (username) VALUES
('avin123'), ('beka456');

CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE REFERENCES users(user_id) ON DELETE CASCADE,
    full_name VARCHAR(100),
    bio TEXT
);

INSERT INTO user_profiles (user_id, full_name, bio) VALUES
(1, 'Avin LastName', 'Student COM-25'),
(2, 'Beka Testov', 'Student MED');

SELECT u.username, p.full_name
FROM users u
JOIN user_profiles p ON u.user_id = p.user_id;

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO students (name) VALUES
('Avin'), ('Beka');

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

INSERT INTO courses (title) VALUES
('Database Systems'), ('Math');

CREATE TABLE enrollments (
    student_id INTEGER REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES courses(course_id) ON DELETE CASCADE,
    semester VARCHAR(20) NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id, semester)  
);

INSERT INTO enrollments (student_id, course_id, semester, grade) VALUES
(1, 1, '2024-Spring', 'A'),
(1, 2, '2024-Spring', 'B+'),
(2, 1, '2024-Spring', 'A-');

SELECT s.name, c.title, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;