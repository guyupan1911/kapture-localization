#!/usr/bin/env bash

DOCKER_USER="${USER}"
KAPTURE_CONTAINER="kapture_${USER}"

xhost +local:root 1>/dev/null 2>&1

docker exec \
    -it "${KAPTURE_CONTAINER}" \
    /bin/bash

xhost -local:root 1>/dev/null 2>&1
