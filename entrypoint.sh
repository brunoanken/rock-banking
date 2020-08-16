#!/bin/bash
# Docker entrypoint script.

Wait until Postgres is ready
while ! pg_isready -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$PGHOST $PGPORT $PGUSER"
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
echo "Creating database..."
mix ecto.create
mix ecto.migrate
echo "Database created."

echo "Starting phoenix server"
exec mix phx.server