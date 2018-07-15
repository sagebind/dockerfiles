ARG ALPINE_VERSION=latest
FROM alpine:$ALPINE_VERSION

RUN apk --no-cache upgrade && \
    apk --no-cache add s6 && \
    addgroup -g 9000 srv

COPY root /

ENTRYPOINT ["/sbin/init"]
