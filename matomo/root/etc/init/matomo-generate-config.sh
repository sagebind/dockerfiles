#!/bin/sh
CONFIG_FILE=/srv/www/config/config.ini.php
TEMPLATE=/etc/config.ini.php.template

if [ -z "$DB_PORT" ]; then
    export DB_PORT=3306
fi

if [ -z "$DB_NAME" ]; then
    export DB_NAME=matomo
fi

if [ -z "$DB_PREFIX" ]; then
    export DB_PREFIX=matomo_
fi

envsubst < $TEMPLATE > $CONFIG_FILE
chown nginx:nginx $CONFIG_FILE
