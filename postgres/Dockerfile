# PostgreSQL 18 with Thunderbolt's PowerSync setup: upstream's postgres image, pinned by version and digest.
# Its first-boot script creates the powersync_role replication login, the "powersync" publication
# and the powersync_storage database. Ours adds the "keycloak" database.
FROM ghcr.io/thunderbird/thunderbolt/thunderbolt-postgres:0.1.168@sha256:e9b19c70337cbf8c5bcdd11a1600aedd4ea4cca76861f6bca375cdb50a4420a3

COPY --chmod=755 02-keycloak.sh /docker-entrypoint-initdb.d/

# Railway mounts the volume at /var/lib/postgresql/data. A fresh volume holds lost+found,
# so keep the cluster in a subfolder of it.
ENV PGDATA=/var/lib/postgresql/data/pgdata \
    POSTGRES_USER=postgres \
    POSTGRES_DB=thunderbolt

EXPOSE 5432
# PowerSync replicates logically, so WAL must be logical.
CMD ["postgres", "-c", "wal_level=logical"]
