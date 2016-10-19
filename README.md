# Dockerfiles
This repository contains a collection of Dockerfiles, which are specifications of container images for Docker. Official builds of these images are available in [Docker Hub][docker-hub] under my user name.

## Images
Below is a list and brief summary of all the images contained in this repository. The image name is linked to an appropriate README with further details on the image.

### [`base`](base)
A tiny image based on [Alpine Linux][alpine] using [s6] to supervise multiple processes in one container. Most of the images in this repository are based on this image.

### [`nginx`](nginx)
A lightweight [NGINX] image that runs NGINX as an unpriveleged system service.

### [`php-nginx`](php-nginx)
A lightweight PHP application server with PHP 7, PHP-FPM and [NGINX].

### [`piwik`](piwik)
A lightweight image for [Piwik], a popular open-source analytics platform.

### [`php7-legacy`](php7-legacy)
An old Ubuntu-based image containing PHP 7 development tools, made back when PHP 7 was in alpha. Formerly on Docker Hub as `coderstephen/php7`, somehow this poorly-made, outdated image became really popular and had nearly 2 million downloads. To discourage its use, especially in production, it has been renamed to `php7-legacy`.

## License
Unless otherwise indicated, all files in this repository are licensed under the [MIT license][license].


[alpine]: https://www.alpinelinux.org
[docker]: https://www.docker.com
[docker-hub]: https://index.docker.io/u/sagebind
[license]: LICENSE.md
[nginx]: http://nginx.org
[piwik]: http://piwik.org
[s6]: http://skarnet.org/software/s6/
