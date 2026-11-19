# PowerSync sync service with Thunderbolt's sync rules: upstream's powersync image, pinned by version and digest.
FROM ghcr.io/thunderbird/thunderbolt/thunderbolt-powersync:0.1.168@sha256:70336a2ab89b5adff03396666f1285434ddf9eb59bc5526e80f2e9c2c0858cee

COPY --chmod=755 start.sh /app/start.sh

EXPOSE 8080
ENTRYPOINT ["/app/start.sh"]
