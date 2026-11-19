# Keycloak 26.8 for Thunderbolt's sign-in: upstream's keycloak image, pinned by version and digest.
# Upstream runs it in dev mode with an in-container database; here it runs in production mode
# on the Postgres service, so accounts survive redeploys.
FROM ghcr.io/thunderbird/thunderbolt/thunderbolt-keycloak:0.1.168@sha256:aa2431fecd05f125b252c5f28a689ab07dedff8ee15cbec589329ea2065d3f30

# Our realm: OIDC client only, self-registration off, and one first user from deploy variables.
COPY --chown=1000:0 thunderbolt-realm.json /opt/keycloak/data/import/thunderbolt-realm.json

ENV KC_DB=postgres \
    KC_HEALTH_ENABLED=true \
    KC_HTTP_MANAGEMENT_HEALTH_ENABLED=false \
    KC_HTTP_ENABLED=true \
    KC_HTTP_PORT=8080 \
    KC_HTTP_HOST=:: \
    KC_PROXY_HEADERS=xforwarded \
    KC_HOSTNAME_BACKCHANNEL_DYNAMIC=true

# Cap the build heap: the default sizes it from host memory and can fail in small builders.
RUN JAVA_OPTS_KC_HEAP="-Xms64m -Xmx512m" /opt/keycloak/bin/kc.sh build

EXPOSE 8080
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized", "--import-realm"]
