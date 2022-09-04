clc;
clear all;
close all;

%% variables 

syms Kr Kf m vdot u OmegaZ alphaR alphaF a b Iz OmegaZdot x_dot v y_dot  psi

%% conerning stiff

eqn1 = (m*(vdot+u*OmegaZ))-(Kr*alphaR) == Kf*alphaF;  % yaw dynamics equations 
eqn2 = (a*Kf*alphaF) - (Iz*OmegaZdot) ==Kr*alphaR*b;



solution = solve([eqn1, eqn2], [Kr, Kf]);
solution.Kf; % front cornering stiffness 
solution.Kr; % rear cornering stiffness 

solution3 = solve([eqn2], [Iz]); 
solution3


% derivation of the lateral and longitudinal velocities given the x-y deriv
% and yaw angle 

%% pose 
eqn3 = x_dot == u *cos(psi) -v*sin(psi);
eqn4 = y_dot == v*cos(psi) + u * sin(psi);

solution2 = solve([eqn3, eqn4], [u, v]);

solution2.u % longitudinal velocity
solution2.v % lateral velocity 


%% 1st order dynamics --- x-y-z velocities 
syms M u_dot omegaY w omegaZ v M sigma alpha beta h omegaX omegaYdot Fxr Fxf Fyf Fyr delta v_dot u omegaXdot w_dot Fzf  g Fzr Iyy Ixx Izz Ixz omegaZdot a b 

eqn5 = M*(u_dot + omegaY*w -omegaZ*v) +M*((sigma*cos(alpha) - beta*sin(alpha))) + M*h*(-omegaX*omegaZ - omegaYdot) == Fxr + Fxf - Fyf*delta; 

solutionUdot = solve(eqn5, u_dot) % u dot - 10 a eqs 


%%%%%%%%%%%%%%%

eqn6 = M*(v_dot - omegaX*w + omegaZ*u) - M*g*((beta*cos(alpha) + sigma *sin(alpha))) + M*h*(omegaXdot - omegaY*omegaZ) == Fyf + Fyr - Fxf*delta; 

solutionVdot = solve(eqn6, v_dot) % v_dot - 10 b 

%%%%%%%%%%%%%%%%%%%

eqn7 = M*(w_dot - omegaY*u + omegaX*v) == M*g - Fzr -Fzf;

solutionWdot = solve(eqn7, w_dot)




%% 1st order dynamics --- yaw and pitch velocities 


eqn8 = Iyy *omegaYdot + (Ixx - Izz)*omegaX*omegaZ - Ixz*omegaZ^2 == a*Fzf - b*Fzr + h*(Fxr+Fxf - Fyf*delta);

solutionOmegaYdot = solve(eqn8, omegaYdot)

