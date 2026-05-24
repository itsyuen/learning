# Robotics simulation with simulink time line control

**Peter Chang** trying on making a robot with .m file as a rigid body tree, and call inside simulink to run the 10 second of performance with monitoring and actuator simulation around the system.

## Simulator

1. `robot_20260522_simulation.slx` is the main simulink runtime model
2. `robot.m` will be the `robot = rigidBodyTree;` if that is not in violation with name convention.
3. `body1 = rigidBody('rotating_plate');` will be incoporated inside the `robot.m` file along with `joint1 = rigidBodyJoint('rotating_joint','revolute');` and `setFixedTransform(joint1, tform);` all done for multiple boies untill `addBody(robot, child_body, parent_body)`.

## R-R-R manipulator

This robot will have a rotating base, then two arms, with a gripper at the end of "upper arm".

- `body1` is "rotating plate", use `collisionCylinder`, $r = 0.2, h = 0.1$
- `body2` is "lower arm", use `collisionBox` $w = 0.05, h = 0.05, l = 0.2$
- `body3` is "upper arm", use `collisionBox` $w = 0.05, h = 0.05, l = 0.2$
- `body4` is "gripper", use `collisionSphere` $r = 0.05$

## Trajectory generation

Pre-calculation fully developed, so that one can use the `clock` inside the simulink? Natural to design part table

|time|value1|value2|FK|
|---|---|---|---|
|$t_o$|$q(t_o)$|$\dot{q}(t_0)$|EOF's $[x\;y\;z]_{t_0}$|
|$t_1$|$q(t_1)$|$\dot{q}(t_1)$|EOF's $[x\;y\;z]_{t_1}$|
|$t_2$|$q(t_2)$|$\dot{q}(t_2)$|EOF's $[x\;y\;z]_{t_2}$|

- use quadradic functions to make smooth trajectory
- use simulink block or other `spline` for internal *interpolation*
- for **Foward Kinematics** this is trivial and essential
- for **Inverse Kinematics** this is non-trivial

### define home position

### Dynamics comes into play at another lower level

## Full dynamic controller FEEDBACK at higher level command at LOW level

This idea comes as the $\tau_m = k_t \cdot i(t)$, therefore it is essential to *provide* command at not only the voltage command $V(t) \sim [\theta_1\;\;\theta_2\;\;...]$ at each joint velocity, but also monitor for each joint its consuming current $I(t) \sim [\ddot{\theta_1}\;\;\ddot{\theta_2}\;\;...]$

### Calculation of standard torque comand needed to compansate gravity and load through standard procedure first

### final design of adaptive jacobian-free sudden shift of COM and $J$ later

## Procedures

1. run `make_robot.m` to acquire:
    - robot
    - body1 to body4
    - joint1 to joint4
    - config = homeConfiguration (to later use to control forward kinematics)

2. run `make_trajectory.m` to acquire:

    - way points for all joints: `way_pt` in worksapce
    - time points for said waypoints `time_pt` in workspace
    - also check all the free-joint axis that is correctly added to each joint

3. run `robot_dimulation.slx` to use simulink block

    - use `ToWorkSpace` block to provide `out.q_log`
    - notice this is an "output object" that is /topic /message like in ros2

4. run `make_movie.m` to unpack the `out.q_log`

    - use `squeeze` command to make sure q_log is 3 by 51 (due to way point assignent)
    - use `time steps` to get the frames of video to plot each `config(1)`, `config(2)` and `config(3)` since only three free joints are avaiable
