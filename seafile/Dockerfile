FROM sagebind/base

# Install runtime dependencies.
RUN apk --no-cache add bash ca-certificates curl glib jansson libarchive libevent libevhtp libuuid openssl python \
    py2-pip py-chardet py-dateutil py-flup py-gevent py-gunicorn py-numpy py-pillow py-pyldap py-requests py-tz sqlite \
    util-linux

ENV SERVER_NAME=seafile \
    FILESERVER_PORT=8082 \
    CCNET_PORT=10001 \
    SEAFILE_PORT=12001 \
    CCNET_CONF_DIR=/srv/ccnet \
    SEAFILE_CENTRAL_CONF_DIR=/srv/conf \
    SEAFILE_CONF_DIR=/data \
    PYTHONPATH=/srv/seafile-server/seahub:/srv/seafile-server/seahub/thirdpart:/usr/local/lib/python2.7/site-packages

ARG SEAFILE_VERSION=6.1.2
RUN apk --no-cache add --virtual .build autoconf automake bsd-compat-headers build-base curl-dev fuse-dev glib-dev \
    intltool jansson-dev libarchive-dev libevent-dev libevhtp-dev libtool musl-dev openssl-dev python-dev sqlite-dev \
    util-linux-dev vala && \

    # Download Seafile source bundles
    mkdir /src && cd /src && \
    curl -L https://github.com/haiwen/libsearpc/archive/v3.1-latest.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/seafile-server/archive/v${SEAFILE_VERSION}-server.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/ccnet-server/archive/v${SEAFILE_VERSION}-server.tar.gz | tar xzf - && \
    curl -L https://github.com/haiwen/seahub/archive/v${SEAFILE_VERSION}-server.tar.gz | tar xzf - && \

    # Compile and install libsearpc
    cd /src/libsearpc-3.1-latest && \
    ./autogen.sh && \
    ./configure && \
    make install && \

    # Compile and install ccnet
    cd /src/ccnet-server-${SEAFILE_VERSION}-server && \
    ./autogen.sh && \
    ./configure --without-mysql --without-postgresql && \
    make install && \

    # Compile and install Seafile
    cd /src/seafile-server-${SEAFILE_VERSION}-server && \
    export CFLAGS="-I/usr/include/evhtp" && \
    ./autogen.sh && \
    ./configure && \
    make install && \
    mkdir -p /srv && mv scripts /srv/scripts && \

    # Install Seahub
    mkdir -p /srv/seafile-server && mv /src/seahub-${SEAFILE_VERSION}-server /srv/seafile-server/seahub && \
    cd /srv/seafile-server/seahub && \
    pip install https://github.com/haiwen/django-constance/archive/6b04a31.zip && \
    pip install -r requirements.txt && \

    # Cleanup
    cd / && rm -rf /src /root/.cache && \
    apk --no-cache del .build

COPY etc /etc
COPY seahub.conf /srv/seafile-server/runtime/seahub.conf

WORKDIR /srv
VOLUME $SEAFILE_CONF_DIR

EXPOSE 80
EXPOSE $FILESERVER_PORT
EXPOSE $CCNET_PORT
EXPOSE $SEAFILE_PORT
