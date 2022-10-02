clc, clear, close all
syms theta_1 theta_2 theta_3 theta_4 theta_5 theta_6 
a_1 = 0;                    alpha_1 = sym(pi/2);        d_1 = 0.181;              theta_1 = -1.3;  %Joint_1:
a_2 = -0.613;               alpha_2 = 0;                d_2 = 0.176-0.137;        theta_2 = 0;  %Joint_2:
a_3 = -0.571;               alpha_3 = 0;                d_3 = 0;                  theta_3 = 0;  %Joint_3:
a_4 = 0;                    alpha_4 = sym(pi/2);        d_4 = 0.135;              theta_4 = 0;  %Joint_4:
a_5 = 0;                    alpha_5 = sym(-pi/2);       d_5 = 0.12;               theta_5 = -1.9; %Joint_5;
a_6 = 0;                    alpha_6 = 0;                d_6 = 0.16;               theta_6 = 1.30;  %Joint_6:
%% calc Transform matrix
T_1 = transform_T(a_1,alpha_1,d_1,theta_1);
T_2 = transform_T(a_2,alpha_2,d_2,theta_2);
T_3 = transform_T(a_3,alpha_3,d_3,theta_3);
T_4 = transform_T(a_4,alpha_4,d_4,theta_4);
T_5 = transform_T(a_5,alpha_5,d_5,theta_5);
T_6 = transform_T(a_6,alpha_6,d_6,theta_6);
T_06 =  T_1 * T_2 * T_3 * T_4 * T_5 * T_6;
%% calc Pose
Pose_6 = Find_Pose(T_06);               Pose_6 = double(Pose_6)                   %Pose joint 6 of robot.
%% find Thetas of robot
theta1 = Find_theta1(T_06);                     theta1 = double(theta1)                    %Finding theta_1 
theta5 = Find_theta5(Pose_6,theta1);            theta5 = double(theta5)                    %Finding theta_5
theta6 = Find_theta6(T_06,theta1,theta5);       theta6 = double(theta6)


%% Function
function T = transform_T(a,alpha,d,theta)   %Function calc Transform matrix
    T = [cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta); sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta); 0 sin(alpha) cos(alpha) d; 0 0 0 1];
end
function Pose = Find_Pose(T)                %Function find pose of robot frame.
Px = (T(1,4));
Py = (T(2,4));
Pz = (T(3,4));
Rx = (atan2(T(3,2),T(3,3)));
Ry = (atan2(-T(3,1),(T(3,2)^2 + T(3,3)^2)^0.5));
Rz = (atan2(T(2,1),T(1,1)));
Pose = [Px,Py,Pz,Rx,Ry,Rz];
end
function theta1 = Find_theta1(T_06)
   Tranform_matrix = [0,0,-0.16,1];          %Transform matrix of P_6 to P_5
   Tranform_matrix = Tranform_matrix(:);
   T_05  = T_06*Tranform_matrix;
   P_5x  = double(T_05(1,1));                %Px of P5
   P_5y  = double(T_05(2,1));                %Py of P5
   P_5xy = (P_5x^2 + P_5y^2)^0.5;            %|Pxy| of P5
   alpha1 = atan2(P_5y,P_5x);            
   alpha2 = acos(0.174/P_5xy);
   theta1 = alpha1 + alpha2 + sym(pi/2);     %Finding theta 1.
   if theta1 > sym(pi)
       theta1 = theta1 - 2*sym(pi);
   end
end
function theta5 = Find_theta5(Pose_6,theta1)
    P_6x   = Pose_6(1,1);
    P_6y   = Pose_6(1,2);
    theta5 = acos( (P_6x*sin(theta1) - P_6y*cos(theta1) -0.174) / 0.16);
    if Pose_6(1,6) < 0
        theta5 = -acos( (P_6x*sin(theta1) - P_6y*cos(theta1) -0.174) / 0.16);
    end
end
function theta6 = Find_theta6(T_06,theta1,theta5)
    X_06x = T_06(1,1);
    X_06y = T_06(2,1);
    Y_06x = T_06(1,2);
    Y_06y = T_06(2,2);
    %sin_theta6 = (-X_06y*sin(theta1) + Y_06y*cos(theta1))/sin(theta5);
    %cos_theta6 = (X_06x*sin(theta1) - Y_06x*cos(theta1))/sin(theta5);
    sin_theta6 = (-Y_06x*sin(theta1)+Y_06y*cos(theta1))/sin(theta5);
    cos_theta6 = -(-X_06x*sin(theta1) + X_06y*cos(theta1))/sin(theta5);
    theta6 = atan2(sin_theta6,cos_theta6);
end


