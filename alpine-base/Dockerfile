FROM alpine:3.19

RUN apk add --no-cache tzdata=2024a-r0 curl=8.5.0-r0 openssl=3.1.6-r0 \
    ca-certificates=20240226-r0 && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone && \
    addgroup -g 1000 basegroup && \
    adduser -u 1000 -G basegroup -D baseuser && \
    rm -f /var/cache/dpk/*
