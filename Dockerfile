ARG BASE_IMAGE=scottyhardy/docker-wine:stable
FROM ${BASE_IMAGE}

# Create locations
RUN mkdir -p /opt/app /wineprefix /data

# Copy your Windows CLI binary into the image
COPY --chmod=755 netiso/server.exe /opt/app/server.exe

# Wine env: quiet logs, skip menu builder noise, set prefix
ENV WINEPREFIX=/wineprefix \
    WINEDEBUG=-all \
    WINEDLLOVERRIDES=winemenubuilder.exe=d

# Pre-initialize the prefix to avoid first-run delay (ignore non-zero exits)
RUN wineboot --init || true

# Keep /data as the working directory — this MUST be the user's mounted folder
VOLUME ["/games"]
WORKDIR /games

# Tiny entrypoint ensures /games exists & is the CWD, then execs your app via Wine
COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Default command: run the binary under Wine (stdout/stderr go to container logs)
CMD ["wine", "/opt/app/server.exe"]
