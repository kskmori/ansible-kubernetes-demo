#!/bin/sh

PGDATA=/var/lib/pgsql/data
export PGDATA

if [ -e "$PGDATA/PG_VERSION" ]; then
    echo "Database already initialized."
else
    # initialize the database
    mkdir -p "$PGDATA"
    chown -R postgres "$PGDATA"
    chmod 700 "$PGDATA"
    runuser postgres -c initdb || exit 1

    # minimum PostgreSQL configuration
    # BE CAREFUL!: this is only for demo

    #  allow the database access from anywhere
    echo "host all all all trust" >> $PGDATA/pg_hba.conf

    #  listen on the network
    echo "listen_addresses = '*'" >> $PGDATA/postgresql.conf


    # intial table setup for the application
    runuser postgres -c "pg_ctl start -w"
    for f in /initdb.d/*; do
      case "$f" in
      *.sql)
        echo "running $f"
        runuser postgres -c "psql -h localhost -U postgres -f '$f'"
        ;;
      *)
        echo "ignoring $f"
        ;;
      esac
    done
    runuser postgres -c "pg_ctl stop -w"
fi

echo "Database service is starting up."
exec "$@"
