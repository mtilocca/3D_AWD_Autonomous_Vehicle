clc
clear all 
close all



%% define theta-sigma-beta and s 




%% 

Terr = TerrainCL(5, 0.05); 

road = Terr.TwDTrj(true, 0.06, 3.8, 15, 3); 

%road3D = Terr.TrDTrj(true, 0.06, 3.8, 15, 3, 0.4, 1, 4, 2);


[road3D,  ktp]= Terr.default3D(true); 

%% retrieve heading, slope and banking from coordinates x-y-z 
X = road3D(1:end, 1); 
Y = road3D(1:end, 2); 
Z = road3D(1:end, 3);

kappa = ktp(1:end, 1); 
ni = ktp(1:end, 2);
tau = ktp(1:end, 3); 

%heading = rad2deg(atan(X ./  Y));  % atan(x/y) 
heading(1,1) = 0; 

%slope = rad2deg(atan(Z ./  Y));  % atan(x/z) 
slope(1,1) = 0; 

%banking = rad2deg(atan(Y ./  Z));  % atan(y/z) 
banking(1,1) = 0; 




%%  export into a .mat file : x-y-z & kappa ni tau 


path.x = X; 
path.y = Y;
path.Z = Z; 
path.kappa = kappa;
path.ni = ni;
path.tau = tau; 

save('path');  % export the path 