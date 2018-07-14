# remote-docker
Connect to a Docker engine on a remote host using SSH and then run commands against it.

This container will allow you to connect to a remote Docker engine with an SSH key by using SSH port forwarding. This is simpler and more secure than exposing the Docker socket over TLS and maintaining separate Docker TLS certificates.
