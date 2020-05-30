#!/bin/bash

set -e

DEFAULT_USER_ID=0

if [ -v USER_ID ] && [ "$USER_ID" != "$DEFAULT_USER_ID" ]; then
    usermod --uid $USER_ID autoware
    find /home/autoware -user $DEFAULT_USER_ID -exec chown -h $USER_ID {} \;
fi

cd /home/autoware
source /opt/ros/melodic/setup.bash
source /home/autoware/Autoware/install/setup.bash

if [ -z "$1" ]; then
    su autoware -c "/bin/bash"
else
    su autoware -c "exec \"$@\""
fi
