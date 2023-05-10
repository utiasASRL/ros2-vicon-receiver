from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():

    hostname = '100.69.127.99'
    buffer_size = 1024
    topic_namespace = 'vicon'

    return LaunchDescription([Node(
            package='vicon_receiver', executable='vicon_client', output='screen',
            parameters=[{'hostname': hostname, 'buffer_size': buffer_size, 'namespace': topic_namespace}]
        )])
