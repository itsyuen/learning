%% this program uses the simulation output
% the object of ToWorkspace for show(robot) drawnow

if ~isempty(out.q_log)
    disp("q_log has data")
end

% squeeze the output

ts = out.q_log;

q_log = squeeze(ts.Data);

t = ts.Time;

size(q_log)
size(t)

% make move from data
videoFile = "robot_frame_motion.mp4";
v = VideoWriter(videoFile,"MPEG-4");
v.FrameRate = 30;
open(v);

fig = figure(1);
clf
ax = axes(fig);

for k = 1:length(t)

    q = q_log(:,k);

    config(1).JointPosition = q(1);
    config(2).JointPosition = q(2);
    config(3).JointPosition = q(3);

    show(robot,config, ...
        "Parent",ax, ...
        "PreservePlot",false);

    drawnow

    frame = getframe(fig);
    writeVideo(v,frame);

end

close(v);

disp("Movie saved: " + videoFile)