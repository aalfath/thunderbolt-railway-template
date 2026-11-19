# Thunderbolt API (Bun + Elysia): upstream's backend image, pinned by version and digest.
# The image's entrypoint waits for Postgres, then starts the server, which applies migrations.
FROM ghcr.io/thunderbird/thunderbolt/thunderbolt-backend:0.1.168@sha256:ea82394afeedf91c0c2764bf9bc8fc9caf0774dac0c36beebc3769fabb86d115

# Fixed settings for the bundled stack (OIDC sign-in through the Keycloak service).
# Listen on all IPv4 and IPv6 addresses so Railway's private network reaches it.
ENV NODE_ENV=production \
    HOST=:: \
    PORT=8000 \
    AUTH_MODE=oidc \
    WAITLIST_ENABLED=false \
    DATABASE_DRIVER=postgres \
    OIDC_CLIENT_ID=thunderbolt-app \
    POWERSYNC_JWT_KID=thunderbolt-powersync \
    TRUSTED_PROXY=2

EXPOSE 8000
ENTRYPOINT ["./entrypoint.sh"]
