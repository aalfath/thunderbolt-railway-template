#!/bin/sh
# First boot only: a separate database for the Keycloak service, so its tables stay out of the
# app database that PowerSync replicates.
set -eu
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
  -c "CREATE DATABASE keycloak OWNER \"$POSTGRES_USER\";"
