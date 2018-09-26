#!/bin/sh

PGDATA=/var/lib/pgsql/data
export PGDATA

if [ -r $PGDATA/PG_VERSION ]; then
    echo "Database already initialized. Done."
    exit 0
fi

runuser postgres -c initdb

# minimum PostgreSQL configuration
# BE CAREFUL!: this is only for demo

#  allow the database access from anywhere
echo "host all all all trust" >> $PGDATA/pg_hba.conf

#  listen on the network
echo "listen_addresses = '*'" >> $PGDATA/postgresql.conf


# intial table setup for the application
runuser postgres -c "pg_ctl start -w"
runuser postgres -c "psql -h localhost -U postgres -f init.sql"
runuser postgres -c "pg_ctl stop -w"
