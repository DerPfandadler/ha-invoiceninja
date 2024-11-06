ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.3.2
FROM ${BUILD_FROM} AS base

FROM invoiceninja/invoiceninja:latest AS invoiceninja

# Stage 3: Final Stage (combining both images)
FROM base

COPY --from=invoiceninja / / 

# Set the working directory to /var/www/app
WORKDIR /var/www/app

# Set shell
SHELL ["/bin/sh", "-c"]

# Copy root filesystem
COPY rootfs /

VOLUME /var/app/public /var/app/storage

RUN chmod +x /etc/s6-overlay/s6-rc.d/*/run
RUN chmod +x /etc/s6-overlay/s6-rc.d/*/up

# Set environment variables (use what is already set in Invoice Ninja)
ENV IS_DOCKER=true
ENV APP_URL=http://invoiceninja.test
ENV APP_DEBUG=0
ENV APP_ENV=production
ENV LOG=errorlog
ENV SNAPPDF_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV DB_TYPE=mysql
ENV DB_STRICT=false


# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}