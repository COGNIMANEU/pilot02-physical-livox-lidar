FROM ros:humble

# Instala dependencias necesarias para ejecutar tests ROS 2
RUN apt-get update && apt-get install -y \
    python3-pytest \
    python3-colcon-common-extensions \
    ros-humble-rclpy \
    ros-humble-sensor-msgs \
    && rm -rf /var/lib/apt/lists/*

# Crear workspace
WORKDIR /test_ws
COPY ./ /test_ws/src/livox_test_pkg

# Compilar tests
RUN . /opt/ros/humble/setup.sh && colcon build --packages-select livox_test_pkg

# Ejecutar test por defecto
CMD ["/bin/bash", "-c", \
     "source /opt/ros/humble/setup.bash && \
      source /test_ws/install/setup.bash && \
      colcon test --packages-select livox_test_pkg && \
      colcon test-result --verbose"]
