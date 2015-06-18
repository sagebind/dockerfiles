# Docker PHP7 Images
This repository contains configuration files for building Docker images with the latest PHP code (master branch) with various configurations and environments. Images are Ubuntu 15.04-based.

These images provide development environments for testing and running code against various versions of PHP, including development versions of PHP7. This is heavily inspired by Rasmus Lerdorf's [Vagrant box](https://github.com/rlerdorf/php7dev); this is meant for those who prefer a lighter Docker image than a full-blown virtual machine.

Currently this image comes with a pre-configured Apache install.

## Switching PHP versions
Tweaked versions of Rasmus's original build scripts are available in this Docker image; see documentation [here](https://github.com/rlerdorf/php7dev/blob/master/README.md).

## Getting the latest PHP7 version
Images are rebuilt nightly at [Docker.com](https://registry.hub.docker.com/u/coderstephen/php7); pulling a new image will give you the latest version of PHP7. To update by hand in an existing container, you can run

```sh
$ makephp 70
```

which will automatically pull the latest version and compile it.
