# MATLAB robotics learning note

Written by **Peter Chang** to compliment on "learning/robotics/" repo's `learning_20250127_prepare.mlx` and `learning_20251127_jacobian.mlx` files

## Concept and target

Since the fundamental ROS and MATLAB ecosystem is all based on Forward Kinematics/Inverse Kinematics, Forward Dynamics/Inverse Dynamics. By utilizing Jacobian (notice linear velocity/angular velocity and torque/force Jacobian).

Which is through standard Frame tranformation (tf2 in ROS), from the *homogenerous transform* $^0_1 H$. It is essential to start from **Standard D-H Table** to learn all the Jacobian kinematics/dynamics.

The fundamental learnings are done in the `learning/robotics/` repo.

## From kinematics to dynamics

The goal is to make sure one knows the MATLAB dynamics. command.

This is the link to the dynamcis page: [link to robot dynamcis of matlab documentation](https://www.mathworks.com/help/robotics/manipulator-modeling.html)

[true dynamics link to function calls](https://www.mathworks.com/help/robotics/ug/robot-dynamics.html)

### dynamic equation in MATLAB is written as

$$
\frac{d}{dt}

\begin{bmatrix}
q \\
\dot{q}
\end{bmatrix} =
\begin{bmatrix}
\dot{q} \\
M(q)^{-1}\left( -C(q,\dot{q})\dot{q}-G(q)-J(q)^Tf_{ext}+\tau\right)
\end{bmatrix}
$$

i.e. this is $M(q)\ddot{q}+C(q,\dot{q})\dot{q}+G(q)+J(q)^Tf_{ext} = \tau$ in state-space form.

Notice all the moment of inertia is calculated in MATLAB with 
$$
\mathbb{I} =
\begin{bmatrix}
I_{xx} & I_{xy} & I_{xz} \\
I_{yx} & I_{yy} & I_{yz} \\
I_{zx} & I_{zy} & I_{zz}
\end{bmatrix}
$$
with standard definition.

### make sure to know derivation from review paper

[link to local pdf file in repo](./1986_Adaptive_control_of_mechanical_manipulators.pdf)

## Adaptive control withoug Jacobian transform paper

more to come.