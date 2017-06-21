FROM sagebind/base:latest
MAINTAINER Stephen Coakley <me@stephencoakley.com>

RUN apk --no-cache add ca-certificates znc && \
    apk --no-cache add --virtual build build-base curl-dev git openssl-dev znc-dev && \
    git clone https://github.com/jreese/znc-push && \
    make -C znc-push && \
    mv znc-push/push.so /usr/lib/znc && \
    rm -rf znc-push && \
    apk del build

COPY root /

VOLUME /etc/znc

EXPOSE 6667
