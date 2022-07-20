%function Cornering_stiffness = Cstiff()   % lateral 


% the purpose of this scritp is to do a fitting of the corneing stiffs
% values of the vehicle, namely Kr and Kf front the rear and front values 

clc
clear all
close all

% the fitting can be executed through the lateral and longitudinal
% velocities , the yaw, the pitch and the roll angle and the steering angle
% of the vehicle 

data1 = readmatrix('Empirical_params_Resampled.csv');


% dset = [timeResample, yaw, pitch, roll, lat, lon, altitude, u, v, Omega, Omega_dot, steerAngle];

time = data1(:, 1);
u = data1(:, 8);
v = data1(:, 9);
OmegaZ = data1(:, 10);
OmegaZdot = data1(:, 11);
delta = data1(:,12); 

matLength = length(time);

%% Constants of the vehicle 

Iz = 2355; % vehicle moment of inertia tensor component on z-axis  [kg*m^2]  - vehicle manufacturer parameter 

a =2.8; % front axle distance from vehicle CoG  - vehicle mnaufacturer parameter
b = 2.45; % rear axle distance from vehicle CoG  - vehicle manufacturer parameter 
m = 5430; % total mass of the vehicle 

%% Yaw dynamics -- Linear modeling fitting -- independent of tyre loads 

% find the lateral acceleration according to time derivative 

vdot =zeros(length(length(v))-1,1) ;

for i = 1:matLength-1

    vdot(i) = (v(i+1)-v(i))/ time(1); 

end 

vdot= [0, vdot]';
% --- calculated ------
alphaR = zeros(length(length(delta)),1) ; % rear slip angle 
alphaF = zeros(length(length(delta)),1) ; % front slip angle 


% initialize outputs 

Kr = zeros(length((delta)),1) ;  
Kf = zeros(length((delta)),1) ;
% general eqs 
%  step one . define slip angles 

 for i = 1:matLength
alphaF(i) = delta(i) - ((a*OmegaZ(i) + v(i))/u(i));
alphaR(i) = (b*OmegaZ(i) -v(i))/u(i);
 end 

 alphaF = alphaF';
 alphaF(1) = 0;
 alphaR = alphaR';
 alphaR(1) = 0;

 for i = 1:matLength
if alphaF(i) ~= 0 && alphaR(i) ~=0
Kf(i) = (Iz*OmegaZdot(i) + b*m*vdot(i) + OmegaZ*b*m*u(i)) / (a*alphaF(i) + alphaF(i)*b); 
Kr(i) = (a*m*vdot(i) - Iz*OmegaZdot(i) + OmegaZ(i)*a*m*u(i))/(alphaR(i)*(a + b)); 
end 
end 


% plot unfitted data 
 %figure(1)
 %plot
% -- plot 
% execute a linear fitting 
Cornering_stiffness = [Kr, Kf];

%% Linear Regression fitting 

%end 