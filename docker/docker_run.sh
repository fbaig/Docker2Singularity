#!/bin/bash

source ../config.env
#docker build -t $IMAGE_NAME .
docker build --platform linux/amd64 -t $IMAGE_NAME .

######################
# Uncomment if you want to test/debug local docker image
######################
# docker run \
#        --rm \
#        --name docker2singularity_local_tmp \
#        -it \
#        -v "${PWD}":/shared/ \
#        $IMAGE_NAME \
#        /bin/sh
