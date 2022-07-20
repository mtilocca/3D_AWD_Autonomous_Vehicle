clc;
clear all;
close all;

syms Kr Kf m vdot u OmegaZ alphaR alphaF a b Iz OmegaZdot x_dot v y_dot  psi

eqn1 = (m*(vdot+u*OmegaZ))-(Kr*alphaR) == Kf*alphaF;  % yaw dynamics equations 
eqn2 = (a*Kf*alphaF) - (Iz*OmegaZdot) ==Kr*alphaR*b;



solution = solve([eqn1, eqn2], [Kr, Kf]);
solution.Kf; % front cornering stiffness 
solution.Kr; % rear cornering stiffness 

% derivation of the lateral and longitudinal velocities given the x-y deriv
% and yaw angle 

eqn3 = x_dot == u *cos(psi) -v*sin(psi);
eqn4 = y_dot == v*cos(psi) + u * sin(psi);

solution2 = solve([eqn3, eqn4], [u, v]);

solution2.u % longitudinal velocity
solution2.v % lateral velocity 
