FEnics docker container
=====

[![Docker Build Status](https://img.shields.io/docker/automated/jgoldfar/fenics.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/jgoldfar/fenics.svg)](https://hub.docker.com/r/jgoldfar/fenics/)
[![Build Status](https://travis-ci.org/jgoldfar/fenics-docker.svg?branch=master)](https://travis-ci.org/jgoldfar/fenics-docker)

This repository builds containers for [FEnics](https://fenicsproject.org/) in combination with other codes, and will also hold simple example files to drive a solver.

Setup
-----
First, add your local user to docker group:

```shell
sudo usermod -aG docker YOURUSERNAME
```

build:

```shell
docker build -t jgoldfar/fenics:jupyter -f Dockerfile.jupyter . # or Dockerfile.plain
```

Usage:
-----

```shell
docker run --rm --interactive -v "$(pwd)":/home/fenics/shared jgoldfar/fenics:jupyter
```

Your working directory would then be mounted to the working directory inside the container, so you're ready to run any commands you would want.

Why should I use this container?

-----

- Easy setup
- According to the [FEnics documentation](), docker images can be more performant in some situations.

## Container Descriptions

* `base` contains a FEnics installation with additional packages needed for research codes.

* `jupyter` layers a [jupyter notebook](https://www.jupyter.org) on top of `base` for vizualization and algorithm development.
