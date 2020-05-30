ARG SRC_IMG="autoware/autoware:1.14.0-melodic-cuda"
FROM ${SRC_IMG}

USER root
RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        bash-completion \
        git-lfs \
        python-pip

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 92635A407F7A020C && \
    add-apt-repository "deb [arch=amd64 trusted=yes] http://dist.carla.org/carla-0.9.9/ all main" && \
    apt-get update && \
    apt-get install -y \
        ros-melodic-ackermann-msgs \
        ros-melodic-derived-object-msgs \
        ros-melodic-tf \
        ros-melodic-cv-bridge \
        ros-melodic-pcl-conversions \
        ros-melodic-pcl-ros \
        ros-melodic-ainstein-radar \
        carla-simulator && \
    cd /opt/carla-simulator/ && \
    bash ImportAssets.sh && \
    pip install simple-pid

USER autoware
WORKDIR /home/autoware

RUN pip install pygame numpy

RUN git clone https://bitbucket.org/carla-simulator/autoware-contents.git carla-map && \
    cd carla-map && \
    git lfs pull
RUN echo "alias autoware='roslaunch runtime_manager runtime_manager.launch'" >> /home/autoware/.bashrc && \
    echo "alias carla='bash /opt/carla-simulator/bin/CarlaUE4.sh'" >> /home/autoware/.bashrc && \
    echo "if [[ -f /home/autoware/catkin_ws/devel/setup.bash ]]; then" >> /home/autoware/.bashrc && \
    echo "    source /home/autoware/catkin_ws/devel/setup.bash" >> /home/autoware/.bashrc && \
    echo "fi" >> /home/autoware/.bashrc && \
    echo "source /home/autoware/Autoware/install/setup.bash" >> /home/autoware/.bashrc && \
    mkdir /home/autoware/catkin_ws

USER root
WORKDIR /root

ENV CARLA_MAPS_PATH /home/autoware/carla-map/maps/
ENV PYTHONPATH ${PYTHONPATH}:/opt/carla-simulator/PythonAPI/carla/dist/carla-0.9.9-py2.7-linux-x86_64.egg

COPY ./entrypoint.sh /tmp
ENTRYPOINT ["/tmp/entrypoint.sh"]
