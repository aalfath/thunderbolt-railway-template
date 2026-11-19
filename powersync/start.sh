#!/bin/sh
# PowerSync verifies the JWTs the Backend signs with POWERSYNC_JWT_SECRET (HS256).
# Its config wants that key as a JWK `k` value (base64url), which Railway variables can't
# compute, so derive it here from the shared secret.
set -eu
: "${POWERSYNC_JWT_SECRET:?POWERSYNC_JWT_SECRET must be set}"
: "${PS_PG_URI:?PS_PG_URI must be set}"
: "${PS_STORAGE_URI:?PS_STORAGE_URI must be set}"
PS_JWT_KEY_BASE64="$(printf %s "$POWERSYNC_JWT_SECRET" | base64 | tr -d '\n=' | tr '+/' '-_')"
export PS_JWT_KEY_BASE64
export PS_JWT_KID="${PS_JWT_KID:-thunderbolt-powersync}"
export PS_SYNC_CONFIG_VERSION="${PS_SYNC_CONFIG_VERSION:-1}"
exec node service/lib/entry.js start -r unified
