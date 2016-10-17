# Piwik
A lightweight image for [Piwik][piwik], a popular open-source analytics platform. Includes Nginx as a web server, PHP 7, and the latest Piwik version. Piwik jobs and tasks are automatically run in the container as a cron job, so no extra setup for archiving is needed.

## Usage
To set up a working Piwik container, you will need to provide a MySQL database. The best way is to create a separate container for the database and then link it to the Piwik container, but you can also use a remote database.

The database can be configured using environment variables when the container is created. The following variables are respected:

- `DB_HOST`: Host name or IP address of the MySQL server. Required.
- `DB_PORT`: Override MySQL server port. Optional.
- `DB_USERNAME`: MySQL user for Piwik to use. Required.
- `DB_PASSWORD`: Password for the MySQL user. Required.
- `DB_NAME`: Name of the database to connect to. Defaults to `piwik`. Optional.
- `DB_PREFIX`: A string that the Piwik table names are prefixed with. Default is `piwik_`. Optional.


[piwik]: http://piwik.org
