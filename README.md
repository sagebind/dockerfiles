# Docker PHP7 Images
This repository contains configuration files for building Docker images with the latest PHP code (master branch) with various configurations and environments.

## Variants
Multiple image variants are available, with more to come in the future. The currently available variants are:

- `coderstephen/php7:latest`: Variant equivalent to the `apache` variant below
- `coderstephen/php7:apache` Ubuntu environment with Apache 2

## Building
To build all variants, run `make` as root:

```sh
sudo make
```
