import rclpy
from rclpy.node import Node
from sensor_msgs.msg import PointCloud2
import pytest

received = False

class PointCloudTester(Node):
    def __init__(self):
        super().__init__('pilot02-physical-livox-lidar_tester')
        self.subscription = self.create_subscription(
            PointCloud2,
            '/livox/lidar',  # Make sure to use the correct topic from the driver
            self.listener_callback,
            10)

    def listener_callback(self, msg):
        global received
        received = True
        self.get_logger().info('✅ PointCloud2 message received!')

@pytest.mark.ros2
def test_livox_lidar_pointcloud_publishing():
    global received
    rclpy.init()
    node = PointCloudTester()
    try:
        timeout = 15  # seconds
        end_time = node.get_clock().now().nanoseconds / 1e9 + timeout
        while not received and (node.get_clock().now().nanoseconds / 1e9 < end_time):
            rclpy.spin_once(node, timeout_sec=0.5)
    finally:
        node.destroy_node()
        rclpy.shutdown()
    assert received, "❌ No PointCloud2 message was received"
