# Common Robotics Topic Conventions

Although ROS 2 allows users to define any topic name, many robotics systems gradually evolved common topic conventions.

from abstract message/interface definitions to real robotics ecosystem conventions.

Learning these topic names is important because tools such as:

- RViz
- Gazebo
- Nav2
- MoveIt
- robot_localization
- MATLAB Robotics Toolbox

often expect or assume these topic structures already exist.

---

# 1. Robot Arm Common Topics

## Joint state feedback

```text
/joint_states
```

Usually publishes:

```text
sensor_msgs/msg/JointState
```

Contains:
- joint angle
- joint velocity
- joint torque/effort

This is one of the MOST important robot arm topics.

---

## Joint trajectory command

```text
/joint_trajectory
```

or

```text
/joint_trajectory_controller/joint_trajectory
```

Usually uses:

```text
trajectory_msgs/msg/JointTrajectory
```

Used for:
- trajectory planning
- motion execution
- MoveIt integration
- robot arm control

---

## End-effector transform

```text
/tf
```

and

```text
/tf_static
```

Usually publishes:

```text
tf2_msgs/msg/TFMessage
```

Used for:
- coordinate transforms
- robot kinematics
- frame tree updates

Examples:

```text
base_link → shoulder_link → elbow_link → tool0
```

---

## Robot description

```text
/robot_description
```

Usually stores:
- URDF
- robot geometry
- kinematic tree
- inertia properties

Commonly used by:
- RViz
- Gazebo
- MoveIt
- MATLAB rigidBodyTree import

---

# 2. Mobile Robot Common Topics

## Velocity command

```text
/cmd_vel
```

Usually publishes:

```text
geometry_msgs/msg/Twist
```

Contains:
- linear velocity
- angular velocity

Very common for:
- TurtleBot
- differential drive robots
- AGV/AMR systems

---

## Odometry

```text
/odom
```

Usually publishes:

```text
nav_msgs/msg/Odometry
```

Contains:
- robot position
- velocity
- orientation estimate

Often generated from:
- wheel encoders
- IMU
- sensor fusion

---

## Laser scanner

```text
/scan
```

Usually publishes:

```text
sensor_msgs/msg/LaserScan
```

Used for:
- obstacle detection
- SLAM
- navigation
- localization

Very common in:

- LiDAR systems

---

## IMU sensor

```text
/imu
```

Usually publishes:

```text
sensor_msgs/msg/Imu
```

Contains:
- acceleration
- angular velocity
- orientation

---

## Map topic

```text
/map
```

Usually publishes:

```text
nav_msgs/msg/OccupancyGrid
```

Used in:
- SLAM
- path planning
- navigation stack

---

## Path planning result

```text
/plan
```

or

```text
/global_plan
/local_plan
```

Usually publishes:

```text
nav_msgs/msg/Path
```

Contains:
- planned trajectory/path points

---

# Important Concept

ROS 2 itself does NOT force these topic names.

However, over many years, the robotics community gradually formed these conventions.

Therefore, learning ROS 2 is not only learning syntax.

It is also learning the shared "robotics communication language" used across:

- RViz
- Gazebo
- Nav2
- MoveIt
- MATLAB Robotics Toolbox
- real robots
- industrial robotic systems