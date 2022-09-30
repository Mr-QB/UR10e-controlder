clc, clear, close all
%% Calc waypoint
a = -0.5; b = 0.7;R = 0.18;                                         %Circle center coordinates: C(a,b);Radius: R
x = [a-(R):0.003:a+(R)];                                            %Calc waypoint
y = (R^2 - (x - a).^2).^0.5;
x = [x flip(x)];
y = [y+b (flip(y).*-1)+b];
x = double(x);y = double(y);
for n = 1:length(x)
    Pose(n,1) = 0;
    Pose(n,2) = 0;
    Pose(n,3) = 0;
    Pose(n,4) = x(n);
    Pose(n,5) = y(n);
    Pose(n,6) = 0.5;
end
T = table(Pose);
writetable(T,'waypoint.txt');
fid = fopen('waypoint.txt');
Pose = readmatrix('waypoint.txt');

%% Calc IK 
Trajectory = zeros(length(Pose),6);
for n = 1:length(Pose)
    Rx = Pose(n,1); Ry = Pose(n,2); Rz = Pose(n,3); Px = Pose(n,4); Py = Pose(n,5); Pz = Pose(n,6);
    Pose_ = [Rx,Ry,Rz,Px,Py,Pz];
    thetas = Find_thetas(Pose_);
    Trajectory(n,1) = double(thetas(1,1));Trajectory(n,3) = double(thetas(1,3));Trajectory(n,5) = double(thetas(1,5));
    Trajectory(n,2) = double(thetas(1,2));Trajectory(n,4) = double(thetas(1,4));Trajectory(n,6) = double(thetas(1,6));
end
T = table(Trajectory)
writetable(T,'Trajectory.txt');

%% Function
function T = transform_T(a,alpha,d,theta)                           %Function calc Transform matrix
    T = [cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta); sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta); 0 sin(alpha) cos(alpha) d; 0 0 0 1];
end
function Pose = Find_Pose(T)                                        %Function find pose of robot frame.
Px = (T(1,4));
Py = (T(2,4));
Pz = (T(3,4));
Rx = (atan2(T(3,2),T(3,3)));
Ry = (atan2(T(3,1),(T(3,2)^2 + T(3,3)^2)^0.5));
Rz = (atan2(T(2,1),T(1,1)));
T_ =  Find_T06(Rx,Ry,Rz,Px,Py,Pz);
if isequal(T_,T) == 0
    Rx = (atan2(-T(3,2),-T(3,3)));
    Ry = (atan2(-T(3,1),-(T(3,2)^2 + T(3,3)^2)^0.5));
    Rz = (atan2(-T(2,1),-T(1,1)));
end
Pose = [Rx,Ry,Rz,Px,Py,Pz];
end
function thetas = Find_thetas(Pose_06)                              %Function find thetas with Pose P06
    %%% D-H Table               
    a_1 = 0;                    alpha_1 = sym(pi/2);        d_1 = 0.181;              
    a_2 = -0.613;               alpha_2 = 0;                d_2 = (0.176-0.137);      
    a_3 = -0.571;               alpha_3 = 0;                d_3 = 0;                  
    a_4 = 0;                    alpha_4 = sym(pi/2);        d_4 = 0.135;              
    a_5 = 0;                    alpha_5 = sym(-pi/2);       d_5 = 0.12;               
    a_6 = 0;                    alpha_6 = 0;                d_6 = 0.16;               
    %%% Pose 06 %%%
    psi = Pose_06(1,1);
    vartheta = Pose_06(1,2);
    varphi = Pose_06(1,3);
    P6x = Pose_06(1,4);
    P6y = Pose_06(1,5);
    P6z = Pose_06(1,6);
    %%% Transfrom matrix T06 %%%
    T_06 = Find_T06(psi,vartheta,varphi,P6x,P6y,P6z);
    
    theta1 = Find_theta1(T_06);theta1 = double(theta1);                    %Finding theta_1
    theta5 = Find_theta5(Pose_06,theta1,1);theta5 = double(theta5);        %Finding theta_5
    theta6 = Find_theta6(T_06,theta1,theta5);                              %Finding theta_6

    T_01 = transform_T(a_1,alpha_1,d_1,theta1);
    T_45 = transform_T(a_5,alpha_5,d_5,theta5);
    T_56 = transform_T(a_6,alpha_6,d_6,theta6);
    T_16 = inv(T_01)*T_06;T_15 = T_16*inv(T_56);T_14 = T_15 * inv(T_45);

    theta3 = Find_theta3(T_14,a_2,a_3);                                    %Finding theta_3
    theta2 = Find_theta2(T_14,theta3,a_3);                                 %Finding theta_2

    T_12 = transform_T(a_2,alpha_2,d_2,theta2);T_12 = double(T_12);
    T_23 = transform_T(a_3,alpha_3,d_3,theta3);T_23 = double(T_23);
    T_24 = inv(T_12)*T_14;T_24 = double(T_24);
    T_34 = inv(T_23)*T_24;

    theta4 = double(Find_theta4(T_34));                                    %Finding theta_6
    thetas = [theta1,theta2,theta3,theta4,theta5,theta6];
end
function T_ = Find_T06(psi,vartheta,varphi,P6x,P6y,P6z)             %Funciton find Tranform matrix T06 with Pose P06
T_ = [cos(varphi)*cos(vartheta) cos(varphi)*sin(vartheta)*sin(psi)-sin(varphi)*cos(psi) cos(varphi)*sin(vartheta)*cos(psi)+sin(varphi)*sin(psi) P6x;
                    sin(varphi)*cos(vartheta) sin(varphi)*sin(vartheta)*sin(psi)+cos(varphi)*cos(psi) sin(varphi)*sin(vartheta)*cos(psi)-cos(varphi)*sin(psi) P6y;
                    -sin(vartheta) cos(vartheta)*sin(psi) cos(vartheta)*cos(psi) P6z;
                    0 0 0 1];
end
function theta1 = Find_theta1(T_06)                                 %Function find theta 1
   Tranform_matrix = [0,0,-0.16,1];                                 %Transform matrix of P_6 to P_5
   Tranform_matrix = Tranform_matrix(:);
   T_05  = T_06*Tranform_matrix;
   P_5x  = double(T_05(1,1));                                       %Px of P5
   P_5y  = double(T_05(2,1));                                       %Py of P5
   P_5xy = (P_5x^2 + P_5y^2)^0.5;                                   %|Pxy| of P5
   alpha1 = atan2(P_5y,P_5x);            
   alpha2 = acos(0.174/P_5xy);
   theta1 = alpha1 - alpha2 + sym(pi/2);                            %Finding theta 1.
   if theta1 > sym(pi)
       theta1 = theta1 - 2*sym(pi);
   end
end
function theta5 = Find_theta5(Pose_6,theta1,check)                  %Function find theta 5
    P_6x   = Pose_6(1,4);                                                       %Px of P6
    P_6y   = Pose_6(1,5);                                                       %Px of P6
    theta5 = acos( (P_6x*sin(theta1) - P_6y*cos(theta1) -0.174) / 0.16);        %Finding theta 5
    if check == 0
        theta5 = -acos( (P_6x*sin(theta1) - P_6y*cos(theta1) -0.174) / 0.16);
    end
end
function theta6 = Find_theta6(T_06,theta1,theta5)                   %Function find theta 6
    X_06x = T_06(1,1);                                                      
    X_06y = T_06(2,1);          
    Y_06x = T_06(1,2);
    Y_06y = T_06(2,2);
    sin_theta6 = (-Y_06x*sin(theta1)+Y_06y*cos(theta1))/sin(theta5);
    cos_theta6 = -(-X_06x*sin(theta1) + X_06y*cos(theta1))/sin(theta5);
    theta6 = atan2(sin_theta6,cos_theta6);
end
function theta3 = Find_theta3(T_14,a_2,a_3)                         %Function find theta 3
    P_14x = T_14(1,4);
    P_14y = T_14(2,4);
    P_14xy = (P_14y^2 + P_14x^2)^0.5;double(P_14xy);
    theta3 = -acos((P_14xy^2 - a_2^2 - a_3^2)/(2*a_2*a_3));
end
function theta2 = Find_theta2(T_14,theta3,a_3)                      %Function find theta 2
    double(T_14);
    P_14x = T_14(1,4);
    P_14y = T_14(2,4);
    P_14xy = (P_14x^2 + P_14y^2)^0.5;P_14xy = double(P_14xy);
    phi_1 = atan2(-P_14y,-P_14x);double(a_3*sin(theta3)/P_14xy);
    phi_2 = asin(-(a_3*sin(theta3)/P_14xy));
    theta2 = phi_1 - phi_2;
end
function theta4 = Find_theta4(T_34)                                 %Function find theta 4
    R_34xy = T_34(2,1);
    R_34xx = T_34(1,1);
    theta4 = atan2(R_34xy,R_34xx);
end

