# Pre-Module Learning Guide

*ROS 2 Foundations for Mechanical Engineering Students*
Later to be moved to `/teaching/modules/` directory.

## Objective

Before learning ROS 2 programming, students must first understand:

- why ROS 2 exists
- why robotics systems are distributed
- how nodes communicate
- how Linux and networking relate to robotics
- how MATLAB, Python, and C++ connect together

This module prepares students for:

- ROS 2 commands and it's `function` calls
- MATLAB ROS Toolbox
- Turtlesim
- STM32 integration
- Mobile robotics
- Future AMR systems

## 1. What is ROS 2?

ROS 2 is NOT:

- a robot
- an operating system
- a simulator

ROS 2 is a robotics communication framework.

It allows:

- sensors
- controllers
- planners
- actuators
- visualization tools

to communicate using standardized messages.

## 2. Why Modern Robots Need ROS 2

Modern robots are distributed systems.

Example:

- LiDAR node
- Camera node
- Navigation node
- Motor controller node
- Battery monitor node
- GUI node

All run independently.

ROS 2 connects them together.

## 3. Core ROS 2 Concepts

### Node

A node is a running program.

Examples:

- turtlesim
- teleop keyboard
- MATLAB node
- LiDAR driver

### Topic

A topic is a communication channel.

Example:

- /cmd_vel
- /scan
- /odom

Topics carry messages.

### Message

Messages are structured data.

Examples:

- velocity
- position
- laser scan
- images

### Publisher

A publisher sends data to a topic.

Example:

- keyboard publishes velocity commands

### Subscriber

A subscriber receives data from a topic.

Example:

- turtle subscribes to velocity commands

### Service

A service is request/response communication.

Example:

- spawn a turtle
- reset simulator

## 4. ROS 2 Computation Graph

ROS 2 systems form a computation graph.

The graph contains:

- nodes
- topics
- services
- actions

The graph changes dynamically during execution.

## 5. Why Turtlesim is Important

Turtlesim is NOT just a toy.

It demonstrates:

- topics
- services
- namespaces
- publishers/subscribers
- distributed execution

using visible motion.

## 6. Why MATLAB is Important

MATLAB allows us to:

- inspect ROS topics
- publish/subcribe visually
- connect control theory with robotics
- prototype algorithms quickly

MATLAB helps bridge:

- control engineering
- robotics middleware
- embedded deployment

## 7. Role of Python and C++

### Python

Used for:

- rapid development
- glue logic
- orchestration
- launch systems

### C++

Used for:

- performance
- embedded systems
- real-time applications
- industrial robotics

## 8. Long-Term Robotics Architecture

Future course direction:

```text
STM32
↓
micro-ROS / serial / CAN
↓
Raspberry Pi
↓
ROS 2 nodes
↓
Navigation / perception
↓
Autonomous mobile robots
```

## 9. Student Mindset

Do NOT memorize commands only.

Focus on:

- communication flow
- system architecture
- message movement
- node relationships

ROS 2 is fundamentally a distributed engineering system.

## 10. Recommended First Commands

```bash
ros2 node list
ros2 topic list
ros2 topic echo /turtle1/pose
ros2 service list
```

## 11. Key Learning Goal

The goal is NOT:

> running ROS commands

The goal is:

> understanding how robotics software systems communicate.

### Vision

This teaching flow aligns to studendts learning:

- ME background for Electrical Motor Control, Mechatronics system control, mobile platform control, robot arm control, humanoid/android control and ev
- simulink/control simulation and algorithmic controller design
- ROS2 architecture/3 three level controller (driver with FB, mid-level kinematic/dynamic monitoring, high level state-machine)
- STM32 mid/low level independent RTOS real-time/run-time automatic control and communication
- AutoStar/RTOS redundency and channel communication safety
- ultra-high level distributed system with limited communication/information control for swam/multiplle robots

And most importantly:

> students are not just learning, professors are not just teaching `ROS`

It is learning/teaching:

> modern robtoics system engineering

## References

[Joseph and Cacace Book, `Mastering ROS 2 for Robotics Programming, 4th Ed.`](https://www.packtpub.com)

[Open Robotics Turtlesim Tutorial, `S. Macenski, T. Foote, B. Gerkey, C. Lalancette, W. Woodall, “Robot Operating System 2: Design, architecture, and uses in the wild,” Science Robotics vol. 7, May 2022`](https://docs.ros.org/en/jazzy/Tutorials/Beginner-CLI-Tools/Introducing-Turtlesim/Introducing-Turtlesim.html#use-rqt)

[Mathworks website reference, `Get Started with ROS Toolbox`](https://www.mathworks.com/help/ros/getting-started-with-ros-toolbox.html?s_tid=CRUX_lftnav)