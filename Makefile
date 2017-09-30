NS = sagebind
IMAGES = base \
		digitalocean-ddns \
		gitweb \
		nginx \
		php \
		php-nginx \
		piwik@latest \
		piwik@3 \
		piwik@3.0 \
		piwik@3.0.4 \
		piwik@2 \
		piwik@2.17 \
		piwik@2.17.1 \
		prosody \
		reverse-proxy \
		rust-worker@stable \
		rust-worker@nightly \
		seafile \
		znc
PUSHES = $(patsubst %,%/push,$(IMAGES))


.PHONY: build
build: $(IMAGES)

.PHONY: push
push: $(PUSHES)

.PHONY: .FORCE
.FORCE:
$(IMAGES) $(PUSHES): .FORCE

%/push:
	docker push $(NS)/$(subst @,:,$*)

base:
	docker build -t $(NS)/base base

digitalocean-ddns: base
	docker build -t $(NS)/digitalocean-ddns digitalocean-ddns

gitweb: nginx
	docker build -t $(NS)/gitweb gitweb

nginx: base
	docker build -t $(NS)/nginx nginx

php: base
	docker build -t $(NS)/php php

php-nginx: nginx
	docker build -t $(NS)/php-nginx php-nginx

piwik: piwik@latest

piwik@3: piwik@3.0
	docker tag $(NS)/piwik:3.0 $(NS)/piwik:3

piwik@3.0: piwik@3.0.4
	docker tag $(NS)/piwik:3.0.4 $(NS)/piwik:3.0

piwik@2: piwik@2.17
	docker tag $(NS)/piwik:2.17 $(NS)/piwik:2

piwik@2.17: piwik@2.17.1
	docker tag $(NS)/piwik:2.17.1 $(NS)/piwik:2.17

piwik@%: php-nginx
	docker build --build-arg PIWIK_VERSION=$* -t $(NS)/piwik:$* piwik

prosody: nginx
	docker build -t $(NS)/prosody prosody

reverse-proxy: nginx
	docker build -t $(NS)/reverse-proxy reverse-proxy

rust-worker@%:
	docker build --build-arg TOOLCHAIN=$* -t $(NS)/rust-worker:$* rust-worker

seafile: base
	docker build -t $(NS)/seafile seafile

znc: base
	docker build -t $(NS)/znc znc
