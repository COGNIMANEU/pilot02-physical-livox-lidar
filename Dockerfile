# Use the official ROS 2 Humble image as a base
FROM ros:humble

# Install essential dependencies for building ROS 2 packages, PCL, and pcl_conversions
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ros-humble-rclcpp \
    ros-humble-std-msgs \
    libpcl-dev \
    ros-humble-pcl-conversions

# Set environment variables for config and launch paths
ENV LAUNCH_FILE=livox_hub_launch.py  

# Create a workspace and copy the source code into the container
WORKDIR /workspace
COPY ./src /workspace/src

# Copy config and launch folders from the host to the container (ensure these paths exist on the host)
COPY ./config /workspace/src/livox_ros2_driver/config
COPY ./launch /workspace/src/livox_ros2_driver/launch

# Build the workspace using colcon
RUN . /opt/ros/humble/setup.sh && \
    colcon build --symlink-install

# Source the workspace setup script by default
RUN echo 'source /workspace/install/setup.bash' >> /root/.bashrc

# Default command to source the workspace and run a specified launch file
ENTRYPOINT ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash && source /workspace/install/setup.bash && ros2 launch livox_ros2_driver $LAUNCH_FILE"]