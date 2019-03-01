#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Run notebook (nbconvert) example
docker run --rm --workdir /home/fenics --volume "$(pwd)":/home/fenics/shared jgoldfar/fenics:jupyter-nbconvert --to notebook --execute --output ex-check.ipynb shared/test/demo.ipynb

# Run FEniCS example
docker run --rm --workdir /home/fenics --volume "$(pwd)":/home/fenics/shared jgoldfar/fenics:base python3 demo/python/documented/neumann-poisson/demo_neumann-poisson.py

# Run example using code in local (external to the image) directory
docker run --rm --workdir /home/fenics --volume "$(pwd)":/home/fenics/shared jgoldfar/fenics:base python3 shared/test/testcode.p
