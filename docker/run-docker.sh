#!/bin/bash

CONTAINER_NAME="autoware"
AUTOWARE_LAUNCH="on"

PROG_NAME=$(basename $0)
RUN_DIR=$(dirname $(readlink -f $0))

PARAM_YML=${RUN_DIR}/param/param_init.yaml
SAVE_PATH=""

function usage_exit {
  cat <<_EOS_ 1>&2
  Usage: $PROG_NAME [OPTIONS...]
  OPTIONS:
    -h, --help          このヘルプを表示
    -p, --param FILE    読み込むAutowareの設定ファイルを指定
    -s, --save FILE     Autowareの設定ファイルの保存先を指定
    -n, --name NAME     コンテナの名前を指定
_EOS_
    cd ${CURRENT_DIR}
    exit 1
}

while (( $# > 0 )); do
    if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
        usage_exit
    elif [[ $1 == "--param" ]] || [[ $1 == "-p" ]]; then
        if [[ -f $2 ]]; then
            PARAM_YML=$2
        else
            echo "無効なパラメータ： $1 $2"
            usage_exit
        fi
        shift 2
    elif [[ $1 == "--save" ]] || [[ $1 == "-s" ]]; then
        if [[ -d $(dirname $(readlink -f $2)) ]]; then
            SAVE_PATH=$2
        else
            echo "無効なパラメータ： $1 $2"
            usage_exit
        fi
        shift 2
    elif [[ $1 == "--name" ]] || [[ $1 == "-n" ]]; then
        if [[ $2 == -* ]] || [[ $2 == *- ]]; then
            echo "無効なパラメータ： $1 $2"
            usage_exit
        fi
        CONTAINER_NAME=$2
        shift 2
    else
        echo "無効なパラメータ： $1"
        usage_exit
    fi
done

DOCKER_IMAGE="carla/autoware:1.14.0-alpha.1-melodic-cuda"

XSOCK="/tmp/.X11-unix"
XAUTH="/tmp/.docker.xauth"

HOST_WS=$(dirname $(dirname $(readlink -f $0)))/shared_dir
PARAM_YML=${RUN_DIR}/param/param_init.yaml
cp ${PARAM_YML} ${RUN_DIR}/src/param.yaml

DOCKER_VOLUME="-v ${XSOCK}:${XSOCK}:rw"
DOCKER_VOLUME="${DOCKER_VOLUME} -v ${XAUTH}:${XAUTH}:rw"
DOCKER_VOLUME="${DOCKER_VOLUME} -v ${RUN_DIR}/src/param.yaml:/home/autoware/Autoware/install/runtime_manager/lib/runtime_manager/param.yaml:rw"
DOCKER_VOLUME="${DOCKER_VOLUME} -v ${HOST_WS}:/home/autoware/shared_dir:rw"

DOCKER_ENV="-e XAUTHORITY=${XAUTH}"
DOCKER_ENV="${DOCKER_ENV} -e DISPLAY=$DISPLAY"
DOCKER_ENV="${DOCKER_ENV} -e TERM=xterm-256color"
DOCKER_ENV="${DOCKER_ENV} -e QT_X11_NO_MITSHM=1"

DOCKER_NET="host"

touch ${XAUTH}
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -

docker run \
    --rm \
    -it \
    --gpus all \
    --privileged \
    --name ${CONTAINER_NAME} \
    --net ${DOCKER_NET} \
    ${DOCKER_ENV} \
    ${DOCKER_VOLUME} \
    ${DOCKER_IMAGE}

if [[ -f ${RUN_DIR}/src/param.yaml ]]; then
    if [[ ${SAVE_PATH} != "" ]]; then
        cp ${RUN_DIR}/src/param.yaml ${SAVE_PATH}
    fi
    rm ${RUN_DIR}/src/param.yaml
fi
