# How to tranform MATLAB robotics toolbox to MoveIt2

Written by *Peter Chang* on 2026/05/11

```text
MATLAB Robotics Toolbox
        ↓
ROS2 core concepts
        ↓
Generic robot-arm ROS topics
        ↓
MoveIt2 + ros2_control
        ↓
THEN Kinova Kortex
```

## Targeted understanding

- kinematics: Jacobian, SDH, robot tree, frames (tf2)
- dynamics: generalized torque equation
- control theory: local feedback and torque control with electric motor, adaptive control (Jacobianless)
- MATLAB: robotics toolbox, ROS toolbox
- system thinking: DDS ROS topic to RTOS on STM32

### Building all the above into

```text
ROS2 middleware intuition
+
topic/interface literacy
+
distributed robotics architecture
```

### combine robotics toolbox to refresh robotics

Espcially URDF to robot tree import, but not "underneeth", ture SDH understanding and full Jacobian for $v$ and $\omega$.

### Not only memorizing Kinova Kortex

As only:

```text
drivers
CMake
colcon
MoveIt
controllers
URDF
launch files
QoS
actions
services
```

### steps

1. MATLAB
    - rigidBodyTree
    - transforms
    - trajectories
    - Jacobians
    - visualization
    - ROS2 publisher/subscriber basics
2. ROS2 Generic Topics
    - ros2 topic list
    - ros2 topic info
    - ros2 interface show
    - sensor_msgs/msg/JointState
    - geometry_msg/Twist
    -trajectory_msgs/msg/JointTrajectory

### table of concepts

Semantic Meaning|Common ROS Message|MoveIt2 Topic
---|:---:|---:  
Joint states|`JointState`|??
Cartesian pose|`Pose`|??
Velocity|`Twist`|??
Forces|`Wrench`|??
Trajectory|`JointTrajectory`|??
Coordiante frames|`tf2`|??

### MoveIt2 + ros2_control

```text
planner
→ controller
→ trajectory
→ hardware interface
→ actuators
```

### Finally Kinova Kortex

The following is the full Kortex Github: [link to Kortex github](https://github.com/Kinovarobotics/ros2_kortex?utm_source=chatgpt.com)

And it's associated API documentation: [Link to kortex document on API](https://docs.kinovarobotics.com/?utm_source=chatgpt.com)

Make sure gone through rclcpp/rclpy for ROS2 node understanding and MoveIt2 common topics for robotics control!!!

## MoveIt2 mental model

A robot arm alone only knows:

> - motor positions
> - velocities
> - torques

MoveIt 2 adds:

- motion planning
- collision avoidance
- inverse kinematics
- trajectory generation
- scene awareness
- grasp planning

this is full `MATLAB robotics toolbox planning used with implementation methodology`

### all done with

Function               | Meaning
-----------------------|----------------------------  
Motion Planning        | Compute valid robot motion
Inverse Kinematics     | Solve end-effector poses
Collision Check        | Avoid self/world collisions
Trajectory Generation  | Smooth motion control
Planning Scene         | Understand obstacles
Servoing               | Real-time Cartesian control
Grasp Planning         | Pick-and-place
Controller Integration | Send trajectories to hardware

The following is the github link to MoveIt2: [link to MoveIt2 github](https://github.com/moveit/moveit2?utm_source=chatgpt.com)

The following is the documentation link to MoveIt2: [link to MOveIt2 documentation webpage](https://moveit.picknik.ai/main/index.html)

The following is the tutorial link to MoveIt2: [link to MovIt2 tutorial, part of documentation](https://moveit.picknik.ai/main/doc/tutorials/getting_started/getting_started.html?utm_source=chatgpt.com)

Be sure to master ros2 colcon with `rclpy` and `rclcpp` then use them!!!

### core packages used among all nodes

Package                  | Purpose
------------------------ | ---------------------------
`moveit_core`            | planning core
`move_group`             | main planning node
`moveit_msgs`            | ROS interfaces
`moveit_servo`           | realtime Cartesian servoing
`moveit_visual_tools`    | RViz interaction
`moveit_ros_planning`    | ROS integration
`moveit_configs_utils`   | robot setup
`moveit_setup_assistant` | generate configs

### KEY ROS topics used

Topic                                           | Meaning
----------------------------------------------- | ------------------
`/joint_states`                                 | actual robot state
`/tf`                                           | transforms
`/robot_description`                            | URDF model
`/display_planned_path`                         | RViz trajectory
`/joint_trajectory_controller/joint_trajectory` | motion commands
`/planning_scene`                               | world model

### possible example

`MoveIt + Panda robot + RViz`

## Navigation 2 (NAV2)

The following is the github link to Nav2: [link to NAV2 github page](https://github.com/ros-navigation/navigation2?utm_source=chatgpt.com)

The following is the documentation link to Nav2: [link to NAV2 documentation webpage](https://docs.nav2.org/?utm_source=chatgpt.com)

### SLAM idea by

Function           | Meaning
------------------ | ----------------------------
Localization       | “Where am I?”
Path Planning      | “How do I get there?”
Obstacle Avoidance | “Don’t hit things.”
Recovery Behaviors | “What if I’m stuck?”
Costmaps           | environmental representation
Behavior Trees     | task sequencing
Velocity Commands  | motion execution

### Topics in Nav2

Topic        | Meaning
------------ | ---------------------
`/cmd_vel`   | velocity command
`/odom`      | odometry
`/scan`      | LiDAR scan
`/imu`       | inertial measurement
`/tf`        | transforms
`/map`       | environment map
`/amcl_pose` | localization estimate

## URDF comes in first

```text
DH/robotics theory
        ↓
URDF robot model
        ↓
MATLAB Robotics Toolbox
        ↓
ROS2 / MoveIt2 ecosystem
```

### United Robot Definition File (URDF)

They are now all used across

- MATLAB (Robotics toolbox for both MATLAB/Simulink)
- RViz (ROS Visualization)
- MoveIt2
- Gazebo
- ros2_control
- robot drivers

### DH table to URDF

Classical Robotics | ROS/URDF World
------------------ | --------------------
DH Table           | URDF joint/link tree
Frames             | TF tree
Transform matrices | tf2 transforms
Kinematic chain    | robot_description
Dynamics           | inertial tags
Joint variables    | `/joint_states`

## scope

Classical Layer  | Modern Layer
---------------- | ------------
DH tables        | URDF
SE(3) transforms | TF2
Kinematics       | MoveIt
Dynamics         | ros2_control
Simulation       | Gazebo/RViz
Controllers      | ROS2 nodes

URDF tutorial for ROS [link to URDF use from ROS](https://docs.ros.org/en/rolling/Tutorials/Intermediate/URDF/URDF-Main.html?utm_source=chatgpt.com)

website reference [link to Peter Cooke's web lecture on modern robotics at NWU](https://modernrobotics.northwestern.edu/nu-gm-book-resource/foundations-of-robot-motion/)

matlab import robot [link to MATLAB import robot function call documentation](https://www.mathworks.com/help/robotics/ref/importrobot.html?utm_source=chatgpt.com)