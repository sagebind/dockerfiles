# Sagebind's tiny base image
A tiny image based on [Alpine Linux][alpine] using [s6] to supervise multiple processes in one container.

This is a low-level [Docker][docker] image meant to be a base for building lightweight, correct Docker images. Most of my own images use this image as a base, and you can use it as a solid base for your own lightweight images, too.

The goal of this image is to meet all of the following needs:

- A stable, secure system containing only the essential components.
- A correct `init` process.
- Ability to run multiple processes as part of a single, conceptual service.
- Logging that integrates with `docker logs`.

## The init process
A container based on this image always starts its life by executing `/sbin/init`, which performs the following steps:

1. Execute any available init scripts located in `/etc/init`.
2. If a command is passed to the container, fork and start the command in the background.
3. Execute [`s6-svscan`][s6-svscan], which spawns and supervises all configured services.

### Init process and PID 1
The init process always executes `s6-svscan` as PID 1, which was written to handle the responsibilities that are expected of PID 1. See [Docker and the PID 1 zombie reaping problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/) for an excellent explanation of why this is important.

### Init scripts
This image supports running one-time scripts at boot time. Any file marked as executable in the `/etc/init` directory or a subdirectory will be executed before services are started. These scripts can be added during the build process by a downstream image to ensure a script is run without overwriting the CMD directive.

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

## Cron jobs
You can also configure scripts to be run at regular intervals as cron jobs. This image enables the [cron system built in to Alpine Linux](https://wiki.alpinelinux.org/wiki/Alpine_Linux:FAQ#My_cron_jobs_don.27t_run.3F) as a service. Scripts can be placed in `/etc/periodic/{15min,hourly,daily,weekly,monthly}` and it will be run at the interval specified by the directory name.

## Logging
Docker encourages the use of stdout and stderr as the means of capturing logs from a container. These logs can be hooked up to logging drivers and can be put to much better use _outside_ the container rather than _inside_. As a result, output logs from both syslog and all running services are all aggregated and redirected to stdout and stderr.

## Utility commands
Some custom commands are included for controlling services, the container state, or for just making working with common tasks easier:

- `envsubst`: Piping command that replaces patterns of the form `${ENV_NAME}` with the value of the `ENV_NAME` environment variable. Useful for making templated config files.
- `service`: Helper script for starting and stopping services.
- `shutdown`: Shuts down all services and then terminates the container.
- `halt`: Like `shutdown`, but causes the container to return a failure exit code.


[alpine]: https://www.alpinelinux.org
[docker]: https://www.docker.com
[phusion-baseimage]: https://github.com/phusion/baseimage-docker
[s6]: http://skarnet.org/software/s6/
[s6-svscan]: http://skarnet.org/software/s6/s6-svscan.html
