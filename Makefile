NS = sagebind
DOCKERFILES = $(wildcard */Dockerfile)

all: $(patsubst %/Dockerfile,build-%,$(DOCKERFILES))

push: $(patsubst %/Dockerfile,push-%,$(DOCKERFILES))

build-%:
	docker build -t $(NS)/$* $*

push-%: build-%
	docker push $(NS)/$(subst @,:,$*)
