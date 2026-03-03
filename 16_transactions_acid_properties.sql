DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    owner_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12,2) DEFAULT 0.00 CHECK (balance >= 0)
);

INSERT INTO accounts (owner_name, balance) VALUES
('Avin', 1000.00),
('Beka', 500.00);

SELECT * FROM accounts;

BEGIN;

UPDATE accounts SET balance = balance - 200 WHERE owner_name = 'Avin';
UPDATE accounts SET balance = balance + 200 WHERE owner_name = 'Beka';

SELECT * FROM accounts;

COMMIT;  

SELECT * FROM accounts;

BEGIN;

UPDATE accounts SET balance = balance - 300 WHERE owner_name = 'Avin';
UPDATE accounts SET balance = balance + 300 WHERE owner_name = 'Beka';

SELECT * FROM accounts;

ROLLBACK;  

SELECT * FROM accounts;

BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE owner_name = 'Avin';

SAVEPOINT after_first_transfer;

UPDATE accounts SET balance = balance - 500 WHERE owner_name = 'Avin';  

ROLLBACK TO SAVEPOINT after_first_transfer;

SELECT * FROM accounts;

COMMIT;


SELECT * FROM accounts;

