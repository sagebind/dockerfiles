# sagebind/base
A tiny, lightweight image based on [Alpine Linux][alpine] that uses [s6] to run multiple services in one container.

## Commands
Some custom commands are included for controlling a container while running:

- `shutdown`: Shuts down all services and then terminates the container.
- `halt`: Like `shutdown`, but causes the container to return a failure exit code.

## Services
This image runs services as background processes with automatic and proper process supervision with minimal overhead. You can even run a foreground service by giving Docker a CMD to run, and all services in the container will still run in the background without interrupting the foreground process.

By default the image is mostly empty and has only a few core services. To add a service, just add a script at `/etc/service/{name}/run` that executes the desired program _in the foreground_. Typically service-like programs will have a "no daemonize" flag to prevent forking and daemonizing. For example, to create a service for NGINX, you could put the following in `/etc/service/nginx/run`:

```sh
#!/bin/sh
exec nginx -g 'daemon off;'
```

By default services will be restarted if they exit or crash. For primary services this is not usually the desired behavior. To make sure the Docker container stops when a critial service dies, add a `finish` script for the service at `/etc/service/{name}/finish` that executes `halt`:

```sh
#!/bin/sh
exec halt
```

## Init scripts
This image also supports running one-time scripts at boot time. Any file marked as executable in the `/etc/init` directory or a subdirectory will be executed before services are started. These scripts can be added during the build process by a downstream image to ensure a script is run without overwriting the CMD directive.

## Cron jobs
You can also configure scripts to be run at regular intervals as cron jobs. This image enables the [cron system built in to Alpine Linux](https://wiki.alpinelinux.org/wiki/Alpine_Linux:FAQ#My_cron_jobs_don.27t_run.3F). Scripts can be placed in `/etc/periodic/{15min,hourly,daily,weekly,monthly}` and it will be run at the interval specified by the directory name.


[alpine]: https://www.alpinelinux.org
[s6]: http://skarnet.org/software/s6/
