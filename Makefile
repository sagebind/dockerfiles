all: sagebind/base sagebind/nginx sagebind/php sagebind/php-nginx sagebind/piwik

sagebind/base:
	docker build -t $@ base

sagebind/nginx: sagebind/base
	docker build -t $@ nginx

sagebind/php: sagebind/php
	docker build -t $@ php

sagebind/reverse-proxy: sagebind/nginx
	docker build -t $@ reverse-proxy

sagebind/php-nginx: sagebind/nginx
	docker build -t $@ php-nginx

sagebind/piwik: sagebind/php-nginx
	docker build -t $@ piwik
