FEnics docker container
=====

[![Docker Build Status](https://img.shields.io/docker/automated/jgoldfar/fenics.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/jgoldfar/fenics.svg)](https://hub.docker.com/r/jgoldfar/fenics/)
[![Build Status](https://travis-ci.org/jgoldfar/fenics-docker.svg?branch=master)](https://travis-ci.org/jgoldfar/fenics-docker)

This repository builds containers for [FEniCS](https://fenicsproject.org/) in combination with other codes, and will also hold simple example files to drive a solver.
Look to the [FEniCS in Docker documentation](https://fenics.readthedocs.io/projects/containers/en/latest/) for more information on running examples using this image; using the `base` image should be very nearly identical to using their provided images, with the addition of some tools.

## Setup
-----

First, install [Docker](https://docs.docker.com/engine/getstarted/step_one/).

If you are iterating on the image itself, you can build it locally

```shell
docker build -t jgoldfar/fenics:jupyter -f Dockerfile.jupyter . # or Dockerfile.plain
```

If you're just using the image to run a script, you can pull it (which should be faster and more error-free)
```shell
docker pull jgoldfar/fenics:jupyter # or :base
```

## Usage:
-----

All of the examples in [the documentation](https://fenics.readthedocs.io/projects/containers/en/latest/) should run with the image replaced by `jgoldfar/fenics:base`.
Below, we record some command line instructions to run particular examples against this image.

### Starting Jupyter

[Jupyter](http://www.jupyter.org) is a graphical user interface for a Python REPL; is allows us to easily iterate on a particular algorithm and view plots as output.
The notebooks can be saved and shared (instructions TBD) but are not typically appropriate places to keep "production" code.

To start a Jupyter shell in the FEniCS image, navigate to the directory you would like to save your notebooks (and containing any other application code) and run

```shell
docker run --rm --interactive --workdir /home/fenics --volume "$(pwd)":/home/fenics --publish 127.0.0.1:8888:8888 jgoldfar/fenics:jupyter
```

Make note of the access token that prints to your command line.
You'll need to open [http://localhost:8888](http://localhost:8888) and use the given access token to authenticate.

Your working directory would then be mounted to the `/home/fenics`, and your notebook will start under `/home/fenics` inside the container.

## Other information

### Why should I use this container?

- Easy setup: Install docker, follow the instructions above, and get to work!

- All dependencies for PDE-constrained optimization included.

- According to the [FEnics documentation](https://fenics.readthedocs.io/projects/containers/en/latest/performance.html), docker images can be more performant in some situations.

### Container Descriptions

* `base` contains a FEnics installation with additional packages needed for research codes.

* `jupyter` layers a [jupyter notebook](https://www.jupyter.org) on top of `base` for vizualization and algorithm development.

### Support & Contributions

These instructions are known to work on MacOS (Docker Desktop CE v2, Engine v18.09, Compose v1.23, Machine v0.16) & Linux platforms; once example code can be made public, we will add automated testing of these images against those examples on MacOS and Linux.
Windows + Docker Toolbox support is a work in progress, and is also planned to be supported and tested.

If you run into an issue *with these images* (not with the Docker installation itself), including

- Output from a `docker run` command not appearing as expected

- Included code giving unexpected results

- Missing tools or functionality

- Any other relevant question, concern, or comment

Please open an issue with as much detail as possible on this repository, or (if unsure or confidential) email me (Jonathan Goldfarb) at jgoldfar@my.fit.edu.
