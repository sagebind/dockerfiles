# Seafile server
Lightweight Docker image for [Seafile], a self-hosted file hosting and syncing platform.

The Seafile server is broken up into several components spread around, which can make installation tricky. This Docker image can reduce installation time to just a few minutes. I recommend that you brush up on the [Seafile manual] before setting up your own server; there's a lot to be aware of.

Like most of my images, this image is based off my tiny Alpine base image, and contains the minimal environment needed to run Seafile.

## Usage
You can create a new Seafile container by using a command like below:

```sh
docker run -p 80:80 -p 8082:8082 -p 10001:10001 -p 12001:12001 -v seafile-data:/data -e SERVER_NAME=myserver sagebind/seafile
```

## Logging in
Currently the image does not instrument any users for you, so you will have to do that yourself when you first create your data. You can do this by connecting to the running container and provisioning an account using the command line:

```sh
docker exec -it my_container_name seafile-admin create-admin
```

Follow the interactive prompts to create the user.

## Configuration
There's not many interesting settings to configure that can't be done within the Seafile web interface; the only thing that ought to be overriden is the server name, which can be specified using the aptly-named `SERVER_NAME` environment variable.

Of course, a file-syncing service is not very useful if it can't persist any files. Everything worth persisting is stored in the `/data` volume; be sure to mount the volume somewhere persistent and safe. It might be a good idea to back this volume up as well.

## Building the image
You can build the image yourself by using the `Makefile` in this repository, as usual:

```sh
cd sagebind/dockerfiles
make seafile
```

Note that this image can take quite some time to build, as it compiles Seafile from scratch.


[seafile]: https://www.seafile.com
[seafile manual]: https://manual.seafile.com
