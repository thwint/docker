FROM alpine:3.21

RUN apk add --no-cache tzdata=2024b-r1 curl=8.11.1-r0 openssl=3.3.2-r4 \
    ca-certificates=20241010-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
