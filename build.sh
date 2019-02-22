#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Debian + Octave
DOCKER_REPO_BASE="fenics"
for IMG_TAG in base jupyter ; do
docker build -f Dockerfile.${IMG_TAG} -t ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG} .
docker push ${DOCKER_USERNAME}/${DOCKER_REPO_BASE}:${IMG_TAG}
done
