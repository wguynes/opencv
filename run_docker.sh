#!/bin/bash

docker run -it \
    --env HOST_USERNAME=${USER} \
    --env HOST_UID=$(id -u) \
    --env HOST_GID=$(id -g) \
    --env HOST_USERHOME=${HOME} \
    --env HOST_PWD=${PWD} \
    --volume ${HOME}:${HOME} \
    raspbian:8.0
