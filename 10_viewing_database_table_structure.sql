SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT 
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default,
    numeric_precision,
    numeric_scale
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'students'
ORDER BY ordinal_position;

SELECT 
    datname AS database_name,
    pg_size_pretty(pg_database_size(datname)) AS size,
    datistemplate AS is_template
FROM pg_database
ORDER BY datname;

SELECT 
    current_database() AS current_db,
    current_user AS current_user,
    version() AS postgres_version;