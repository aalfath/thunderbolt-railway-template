[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/thunderbolt?utm_medium=integration&utm_source=button&utm_campaign=thunderbolt)

# Thunderbolt on Railway

One-click Railway template for [Thunderbolt](https://github.com/thunderbird/thunderbolt), Mozilla Thunderbird's open-source, self-hosted AI client (MPL-2.0). It deploys upstream's own container images for **Thunderbolt v0.1.168**, pinned by version and digest.

## What it deploys

| Service | Folder | Image (pinned in the folder's `Dockerfile`) | Public | Volume |
|---|---|---|---|---|
| Thunderbolt | `thunderbolt/` | `thunderbolt-frontend:0.1.168` (nginx, serves the web app and proxies `/v1/` to Backend) | yes | none |
| Backend | `backend/` | `thunderbolt-backend:0.1.168` (Bun API, runs database migrations on start) | no | none |
| Keycloak | `keycloak/` | `thunderbolt-keycloak:0.1.168` (Keycloak 26.8, sign-in), production mode on Postgres | yes (sign-in pages) | none, data in Postgres |
| PowerSync | `powersync/` | `thunderbolt-powersync:0.1.168` (PowerSync 1.28, syncs chats between devices) | yes (browser connects to it) | none, data in Postgres |
| Postgres | `postgres/` | `thunderbolt-postgres:0.1.168` (PostgreSQL 18, `wal_level=logical`) | no | `/var/lib/postgresql/data` |

All images come from `ghcr.io/thunderbird/thunderbolt/`. Upstream re-publishes a version tag on later merges, so each `FROM` line also pins the digest: a build of this repo is always the same image.

The browser talks to three of the services directly (app, Keycloak sign-in, PowerSync sync), so each of them gets a Railway domain. Everything else goes over Railway's private network.

## Variables

The deployer is asked for one value:

- `THUNDERBOLT_ADMIN_EMAIL` (Keycloak): the email of the first Thunderbolt user. Its password is generated (`THUNDERBOLT_ADMIN_PASSWORD` on the Keycloak service).

Everything else is generated or derived: the Postgres and PowerSync database passwords, the OIDC client secret, `BETTER_AUTH_SECRET`, the PowerSync JWT secret, the Keycloak admin console password (`KC_BOOTSTRAP_ADMIN_PASSWORD`, user `admin`), and all URLs. Self-registration is off: add more users in the Keycloak admin console (`https://<keycloak domain>/admin/`, realm `thunderbolt`).

No AI model ships with Thunderbolt. Users add their own provider key in **Settings → Models**, or set `ANTHROPIC_API_KEY` or `TINFOIL_API_KEY` on the Backend service to give every user a model. See upstream's [configuration docs](https://github.com/thunderbird/thunderbolt/blob/main/docs/self-hosting/configuration.md).

## Updates

When this repo's `main` changes (a version bump or a fix), Railway shows an "update available" notice on every project deployed from the template. You choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first, and back up Postgres before you update: Thunderbolt applies database migrations on start, and an older image does not undo them.

## Left out

- `thunderbolt-marketing` (landing page and docs site): not needed to run the app.
- Upstream's demo user (`demo`/`demo`) and the SAML test client in the realm: fixed credentials, not safe on a public URL.

## Licence

Thunderbolt is MPL-2.0 (c) Mozilla. The realm file in `keycloak/` is adapted from upstream's `deploy/config/keycloak-realm.json`. The rest of this wrapper is MIT.
