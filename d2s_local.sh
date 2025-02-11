#!/bin/bash
echo "#########################"
echo "This script should be executed LOCALLY to generate tarball of docker image."
echo "#########################"

source config.env
# (1) [Local] create local image from the `docker` directory
echo "Creating docker image: $IMAGE_NAME"
cd docker
sh docker_run.sh
cd ..
# (2) [Local] export local docker image to tarball
echo "Creating docker image tarbal: $IMAGE_NAME.tar"
EXPORT_IMAGE_ID=$(docker images -q $IMAGE_NAME)
echo $EXPORT_IMAGE_ID
#docker save $EXPORT_IMAGE_ID -o $IMAGE_NAME.tar

command_status=$?
if [ $command_status -eq 0 ]; then
    echo "#########################"
    echo "Local tar $IMAGE_NAME.tar created. Upload to remote HPC with singularity."
    echo "Please make sure to copy following files on remote HPC."
    echo "  - $IMAGE_NAME.tar"
    echo "  - config.env"
    echo "  - d2s_remote.sh"
    echo "#########################"
else
    echo "Creating local tar failed with exit code $command_status."
fi
