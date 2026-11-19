# Thunderbolt web app: upstream's frontend image (Vite SPA + nginx), pinned by version and digest.
# nginx serves the app on 8080 and proxies /v1/ to the Backend service over Railway's private network.
FROM ghcr.io/thunderbird/thunderbolt/thunderbolt-frontend:0.1.168@sha256:1ce5ffa5c5fa2a1f1987bdfd727e590a85b03fab6891d630924b8f18f027332f

# The Backend service listens here; its private hostname comes from THUNDERBOLT_BACKEND_HOST.
ENV THUNDERBOLT_BACKEND_PORT=8000

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
