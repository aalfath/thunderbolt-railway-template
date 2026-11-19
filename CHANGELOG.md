# Changelog

## 0.1.168 (2026-11-19)

First release of the template.

- Thunderbolt v0.1.168 from upstream's images, pinned by digest: frontend, backend, Keycloak 26.8.2, PowerSync 1.28.0, PostgreSQL 18.
- Keycloak runs in production mode on the Postgres service (database `keycloak`) with a local cache, with self-registration off and the first user created from deploy variables.
- Postgres keeps its cluster in `/var/lib/postgresql/data/pgdata` on the volume.
