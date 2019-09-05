FEniCS+ docker container
=====

[![Docker Build Status](https://img.shields.io/docker/automated/jgoldfar/fenics.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/jgoldfar/fenics.svg)](https://hub.docker.com/r/jgoldfar/fenics/)
[![Build Status](https://travis-ci.org/jgoldfar/fenics-docker.svg?branch=master)](https://travis-ci.org/jgoldfar/fenics-docker)

This repository builds containers for [FEniCS](https://fenicsproject.org/) in combination with other codes, and will also hold simple example files to drive a solver.
Look to the [FEniCS in Docker documentation](https://fenics.readthedocs.io/projects/containers/en/latest/) for more information on running examples using this image; using the `base` image should be very nearly identical to using their provided images, with the addition of some tools.

See below for setup and usage instructions; additional information, as well as contact and contribution information, can be found at the end of this document.



## Setup

First, install [Docker](https://docs.docker.com/engine/getstarted/step_one/).
Windows users using [Docker Desktop](https://www.docker.com/products/docker-desktop) should be able to follow the same instructions as Linux/MacOS users, but users of Windows 10 Home or older will have to use [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/).
The default installation configuration should work fine.

If you are iterating on the image itself, you can build it locally

```shell
docker build -t jgoldfar/fenics:jupyter -f Dockerfile.jupyter . # or Dockerfile.plain
```

If you're just using the image to run a script, you can pull it (which should be faster and more error-free)

```shell
docker pull jgoldfar/fenics:jupyter # or :base
```


## Usage

Using Docker is (somewhat) beyond the scope of this readme file; look to the Docker website, or the output of running `docker` at the command line, to see what commands are available.
We mostly make use of two commands to run examples:

* `docker pull`: Download a new version of a given image from an image repository

* `docker run`: Instantiate an image in a container and run a command inside the container.


Since Docker isolates FEniCS and the other pakcages installed in the images from any other system differences, all of the examples in [the documentation](https://fenics.readthedocs.io/projects/containers/en/latest/) should run with the image replaced by `jgoldfar/fenics:base`.
Below, we record some command line instructions to run particular examples against this image.

*Note*: Running a command with `--rm` after `docker run` will destroy the container after it exits.
If you want to save any output data, you'll have to move it to a directory mounted as a docker volume, such as `/home/fenics/shared` in the command below.

### Starting Jupyter

[Jupyter](http://www.jupyter.org) is a graphical user interface for a Python REPL; is allows us to easily iterate on a particular algorithm and view plots as output.
The notebooks can be saved and shared (instructions TBD) but are not typically appropriate places to keep "production" code.

*On Linux or MacOS*, to start a Jupyter shell in the FEniCS image, navigate to the directory you would like to save your notebooks (and containing any other application code) and run

```shell
docker run --rm --interactive --workdir /home/fenics --volume "$(pwd)":/home/fenics/shared --publish 127.0.0.1:8888:8888 jgoldfar/fenics:jupyter
```

The output will contain a message like

```
To access the notebook, open this file in a browser:
    <snip>
Or copy and paste one of these URLs:
    http://(59aff980fff1 or 127.0.0.1):8888/?token=<snip>
```

Copy the whole URL provided (including the token) and replace the contents of the parentheses with just `127.0.0.1` to open your browser.

Your working directory would then be mounted to `/home/fenics/shared`, and your notebook will start with `/home/fenics` as a working directory inside the container.
Demonstration files will be available under `/home/fenics/demo`.

*On Windows using Docker Toolbox*, to start a jupyter shell as above, first 

- Open the Docker Quickstart Terminal and navigate to your code directory (or type `cd` to go to your user directory)

- Run and make note of the output of the command `docker-machine ip default`

- Then, run

```shell
docker run --rm --interactive --workdir /home/fenics --volume "${pwd}":/home/fenics/shared --publish $(docker-machine ip default):8888:8888 jgoldfar/fenics:jupyter
```

The output will contain a message like

```
To access the notebook, open this file in a browser:
    <snip>
Or copy and paste one of these URLs:
    http://(59aff980fff1 or 127.0.0.1):8888/?token=<snip>
```

Copy and paste the url (including the whole token) and replace the part in parentheses with the output of `docker-machine ip default`.



### Running a FEniCS example

The FEniCS examples are installed under `/home/fenics/demo`; we can run the `neumann_poisson` example script by calling

```shell
docker run --rm --workdir /home/fenics --volume "$(pwd)":/home/fenics/shared jgoldfar/fenics:base "python3 demo/python/documented/neumann-poisson/demo_neumann-poisson.py"
```



### Running an example with a local file

If you have any files in your current working directory when running the above command, they will appear under the `shared` directory after opening the image.
A Python code from the FEniCS documentation is available under the `test` directory, can can be run by calling

```shell
docker run --rm --workdir /home/fenics --volume "$(pwd)":/home/fenics/shared jgoldfar/fenics:base "python3 shared/test/testcode.py"
```

## Other information



### Why should I use this container?

- Easy setup: Install docker, follow the instructions above, and get to work!

- All dependencies for PDE-constrained optimization included.

- According to the [FEnics documentation](https://fenics.readthedocs.io/projects/containers/en/latest/performance.html), docker images can be more performant in some situations.

- We regularly test that example scripts contained in this repository continue to run against the corresponding FEniCS image.

### Container Descriptions

* `base` contains a FEnics installation with additional packages needed for research codes.

* `jupyter` layers a [jupyter notebook](https://www.jupyter.org) on top of `base` for vizualization and algorithm development.

### Useful Links

* [Docker Toolbox](https://docs.docker.com/toolbox/overview/)

* [Docker](https://docs.docker.com/)

* [FEniCS](https://fenicsproject.org/), as well as [FEniCS-on-Docker](https://fenics.readthedocs.io/projects/containers/en/latest) documentation.

* [NumPy QuickStart](https://docs.scipy.org/doc/numpy/user/quickstart.html)



### Support & Contributions

These instructions are known to work on MacOS (Docker Desktop CE v2, Engine v18.09, Compose v1.23, Machine v0.16) & Linux platforms; once example code can be made public, we will add automated testing of these images against those examples on MacOS and Linux.
Windows + Docker Toolbox support is a work in progress, and is also planned to be supported and tested.

If you run into an issue *with these images* (not with the Docker installation itself), including

- Output from a `docker run` command not appearing as expected

- Included code giving unexpected results

- Missing tools or functionality

- Any other relevant question, concern, or comment

Please open an issue with as much detail as possible on this repository, or (if unsure or confidential) email me (Jonathan Goldfarb) at jgoldfar@my.fit.edu.
