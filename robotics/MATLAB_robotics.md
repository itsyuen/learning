# Robtics theroy and simulation towards ROS2 control

Written on 20260512 by **Peter Chang**

## objective

Theory is written inside `Jacobian.mlx`, mostly derivation with few exercise.

Real examples with actual robot URDF/SDH exercises starting on `Dynamics.mlx`. As this will use all the robotics toolbox to find the transform between all frames.

## Simulink practice

Targeted next step. For full controller demonstration, and try perhaps codge-gen.

## Codegen for ROS2

Try c++ or python code gen. First Talk to ROS2, as a node, this is practiced in `\learning\ros_codegen` directory.... not full robotics yet as I need to learn `MoveIt2` and `Nav2` packages.

## Robotics System Toolbox

### Rigid Body (TREE)

This is the basis of all robot parts. `tform` is to extract homogenous transformation.

1. `robot = rigidBodyTree;` Robot name/handle `robot`
2. `base = robot.Base;` handel for **world-base**  
3. `f0 = se3;` Wold frame. `eye(4)`
4. `plate_base = rigidBody("plate_base");`
5. `plate_jnt = rigidBodyJoint("plate_jnt",plate_base,'revolute');`
6. In future when **child joint relative to parent's joint**, use `tt = se3(trvec([x y z]))` or `tt = trvec2tform([x y z])`, don't forget to rotate to **DH** convention.
7. `setFixTransform(plate_jnt,tt);` it's (joint_object,tform) with mostly modifided D-H settings. For multiple assignements with $(\alpha, a, d, \theta)$ as the link itself, remember the link/joint frame is the same.
8. `body.*` inspects the needed:

    - `body.Name` (`showdetails(robot)`)
    - `body.Parent` (`showdetails(robot)`)
    - `body.Children` (`showdetails(robot)`)
    - `body.Joint` (`showdetails(robot)`)
    - `body.Mass`
    - `body.CenterOfMass`
    - `body.Inertia`
    - `body.Collisions`
    - `body.Visuals`

9. `joint.*` inspects the needed:
    
    - `joint.Name`
    - `joint.Type`
    - `joint.HomePosition` (let this be *parking* position)
    - `joint.JointAxis` (most important)
    - `joint.PositionLimits` (important for *free movement*)
    - `joint.JointToParentTransform` (moves the current body away from *parent* joint frame)
    - `joint.ChildToJointTransform` (only with **SDH** parameterization)

10. `config = homeConfiguration(robot);` This creates the forward kinematics joint space configureation.

    - `config(1).JointPosition = pi/2;` moves the 1st joint
    - `config(2).JointPosition = pi/3;` moves the 2nd joint
    - `show(robot,config)` can show how this moves the robot.

11. `tt = getTransform(robot, config, sourceframe, targetframe);` target to source relative transform (tform, se3)

This concludes current status.

```text
showdetails(robot)

body = robot.Bodies{idx};
body.Name
body.Parent
body.Joint

joint = body.Joint;
joint.Name
joint.Type
joint.JointAxis
joint.JointToParentTransform
joint.ChildToJointTransform
```

And yes: `body_handle / joint_handle` are just `MATLAB` variable handles for easier inspection/editing. They are not the same thing as the internal .Name stored inside the tree.
