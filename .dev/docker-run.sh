#!/usr/bin/env bash

IMAGE_NAME="${IMAGE_NAME:-$(basename $(pwd))}"
IMAGE_TAG="development"

function _which() {
  which "$1" > /dev/null
}

if _which npm \
&& ! _which nodemon; then
  npm i -g nodemon
fi

DOCKER_BUILD="docker build \
  -t "${IMAGE_NAME}:${IMAGE_TAG}" \
  ."

# If we run in nodemon we don't want
# to pass that we need a TTY
! _which nodemon && [ -t 0 ] && TTY=t

DOCKER_RUN="docker run \
             -i${TTY} \
             --rm \
             -p 8080:8080 \
             --init \
             ${IMAGE_NAME}:development"

_which nodemon \
  && nodemon \
      -e sh,js,json,tmpl,css,html \
      -x "$DOCKER_BUILD; $DOCKER_RUN" \
  || eval "$DOCKER_RUN"