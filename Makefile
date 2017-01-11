USER = sagebind
IMAGES = base nginx php php-nginx piwik reverse-proxy
BUILD = docker build -t $(USER)/$(1) $(1)


build: $(patsubst %,%.build,$(IMAGES))

push: $(patsubst %,%.push,$(IMAGES))

base.build:
	$(call BUILD,base)

base.push:

nginx.build: base.build
	$(call BUILD,nginx)

nginx.push:

php.build: base.build
	$(call BUILD,php)

php.push:

php-nginx.build: nginx.build
	$(call BUILD,php-nginx)

php-nginx.push:

piwik.build: php-nginx.build
	$(call BUILD,piwik)

piwik.push:

reverse-proxy.build: nginx.build
	$(call BUILD,reverse-proxy)

reverse-build.push:
	docker push $(USER)/reverse-build
