#!/bin/bash

set -e

while :
do
    # Insert current timestamp into timestamp table
    psql "sslmode=require host=${PGHOST} port=5432 dbname=${PGDB}" -U "${PGUSER}" -c "INSERT INTO timestamp (timestamp) (SELECT now()::TIMESTAMP)"

    # Print the 10 latest db inputs
    echo "$(psql "sslmode=require host=${PGHOST} port=5432 dbname=${PGDB}" -U "${PGUSER}" -c "SELECT timestamp FROM timestamp ORDER BY id DESC LIMIT 10")"

    sleep 60s
done
