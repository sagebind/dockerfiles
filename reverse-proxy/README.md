# Reverse proxy
A dynamic, config-free [NGINX] reverse proxy server.

## Usage
This reverse proxy does not require priveleged access to the Docker daemon. Instead, it dynamically determines upstream server names by matching container names to domain names. The rule matches any container name ending in `.local`. For example, `foobar.local` would match `foobar.com`, `foobar.net`, `www.foobar.com`, etc...

Desiged to work well with Docker networks. Just add the reverse proxy container to the same network as your public-facing containers and their domain names will be automatically resolved and proxied. Adding or removing a container also works dynamically and the proxy server will automatically pick up the changes without needing a restart.


[nginx]: http://nginx.org
