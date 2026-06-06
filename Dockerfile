FROM ghcr.io/thnaylor/baboviolent2:edge AS game-files

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        libsdl2-mixer-2.0-0 \
        libglu1-mesa \
        libgl1 \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash babo

LABEL maintainer="thnaylor" \
      name="baboviolent2-server-docker" \
      github="https://github.com/thnaylor/babo-docker-server"

ENV HOME=/home/babo \
    PORT=3333 \
    PUID=1000 \
    PGID=1000

COPY --from=game-files /app/BaboViolentDedicated /home/babo/server-files/BaboViolentDedicated
COPY --from=game-files /app/Content/ /home/babo/server-files/Content/
COPY scripts/ /home/babo/server/
COPY branding /branding

RUN chmod +x /home/babo/server/*.sh && \
    chmod +x /home/babo/server-files/BaboViolentDedicated && \
    chown -R babo:babo /home/babo/

WORKDIR /home/babo/server

HEALTHCHECK --start-period=10s \
            CMD pgrep "BaboViolentDedicated" > /dev/null || exit 1

EXPOSE 3333/tcp 3333/udp

ENTRYPOINT ["/home/babo/server/init.sh"]
