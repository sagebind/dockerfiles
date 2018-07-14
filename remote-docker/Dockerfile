FROM sagebind/base
RUN apk --no-cache add openssh-client
COPY --from=docker:latest /usr/local/bin/docker /usr/local/bin/docker
COPY root /
