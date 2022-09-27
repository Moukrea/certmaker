FROM alpine:3.16.2

COPY certmaker /usr/local/bin/
COPY init /

RUN apk add --no-cache openssl coreutils tzdata \
    rm -rf /var/cache/apk/* \
    && chmod +x /usr/local/bin/certmaker \
    && chmod +x /init \
    && mkdir /certs \
    && ls -la

ENTRYPOINT ["/init"]