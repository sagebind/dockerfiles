# sagebind/base
A tiny, lightweight image based on [Alpine Linux][alpine] that uses [s6] to run multiple services in one container.

## Services
This image runs services as background processes with automatic and proper process supervision with minimal overhead. You can even run a foreground service by giving Docker a CMD to run, and all services in the container will still run in the background without interrupting the foreground process.

By default the image is mostly empty and has no services. To add a service, just add a script at `/service/{name}/run` that executes the desired program _in the foreground_. Typically service-like programs will have a "no daemonize" flag to prevent forking and daemonizing. For example, to create a service for NGINX, you could put the following in `/service/nginx/run`:

```sh
#!/bin/sh
nginx -g 'daemon off;'
```

By default services will be restarted if they exit or crash. For primary services this is not usually the desired behavior. To make sure the Docker container stops when a critial service dies, add a `finish` script for the service at `/service/{name}/finish` that calls `shutdown`:

```sh
#!/bin/sh
shutdown
```


[alpine]: https://www.alpinelinux.org
[s6]: http://skarnet.org/software/s6/
