# Learning Python

Small, executable `.py` learning snippets.

## Objectives

1. Learn Python syntax through practical examples.
2. Use Markdown (`.md`) to clearly explain each directory, so the content can later evolve into teaching modules.
3. Connect Python to ROS 2 workflows, especially future `colcon` / CMake interconnection.

## From Learning to Teaching

- Extend snippets with explanatory inline Markdown notes.
- Target cross-platform development (Windows / Ubuntu / WSL).
- Use Python for ROS 2 nodes, messages, topics, publish/subscribe, and system orchestration.
- Keep compatibility with future C++ optimization and deployment upgrades.
- Build foundations useful for robotics, automation, and embedded integration.

## Directory Structure

```text
python/
├── basics/
├── oop/
├── ros/
│   ├── ros_nodes.html
│   ├── ros_nodes.md
│   └── ros_nodes.txt
└── README.md
```


---
# Python for ROS2 Engineers
## 3-Week Practical Curriculum
### NTUST / SSCL Direction

---

# Philosophy

This course is NOT designed to:
- master all Python syntax
- become a software engineer
- memorize libraries

Instead, this course teaches Python as:
- a robotics glue language
- a ROS2 orchestration tool
- a bridge between MATLAB, Linux, ROS2, and embedded systems

Core idea:

```text
MATLAB thinking
    ↓
Python orchestration
    ↓
ROS2 distributed systems
    ↓
Embedded control