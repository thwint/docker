FROM alpine:3.19

LABEL org.opencontainers.image.base.name=alpine:3.19
LABEL org.opencontainers.image.licenses=GPL-3.0-or-later
LABEL org.opencontainers.image.url=https://github.com/thwint/docker
LABEL org.opencontainers.image.source=https://github.com/thwint/docker
LABEL org.opencontainers.image.vendor='Tom Winterhalder'
LABEL org.opencontainers.image.title='Base image'
LABEL org.opencontainers.image.description="A custom base image with some predefined settings"
LABEL org.opencontainers.image.documentation=https://docker.wintersoft.ch
LABEL org.opencontainers.image.authors=tom.winterhalder@gmail.com

RUN apk add --no-cache tzdata=2023d-r0 curl=8.5.0-r0 openssl=3.1.4-r2 \
    ca-certificates=20230506-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*

ARG created
LABEL org.opencontainers.image.created=${created}
ARG version
LABEL org.opencontainers.image.version=${version}
ARG revision
LABEL org.opencontainers.image.revision=${revision}
