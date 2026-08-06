# Matlab coder using Python 3.13

## Objective

Build a gentle bridge from MATLAB to scientific Python for mechanical engineering, control, and robotics students.

Instead of asking students to abandon MATLAB immediately, use MATLAB as the familiar environment while gradually introducing Python, NumPy, and eventually ROS 2.

## Teaching Philosophy

- Start with engineering concepts students already understand.
- Compare MATLAB syntax directly with Python syntax.
- Verify that both produce the same numerical results.
- Introduce the Python ecosystem one layer at a time.
- Transition naturally from MATLAB scripts to Jupyter notebooks and ROS 2 nodes.

## Roadmap

### 1. MATLAB → NumPy

Using natural MATLAB matrix operations to introduce NumPy arrays.

Topics:

- MATLAB matrix ↔ NumPy ndarray
- Matrix multiplication
- Element-wise operations
- Indexing and slicing
- Reshape and concatenation
- Linear algebra
- Plotting comparison

### 2. MATLAB Data Structures → Python Data Structures

Introduce the Python containers by analogy.

- MATLAB cell array → Python list
- MATLAB struct → Python dictionary
- String arrays
- Tuples (brief introduction)

### 3. Programming Language Translation

Translate familiar MATLAB programming into Python.

- for loop
- if / elseif / else
- functions
- scripts vs modules
- packages and imports

### 4. MATLAB Calling Python

Use the same Python environment from inside MATLAB.

- Configure `pyenv`
- Virtual environments (`.venv`)
- `pyrun`
- `pyrunfile`
- Calling NumPy from MATLAB
- Returning results back into MATLAB

### 5. MATLAB → Jupyter Notebook

After students become comfortable:

- Run the same examples in Jupyter.
- Compare MATLAB Live Scripts with Jupyter notebooks.
- Explain why scientific Python development often uses notebooks.

### 6. Towards ROS 2

Show how the same Python language now appears inside ROS 2.

Progression:

MATLAB → Python → NumPy → Jupyter → ROS 2 (`rclpy`)

Students realize they are learning one programming language that is reused throughout the robotics software stack.

## Long-Term Goal

This notebook serves as the bridge between traditional MATLAB education and modern robotics software development.

Rather than replacing MATLAB, it demonstrates how MATLAB and Python complement each other throughout research, teaching, and industrial robotics.
