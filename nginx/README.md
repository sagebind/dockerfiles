# sagebind/nginx
Lightweight, service-oriented Nginx image.

Hosting simple static content:

```sh
docker run --name some-nginx -v /some/content:/var/www:ro -d sagebind/nginx
```

The default server configuration is located at `/etc/nginx/conf.d/default.conf`. To customize the http server config, it is recommended that you override this file with your own. For more advanced configuration, you can provide your own `nginx.conf` and copy it to `/etc/nginx/nginx.conf`, which will override all existing settings.
