FROM autoware/autoware:1.14.0-alpha.1-melodic-cuda

USER root
RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        git-lfs \
        python-pip

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 304F9BC29914A77D && \
    add-apt-repository "deb [arch=amd64 trusted=yes] http://dist.carla.org/carla-0.9.8/ all main" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 81061A1A042F527D && \
    add-apt-repository "deb [arch=amd64 trusted=yes] http://dist.carla.org/carla-ros-bridge-melodic/ bionic main" && \
    apt-get update && \
    apt-get install -y \
        carla-simulator \
        carla-ros-bridge-melodic && \
    cd /opt/carla-simulator/ && \
    bash ImportAssets.sh && \
    pip install simple-pid

USER autoware
WORKDIR /home/autoware
RUN git clone https://bitbucket.org/carla-simulator/autoware-contents.git carla-map && \
    cd carla-map && \
    git lfs pull && \
    echo "alias carla='bash /opt/carla-simulator/bin/CarlaUE4.sh'" >> /home/autoware/.bashrc && \
    echo "source /opt/carla-ros-bridge/melodic/setup.bash" >> /home/autoware/.bashrc && \
    echo "source /home/autoware/Autoware/install/setup.bash" >> /home/autoware/.bashrc
ENV CARLA_MAPS_PATH /home/autoware/carla-map/maps/

COPY ./entrypoint.sh /tmp
ENTRYPOINT ["/tmp/entrypoint.sh"]
