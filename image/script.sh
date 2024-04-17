#!/bin/bash

set -e

while :
do
    # Insert current timestamp into timestamp table
    psql -h "${PGHOST}" -p 5432 -U "${PGUSER}" -d "${PGDB}" -c "INSERT INTO timestamp (timestamp) (SELECT now()::TIMESTAMP)"

    # Print the 10 latest db inputs
    echo "$(psql -h "${PGHOST}" -p 5432 -U "${PGUSER}" -d "${PGDB}" -c "SELECT timestamp FROM timestamp ORDER BY id DESC LIMIT 10")"

    sleep 60s
done
