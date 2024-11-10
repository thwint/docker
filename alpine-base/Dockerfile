FROM alpine:3.20

RUN apk add --no-cache tzdata=2024b-r0 curl=8.11.0-r1 openssl=3.3.2-r1 \
    ca-certificates=20240705-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
