FROM sagebind/base:3.6

ARG VERSION=1.28.1545.95
RUN apk --no-cache add bridge-utils bzr ca-certificates curl mongodb net-tools procps python py2-pip openssl openvpn && \

    # Build time dependencies
    apk --no-cache add --virtual .build git go libffi-dev linux-headers musl-dev openssl-dev py-setuptools python-dev && \

    export GOPATH=/go && \
    go get github.com/pritunl/pritunl-dns && \
    go get github.com/pritunl/pritunl-monitor && \
    go get github.com/pritunl/pritunl-web && \
    mv /go/bin/* /usr/local/bin/ && \

    curl -L https://github.com/pritunl/pritunl/archive/$VERSION.tar.gz | tar zxf - && \
    cd pritunl-$VERSION && \
    python setup.py build && \
    pip install -r requirements.txt && \
    python setup.py install && \

    # Cleanup
    cd / && \
    rm -rf /go /pritunl-$VERSION && \
    apk --no-cache del .build

COPY etc /etc
VOLUME /data
EXPOSE 80 443 1194
