#!/bin/bash
DOCKER_DIR=$(dirname $(readlink -f $0))

if [[ -f ~/.bash_aliases ]]; then
    if [[ $(cat ~/.bash_aliases | grep autoware-run) != "" ]]; then
        echo '"autoware-run" is already exist.'
    else
        echo "alias autoware-run='${DOCKER_DIR}/run-docker.sh'" >> ~/.bash_aliases
    fi

    if [[ $(cat ~/.bash_aliases | grep autoware-exec) != "" ]]; then
        echo '"autoware-exec" is already exist.'
    else
        echo "alias autoware-exec='${DOCKER_DIR}/exec-docker.sh'" >> ~/.bash_aliases
    fi
else
    echo "alias autoware-run='${DOCKER_DIR}/run-docker.sh'" >> ~/.bash_aliases
    echo "alias autoware-exec='${DOCKER_DIR}/exec-docker.sh'" >> ~/.bash_aliases
fi
