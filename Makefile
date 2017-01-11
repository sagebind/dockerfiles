USER = sagebind
IMAGES = base nginx php php-nginx piwik reverse-proxy
BUILD = docker build -t $(USER)/$(1) $(1)


build: $(patsubst %,%.build,$(IMAGES))

push: $(patsubst %,%.push,$(IMAGES))

base.build:
	$(call BUILD,base)

base.push:
	docker push $(USER)/base

nginx.build: base.build
	$(call BUILD,nginx)

nginx.push:
	docker push $(USER)/nginx

php.build: base.build
	$(call BUILD,php)

php.push:
	docker push $(USER)/php

php-nginx.build: nginx.build
	$(call BUILD,php-nginx)

php-nginx.push:
	docker push $(USER)/php-nginx

piwik.build: php-nginx.build
	$(call BUILD,piwik)

piwik.push:
	docker push $(USER)/piwik

reverse-proxy.build: nginx.build
	$(call BUILD,reverse-proxy)

reverse-proxy.push:
	docker push $(USER)/reverse-proxy

znc.build: base.build
	$(call BUILD,base)

znc.push:
	docker push $(USER)/znc
