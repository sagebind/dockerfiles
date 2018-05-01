# MkDocs
MkDocs builder in a lightweight Docker image.

You can use this image to build your static site without installing any dependencies on your build system:

```sh
docker run -it --rm -v /path/to/source:/src -v /path/to/output:/build --user=$UID:$GID sagebind/mkdocs
```
