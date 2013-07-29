% check the bistatic angle variation equation

clear all;
clc;

% posn vector
i_a = [0 1];
i_b = [1 0];

% unit vector of the mid point
i_ab = (i_a+i_b)/sqrt(sum((i_a+i_b).^2));

% value of K(t)
sqrt(sum((i_a+i_b)./2.^2))

% Bistatic angle variation
B_ang_var = acos(i_a*i_b');

cos(B_ang_var./2)
% angle_var = acos()