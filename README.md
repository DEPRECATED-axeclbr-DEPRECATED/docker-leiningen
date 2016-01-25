# docker-leiningen
lein - Leiningen build tool for automating Clojure projects in Docker

[![ImageLayers Size](https://img.shields.io/imagelayers/image-size/axeclbr/leiningen/latest.svg?style=flat-square)](https://imagelayers.io/?images=axeclbr/leiningen:latest)
[![Twitter Follow](https://img.shields.io/twitter/follow/axeclbr.svg?style=social)](https://twitter.com/intent/follow?screen_name=axeclbr)

## Usage

The purpose of this container is not to run Leiningen with files on your hostsystem. It is aimed to be useful as a base-image for leiningen-projects inside of a Docker Container.

### Tutorial

We will create a [luminus webapp](http://www.luminusweb.net/) and run it inside a Docker Container.

First open a shell and cd into your workspace / projects / playground / whatever-directory. Then type:

    $ lein new luminus hello-lein-docker
    $ cd hello-lein-docker
    $ cp .gitignore .dockerignore

The .dockerignore-file is added to increase build-performance. For more information take a look at the [documentation for .dockerignore](https://docs.docker.com/engine/reference/builder/#dockerignore-file).

Next create a new file with the name ``Dockerfile`` and add the following content

```dockerfile
FROM axeclbr/leiningen

MAINTAINER Your Name <Your.Name@youremailaddr.ess>

COPY . /root/hello-lein-docker

WORKDIR /root/hello-lein-docker

RUN /usr/local/bin/lein deps

CMD ["/usr/local/bin/lein", "run"]

```

Now you are ready to build the docker container:

    $ docker build -t myleincontainer .

It will take a few seconds for the container to be built. Thanks to executing ``lein deps`` with the ``RUN``-command in the Dockerfile, all dependencies of your project are **downloaded only once** and stored inside the container.

Finally you have to start your container

    $ docker run -it --rm -p 3000:3000 myleincontainer

Now your new clojure-luminus-project is started inside the container and listening on the default port 3000. Because of the parameter ``-p 3000:3000`` the port is also accessible on the host-machine and you should be able to display the welcome-page with opening the following URL in your preferred browser:

    http://localhost:3000

##### Open the welcome page on a Mac

If you are on a Mac and not on Linux, probably your docker container is not running on the host system directly but inside [docker-machine](https://docs.docker.com/machine/). So you have to display the IP of the VM, which runs docker with:

    $ docker-machine ip <machine-name>

And then in the next step you just open this IP on port 3000 in your preferred browser:

    http://<docker-machine-ip>:3000

Have fun!
