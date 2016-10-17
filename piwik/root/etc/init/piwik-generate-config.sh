#!/bin/sh
CONFIG_FILE=/var/www/config/config.ini.php

if [ -z "$DB_PORT" ]; then
    DB_PORT=3306
fi

if [ -z "$DB_NAME" ]; then
    DB_NAME=piwik
fi

if [ -z "$DB_PREFIX" ]; then
    DB_PREFIX=piwik_
fi

echo "; <?php exit; ?> DO NOT REMOVE THIS LINE
; file automatically generated or modified by Piwik; you can manually override the default values in global.ini.php by redefining them in this file.
[database]
host = \"$DB_HOST\"
port = $DB_PORT
username = \"$DB_USERNAME\"
password = \"$DB_PASSWORD\"
dbname = \"$DB_NAME\"
tables_prefix = \"$DB_PREFIX\"
adapter = \"PDO\MYSQL\"
type = \"InnoDB\"
schema = \"Mysql\"" > $CONFIG_FILE

chown nginx:nginx $CONFIG_FILE
