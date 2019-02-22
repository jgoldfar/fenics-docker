FEnics docker container
=====

[![Docker Build Status](https://img.shields.io/docker/automated/jgoldfar/fenics.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/jgoldfar/fenics.svg)](https://hub.docker.com/r/jgoldfar/fenics/)
[![Build Status](https://travis-ci.org/jgoldfar/fenics-docker.svg?branch=master)](https://travis-ci.org/jgoldfar/fenics-docker)

This repository builds containers for [FEniCS](https://fenicsproject.org/) in combination with other codes, and will also hold simple example files to drive a solver.
Look to the [FEniCS in Docker documentation](https://fenics.readthedocs.io/projects/containers/en/latest/) for more information on running examples using this image; using the `base` image should be very nearly identical to using their provided images, with the addition of some tools.

Setup
-----

First, install [Docker](https://docs.docker.com/engine/getstarted/step_one/)

You may need to add your local user to docker group:

```shell
sudo usermod -aG docker YOURUSERNAME
```

If you are iterating on the image itself, you can build it locally

```shell
docker build -t jgoldfar/fenics:jupyter -f Dockerfile.jupyter . # or Dockerfile.plain
```

If you're just using the image to run a script, you can pull it (which should be faster and more error-free)
```shell
docker pull jgoldfar/fenics:jupyter # or :base
```

Usage:
-----

```shell
docker run --rm --interactive --workdir /home/fenics --volumes "$(pwd)":/home/fenics/shared --detach --publish 127.0.0.1:8888:8888 jgoldfar/fenics:jupyter
```

Make note of the access token that prints to your command line.
You'll need to open [http://localhost:8888](http://localhost:8888) and use the given access token to authenticate.

Your working directory would then be mounted to the `/home/fenics/shared`, and your notebook will start under `/home/fenics` inside the container.

Why should I use this container?

-----

- Easy setup
- According to the [FEnics documentation](https://fenics.readthedocs.io/projects/containers/en/latest/performance.html), docker images can be more performant in some situations.

## Container Descriptions

* `base` contains a FEnics installation with additional packages needed for research codes.

* `jupyter` layers a [jupyter notebook](https://www.jupyter.org) on top of `base` for vizualization and algorithm development.
