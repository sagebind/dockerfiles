# Matomo
A lightweight image for [Matomo], a popular open-source analytics platform. Includes [NGINX] as a web server, PHP 7, and the latest Matomo version. Matomo jobs and tasks are automatically run in the container as a cron job, so no extra setup for archiving is needed.

## Usage
To set up a working Matomo container, you will need to provide a MySQL database. The best way is to create a separate container for the database and then link it to the Matomo container, but you can also use a remote database.

The database can be configured using environment variables when the container is created. The following variables are respected:

- `DB_HOST`: Host name or IP address of the MySQL server. Required.
- `DB_PORT`: Override MySQL server port. Optional.
- `DB_USERNAME`: MySQL user for Matomo to use. Required.
- `DB_PASSWORD`: Password for the MySQL user. Required.
- `DB_NAME`: Name of the database to connect to. Defaults to `matomo`. Optional.
- `DB_PREFIX`: A string that the Matomo table names are prefixed with. Default is `matomo_`. Optional.


[matomo]: https://matomo.org
[nginx]: http://nginx.org
