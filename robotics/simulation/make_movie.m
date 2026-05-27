%% this program uses the simulation output
% the object of ToWorkspace for show(robot) drawnow

if ~isempty(out.q_log)
    disp("q_log has data")
end


% squeeze the output

ts = out.q_log;

% 1:3   → q
% 4:6   → qd
% 7:9   → qdd

q_log = squeeze(ts.Data);

t = ts.Time;

size(q_log)
size(t)

q = q_log(1:3,:);   % full timeline data at 100 Hz
qd = q_log(4:6,:);
qdd = q_log(7:9,:);

% make move from data
videoFile = "robot_test_motion.mp4";
v = VideoWriter(videoFile,"MPEG-4");
v.FrameRate = 30;
open(v);

fig = figure(1);
clf
ax = axes(fig);

for k = 1:length(t)

    qk = q(:,k);

    % config(1).JointPosition = qk(1);
    % config(2).JointPosition = qk(2);
    % config(3).JointPosition = qk(3);

    show(robot,qk, ...
        "Parent",ax, ...
        "PreservePlot",false);

    drawnow

    frame = getframe(fig);
    writeVideo(v,frame);

end

close(v);

disp("Movie saved: " + videoFile)