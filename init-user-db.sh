#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER gogs PASSWORD 'gogs';
    CREATE USER drone PASSWORD 'drone';
    CREATE DATABASE gogs;
    CREATE DATABASE drone;
    GRANT ALL PRIVILEGES ON DATABASE gogs TO gogs;
    GRANT ALL PRIVILEGES ON DATABASE drone TO drone;
EOSQL
