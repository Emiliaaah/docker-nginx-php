#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit

# exit if required variables aren't set
set -o nounset

# if no arguments are passed, display usage info and exit
if [ "$#" -ne 1 ]; then
        echo -e "\nUsage: build-image <version>\n"
        exit 1
fi

# first argument is version tag
version="$1"

# base directory
basedir="/home/sinc/Dockerfiles/nginx-multistage"

# create docker build image
docker build -t nginx-build:latest -t nginx-build:"$version" "$basedir"/build/.

# build docker and copy build artifacts to volume mount
docker run -it --rm -v "$basedir"/artifacts:/build nginx-build /bin/ash -c "/build-nginx-docker.sh $version"

# copy nginx binary to run image build directory
cp "$basedir"/artifacts/nginx-"$version" "$basedir"/run/nginx

# create docker run image
docker build --build-arg version="$version" -t nginx-run:latest -t nginx-run:"$version" "$basedir"/run/.

# log into my private docker registry
#docker-login

# push the image as both tag names
#docker push docker.seedno.de/seednode/nginx-rtmp:latest
#docker push docker.seedno.de/seednode/nginx-rtmp:"$version"

