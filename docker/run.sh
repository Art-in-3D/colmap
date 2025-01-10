#!/bin/bash

set -ex

docker build -t="colmap:latest" --build-arg CUDA_ARCHITECTURES=75 .

docker run \
    -it \
    --runtime nvidia --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env HOME="$HOME" \
    --workdir="$PWD" \
    --volume "$HOME":"$HOME" \
    --env HISTFILE="$HOME"/.bash_history_colmap \
    colmap:latest

# Might required: 'xhost + local:' on the host machine

# docker pull colmap/colmap:latest
# docker run --gpus all -w /working -v $1:/working -it colmap/colmap:latest
