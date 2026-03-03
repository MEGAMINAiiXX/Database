DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS book_authors;
DROP TABLE IF EXISTS members;

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    birth_year INTEGER CHECK (birth_year > 1800 AND birth_year < 2025)
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publication_year INTEGER CHECK (publication_year > 1800),
    isbn VARCHAR(13) UNIQUE
);

CREATE TABLE book_authors (
    book_id INTEGER REFERENCES books(book_id) ON DELETE CASCADE,
    author_id INTEGER REFERENCES authors(author_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES books(book_id) ON DELETE RESTRICT,
    member_id INTEGER REFERENCES members(member_id) ON DELETE RESTRICT,
    borrow_date DATE DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    CHECK (due_date > borrow_date)
);


INSERT INTO authors (name, birth_year) VALUES
('J.K. Rowling', 1965),
('Leo Tolstoy', 1828);

INSERT INTO books (title, publication_year, isbn) VALUES
('Harry Potter and the Philosopher''s Stone', 1997, '9780747532699'),
('War and Peace', 1869, '9780199232765');

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 2);

INSERT INTO members (name, email) VALUES
('Avin', 'avin@example.com'),
('Beka', 'beka@example.com');

INSERT INTO loans (book_id, member_id, borrow_date, due_date) VALUES
(1, 1, CURRENT_DATE - 10, CURRENT_DATE + 14),
(2, 2, CURRENT_DATE - 5, CURRENT_DATE + 21);

SELECT b.title, a.name AS author
FROM books b
JOIN book_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.author_id = a.author_id;

SELECT m.name AS member, b.title AS book, l.borrow_date, l.due_date
FROM members m
JOIN loans l ON m.member_id = l.member_id
JOIN books b ON l.book_id = b.book_id;