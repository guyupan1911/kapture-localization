#!/usr/bin/env bash

KAPTURE_CONTAINER="kapture_${USER}"
KAPTURE_IMAGE="kapture"
KAPTURE_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

function build_from_Dockerfile_if_no_exist() {
  local image="$1"
  if [[ "$(docker images -q ${KAPTURE_IMAGE} 2> /dev/null)" != "" ]]; then
      echo "image ${KAPTURE_IMAGE} exists"
  else
      echo "build image from Dockerfile"
      docker build -t ${KAPTURE_IMAGE} -f ${KAPTURE_ROOT_DIR}/docker/scripts/Dockerfile .
  fi   
}

function remove_container_if_exists() {
    local container="$1"
    if docker ps -a --format '{{.Names}}' | grep -q "${container}"; then
        info "Removing existing container: ${container}"
        docker stop "${container}" >/dev/null
        docker rm -v -f "${container}" 2>/dev/null
    fi
}

function start_container() {
    local image="$1"
    info "Starting docker container \"${KAPTURE_CONTAINER}\" ..."

    local local_host="$(hostname)"

    local display="${DISPLAY:-:0}"

    local local_volumes="-v ${KAPTURE_ROOT_DIR}:/kapture-localization"
    local data_volumes="-v /home/yuxuanhuang/DataSet:/Dataset"

    xhost +local:docker
    set -x
    docker run -itd \
        --rm \
        --runtime=nvidia \
        --privileged=true \
        --name "${KAPTURE_CONTAINER}" \
        -e DISPLAY="${display}" \
        -e DOCKER_IMG="${image}" \
        -e USE_GPU_HOST="${USE_GPU_HOST}" \
        -e NVIDIA_VISIBLE_DEVICES=all \
        -e NVIDIA_DRIVER_CAPABILITIES=compute,video,graphics,utility \
        -e OMP_NUM_THREADS=1 \
        ${local_volumes} \
        ${data_volumes} \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --net host \
        -w /kapture-localization \
        --pid=host \
        "${KAPTURE_IMAGE}" \
        /bin/bash

    if [ $? -ne 0 ]; then
        error "Failed to start docker container \"${CYBER_CONTAINER}\" based on image: ${image}"
        exit 1
    fi
    set +x
}

BOLD='\033[1m'
RED='\033[0;31m'
BLUE='\033[1;34;48m'
GREEN='\033[32m'
WHITE='\033[34m'
YELLOW='\033[33m'
NO_COLOR='\033[0m'

function ok() {
  (echo >&2 -e "[${GREEN}${BOLD} OK ${NO_COLOR}] $*")
}

function main() {
    build_from_Dockerfile_if_no_exist "${KAPTURE_IMAGE}"

    remove_container_if_exists "${KAPTURE_CONTAINER}"

    start_container "${image}"

    ok "Congratulations! You have successfully finished setting up kapture Docker environment."
    ok "To log into the newly created kapture container, please run the following command:"
    ok "  bash docker/scripts/dev_into.sh"
    ok "Enjoy!"
}

main "$@"