clc, clear, close all
syms theta_1 theta_2 theta_3 theta_4 theta_5 theta_6 
a_1 = 0;            alpha_1 = sym(-pi/2);       d_1 = 0.181;        %theta_1 = 1.57;  %Joint_1:
a_2 = 0.613;        alpha_2 = 0;                d_2 = 0.039;        %theta_2 = 0;  %Joint_2:
a_3 = 0.571;        alpha_3 = 0;                d_3 = 0;            %theta_3 = 0;  %Joint_3:
a_4 = 0;            alpha_4 = sym(-pi/2);       d_4 = 0.135;        %theta_4 = 0;  %Joint_4:
a_5 = 0;            alpha_5 = sym(pi/2);        d_5 = 0.12;         %theta_5 = 0; 
a_6 = 0;            alpha_6 = 0;                d_6 = 0.16;         %theta_6 = 0;  %Joint_6:

T_01 =  



function T = translation_func(T_x,T_y,T_z)
    T = [T_x,T_y,T_z,0];
end
function R_x = rotate_x_func(alpha)
    R_x = [1 0 0 0;
           0 cos(alpha) -sin(alpha) 0;
           0 sin(alpha) cos(alpha) 0;
           0 0 0 1];
end
function R_z = rotate_z_func(alpha)
    R_z = [cos(alpha) -sin(alpha) 0 0;
           sin(alpha) cos(alpha) 0 0;
           0 0 1 0;
           0 0 0 1];
end
function R_y = rotate_y_func(alpha)
    R_y = [cos(alpha) 0 sin(alpha) 0;
           0 1 0 0;
           -sin(alpha), 0, cos(alpha) 0
           0 0 0 1];
end