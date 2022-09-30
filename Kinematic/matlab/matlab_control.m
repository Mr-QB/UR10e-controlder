TIME_STEP = 64;
% get and enable devices, e.g.:
%  camera = wb_robot_get_device('camera');
%  wb_camera_enable(camera, TIME_STEP);
motor_1 = wb_robot_get_device('shoulder_pan_joint');
motor_2 = wb_robot_get_device('shoulder_lift_joint');
motor_3 = wb_robot_get_device('elbow_joint');
motor_4 = wb_robot_get_device('wrist_1_joint');
motor_5 = wb_robot_get_device('wrist_2_joint');
motor_6 = wb_robot_get_device('wrist_3_joint');


% main loop:
% perform simulation steps of TIME_STEP milliseconds
% and leave the loop when Webots signals the termination
%
while wb_robot_step(TIME_STEP) ~= -1

  % read the sensors, e.g.:
  %  rgb = wb_camera_get_image(camera);

  % Process here sensor data, images, etc.

  % send actuator commands, e.g.:
  wb_motor_set_postion(motor_1, 0);
  wb_motor_set_postion(motor_2, 1.0);
  wb_motor_set_postion(motor_3, 0);
  wb_motor_set_postion(motor_4, 0);
  wb_motor_set_postion(motor_5, 0);
  wb_motor_set_postion(motor_6, 0);
  

  % if your code plots some graphics, it needs to flushed like this:
  drawnow;

end

% cleanup code goes here: write data to files, etc.
