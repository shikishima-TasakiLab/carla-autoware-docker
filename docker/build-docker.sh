#!/bin/bash
BUILD_DIR=$(dirname $(readlink -f $0))

docker build \
    -t carla/autoware:1.14.0-melodic-cuda \
    ${BUILD_DIR}/src
    
if [[ $? != 0 ]]; then
    echo "エラーにより中断しました．"
    exit 1
fi