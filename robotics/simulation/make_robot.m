%% This is the robot rigid body tree modeling script
% to be run before the simulink is ready to simulate with timed clock

clc;

robot = rigidBodyTree;
base = robot.Base;

base_frame = se3;   % f0 = world frame

% Body 1: rotating base-plate

body1 = rigidBody('rotating_plate');
joint1 = rigidBodyJoint('plate_joint','revolute');

setFixedTransform(joint1,base_frame);   % f1 = eye(4), metal note same as world note
body1.Joint = joint1;

coll1 = collisionCylinder(0.2,0.1);
pose = trvec2tform([0 0 0.1/2]);
addCollision(body1,coll1,pose);

addBody(robot,body1,base.Name)

% Body 2: lower arm

body2 = rigidBody('lower-arm');
joint2 = rigidBodyJoint('larm_jt','revolute');

setFixedTransform(joint2,se3(roty(-90),[0 0 0.1]))
body2.Joint = joint2;

coll2 = collisionBox(0.3, 0.05, 0.05);
pose = trvec2tform([0.3/2 0 0]);
addCollision(body2,coll2,pose);

addBody(robot,body2,"rotating_plate")

% Body 3: upper arm

body3 = rigidBody('upper-arm');
joint3 = rigidBodyJoint('uarm_jt','revolute');

setFixedTransform(joint3,trvec2tform([0.3 0 0]))
body3.Joint = joint3;

coll3 = collisionBox(0.3, 0.05, 0.05);
pose = trvec2tform([0.3/2 0 0]);
addCollision(body3,coll3,pose);

addBody(robot,body3,"lower-arm")

% Body 4: gripper

body4 = rigidBody('gripper');
joint4 = rigidBodyJoint('grip_jnt','fixed');

setFixedTransform(joint4,trvec2tform([0.3 0 0]))
body4.Joint = joint4;

coll4 = collisionSphere(0.02);
pose = trvec2tform([0.02/2 0 0]);
addCollision(body4,coll4,pose);

addBody(robot,body4,"upper-arm")

%% configure forward kinematics
% tracing f1 = frame{1} = f0 = frame{0}/world.
f1 = base_frame;
f1a = f1*se3(rotz(45)); % rotated frame {1} 

%% home position (parking) configuration
config = homeConfiguration(robot);

%% check geometry
showdetails(robot);

fig1 = figure(1);
show(robot,"Collisions","on")

view(135,25)
rotate3d on