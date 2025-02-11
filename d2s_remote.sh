#!/bin/bash
echo "#########################"
echo "This script should be executed on HPC to generate singularity from docker tarball."
echo "Please make sure to have following files available before running this script."
echo "  - $IMAGE_NAME.tar"
echo "  - config.env"
echo "  - d2s_remote.sh"
echo "#########################"

if [ ! -f "config.env" ]; then
    echo "Cannot find 'config.env'. Exiting ..."
    exit
fi
source config.env

if [ ! -f "$IMAGE_NAME.tar" ]; then
    echo "Cannot find $IMAGE_NAME.tar. Exiting ..."
    exit
fi

singularity build $IMAGE_NAME.sif docker-archive:///${PWD}/${IMAGE_NAME}.tar

# (4.1) Create singularity directly from dockerhub repo
# singularity pull docker://cybergisx/ciroh-wrfhydro-postprocess:latest

# (5) [Anvil] Start singularity container
# singularity shell ciroh-wrfhydro-postprocess
