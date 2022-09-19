
clc;
clear all;
close all; 

%% vehicle model equations 



syms u alpha v n kappa omegaZ n s tau omegaX omegaY ni omegaXdot omegaYdot omegaZdot 

% 
% s_dot = (u*cos(alpha)-v*sin(alpha)/(1-n*kappa));
% 
% 
% 
% 
% %20b
% n_dot = u*sin(alpha)+v*cos(alpha);
% 
% 
% 
% %20c
% alpha_dot = omegaZ - kappa *(u*cos(alpha)-v*sin(alpha)/(1-n*kappa)); % relative yaw velocity 


%% positioning
% 8a 
% u = (1-n*kappa)*s_dot *cos(alpha) + n_dot*sin(alpha); % x- axis position
% 
% 
% 
% % 8b
% v = -(1-n*kappa)*s_dot *sin(alpha) + n_dot*cos(alpha); % y-
% 
% 
% 
% % 8c 
% w = n*tau*s_dot; % z axis position 


%% yaw -pitch - roll angles 

%9a
% omegaX = [tau*cos(alpha)+ni*sin(alpha)]*s_dot; % roll velocity
% 
% %9b
% omegaY = [-tau*sin(alpha)+ni*cos(alpha)]*s_dot; % pitch velocity 
% 
% 
% %9c 
% omegaZ = kappa*s_dot + alpha_dot;  % yaw velocity 

%% accelerations 

syms  Ixz Ixx Izz Fzf a b Fzr Fxf Fxr delta Fyf Iyy Fyr Fxr omegaXprev dt M beta sigma u_dot v_dot w_dot h g w omegaYdot omegaZdot omegaXdot 
% yaw -pitch - (roll ) 

%omegaYdot = (Ixz*omegaZ^2 - omegaX*(Ixx - Izz)*omegaZ + Fzf*a - Fzr*b + h*(Fxf + Fxr - Fyf*delta))/Iyy;


%omegaZdot = ((-b*Fyr + a*(Fyf - Fxf*delta))) / Izz; 


%omegaXdot = (omegaX - omegaXprev) / dt ; 



 % x-y-z
 u_dot = (Fxf + Fxr - Fyf*delta + M*(beta*sin(alpha) - sigma*cos(alpha)) + M*(omegaZ*v - omegaY*w) + M*h*(omegaYdot + omegaX*omegaZ))/M; 

 

 v_dot = (Fyf + Fyr - Fxf*delta - M*(omegaZ*u - omegaX*w) - M*h*(omegaXdot - omegaY*omegaZ) + M*g*(beta*cos(alpha) + sigma*sin(alpha)))/M; 



 w_dot = -(Fzf + Fzr - M*g - M*(omegaY*u - omegaX*v))/M; 
 


%%

% 15 


syms delta_dot tau_D delta_req tau_H  ped_dot ped_req ped tau_ped 
 % Longitudinal force deriv  --- mass * longitudinal jerk -- probably not needed 
delta_dot    = (-delta * tau_D + delta_req) / tau_D / tau_H; % steering speed (rad/s) 

latex(delta_dot)

ped_dot = (ped_req - ped) / tau_ped;


latex(ped_dot)