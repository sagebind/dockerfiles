# Reverse proxy
A dynamic, config-free [NGINX] reverse proxy server.

## Usage
This reverse proxy doe not require priveleged access to the Docker daemon. Instead, it dynamically determines upstream server names by matching container names to domain names. The rule matches any container name ending in `.local`. For example, `foobar.local` would match `foobar.com`, `foobar.net`, `www.foobar.com`, etc...


[nginx]: http://nginx.org
