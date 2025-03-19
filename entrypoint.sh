#!/bin/bash

# Source the ROS 2 setup file
source /opt/ros/humble/setup.bash
source /workspace/install/setup.bash

# Set default configuration and launch paths if they aren't provided
CONFIG_PATH=${CONFIG_PATH:-/workspace/config/pilot2}
LAUNCH_PATH=${LAUNCH_PATH:-/workspace/launch/pilot2}
RVIZ_CONFIG_FILE=${RVIZ_CONFIG_FILE:-livox_hub.rviz}
LAUNCH_FILE=${LAUNCH_FILE:-livox_hub_launch.py}

# Check if the configuration files exist, if not, throw an error
if [ ! -f "$CONFIG_PATH/$RVIZ_CONFIG_FILE" ]; then
    echo "Error: Configuration file $RVIZ_CONFIG_FILE not found in $CONFIG_PATH"
    exit 1
fi

if [ ! -f "$CONFIG_PATH/livox_hub_config.json" ]; then
    echo "Error: livox_hub_config.json not found in $CONFIG_PATH"
    exit 1
fi

# Check if the launch file exists
if [ ! -f "$LAUNCH_PATH/$LAUNCH_FILE" ]; then
    echo "Error: Launch file $LAUNCH_FILE not found in $LAUNCH_PATH"
    exit 1
fi

# Run the ROS 2 launch command with the specified launch file
ros2 launch $LAUNCH_PATH/$LAUNCH_FILE
