#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# FEniCS+
DOCKER_REPO_BASE="fenics"
IMG_TAG=base
docker build -f Dockerfile.${IMG_TAG} -t ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG} .
docker push ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}

# FEniCS with Jupyter notebook
IMG_TAG=jupyter

IMG_TARGET=nbconvert # entrypoint is nbconvert
docker build --target=${IMG_TARGET} -f Dockerfile.${IMG_TAG} -t ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}-${IMG_TARGET} .
docker push ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}-${IMG_TARGET}

# This is the "main" jupyter image for now.
IMG_TARGET=jupyter # entrypoint is notebook
docker build --target=${IMG_TARGET} -f Dockerfile.${IMG_TAG} -t ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG} .
docker push ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}


## In case other images/variants are desired, examples:

## If building multiple targets with one final target,
## uncomment lines below and modify as necessary
#IMG_TARGET=nbconvert # entrypoint is nbconvert
#docker build --target=${IMG_TARGET} -f Dockerfile.${IMG_TAG} -t ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}-${IMG_TARGET} .
#docker push ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}-${IMG_TARGET}


## If building a final target, uncomment lines below and modify as necessary
#IMG_TARGET=jupyter # entrypoint is notebook
#docker build --target=${IMG_TARGET} -f Dockerfile.${IMG_TAG} -t ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG} .
#docker push ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}
