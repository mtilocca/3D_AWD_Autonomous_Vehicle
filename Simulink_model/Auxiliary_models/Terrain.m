%function [X, Y, Z] = Terrain()
%%  Terrain Modeling without toolbox -- Parametric road Modeling 

fx = @(t) 2*pi.*t.^2; % heading 
fy = @(t) 0.4*sin(t)+1 + cos(t); % slope 
fz = @(t) 4*sin(t)+2; % banking


T = [0:0.02:3.4]; % same number of steps as for simulation time 

X = fx(T);
Y = fy(T);
Z = fz(T);


% - for debug and visualization purposes 
paramsX = [min(X), max(X)];
paramsY = [min(Y), max(Y)];
paramsZ = [min(Z), max(Z)];



figure(1)
%plot3(X,Z,Y, "ko")

%hold on
plot3(X,Z,Y, "r")
grid on
grid minor
zlim([0 15])
xlabel({'heading','(x-axis)'})
ylabel({'banking','(z-axis)'})
zlabel({'slope','(y-axis)'})
title('paramteric trajectory modeling')

%end 





