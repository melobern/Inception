FROM debian:bullseye

RUN apk update && apk upgrade && apt add \
    openssl \
    nginx \
    && rm -rf /var/lib/apt/lists/*
