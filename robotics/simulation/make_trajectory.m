%% Basic forward kinematic joint space trajectory file

showdetails(robot)  % double check before trajectory calculation

% check the three moving frame and get it's local transform

config = homeConfiguration(robot);

for i = 1:robot.NumBodies

    body_t = robot.Bodies{i};

    if i == 1
        parent_name = robot.BaseName;
    else
        parent_name = robot.Bodies{i-1}.Name;
    end

    tt = getTransform(robot,config,body_t.Name,parent_name);

    fprintf("%s relative to %s:\n", body_t.Name, parent_name)
    disp(rad2deg(tform2eul(tt)))

end

% check the rotating axis

for i = 1:robot.NumBodies

    body = robot.Bodies{i};
    joint = body.Joint;

    fprintf("\nBody: %s\n", body.Name)
    fprintf("Joint: %s\n", joint.Name)
    fprintf("Type: %s\n", joint.Type)

    if joint.Type == "revolute" || joint.Type == "prismatic"
        disp("Joint axis:")
        disp(joint.JointAxis)
    end

end

% way_pt size = number_of_joints × number_of_waypoints
% time_pt size = 1 × number_of_waypoints

time_pt = [0 2 4 6 8 10];

way_pt = [
    0    pi/6   pi/4    0    -pi/6   0;     % plate_joint
    0    pi/8   pi/6   pi/4   pi/8   0;     % larm_jt
    0   -pi/8  -pi/4  -pi/6    0     0      % uarm_jt
    ];

%% save waypoint for 10 sec, at 3 by n matrix
save("my_rrr_waypoint.mat",'way_pt','time_pt');
