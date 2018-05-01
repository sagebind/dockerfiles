FROM alpine
RUN apk --no-cache add python3 && \
    pip3 install mkdocs mkdocs-material
VOLUME ["/src", "/build"]
WORKDIR /src
ENTRYPOINT ["/usr/bin/mkdocs"]
CMD ["build", "--site-dir", "/build"]
