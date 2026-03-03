CREATE DATABASE test_database_lab;

SELECT datname AS database_name,
       pg_size_pretty(pg_database_size(datname)) AS size
FROM pg_database
WHERE datname NOT IN ('postgres', 'template0', 'template1')  -- скрываем системные
ORDER BY datname;

SELECT current_database() AS current_db;