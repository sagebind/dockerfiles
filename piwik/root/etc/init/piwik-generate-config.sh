#!/bin/sh
CONFIG_FILE=/var/www/config/config.ini.php
TEMPLATE=/etc/config.ini.php.template

if [ -z "$DB_PORT" ]; then
    export DB_PORT=3306
fi

if [ -z "$DB_NAME" ]; then
    export DB_NAME=piwik
fi

if [ -z "$DB_PREFIX" ]; then
    export DB_PREFIX=piwik_
fi

envsubst < $TEMPLATE > $CONFIG_FILE
chown nginx:nginx $CONFIG_FILE
