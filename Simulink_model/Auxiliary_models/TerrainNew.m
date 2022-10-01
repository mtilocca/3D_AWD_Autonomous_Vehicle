clc;
clear all 
close all
%%  create S - theta - beta -sigma 

% straight line slope 8%

thetaAB = zeros(1001,1); 
betaAB = zeros(1001,1);
sigmaAB = zeros(1001,1);

sAB = 0:0.1:100;  sAB = sAB';


% slope of 8% 

maxSigmaAB = asin(8/100);

stepSigmaAB = maxSigmaAB/150; 

sigmaAB(1:151,1) = 0:stepSigmaAB:maxSigmaAB; 
sigmaAB(152:1001,1) = maxSigmaAB; 

anglesAB = [thetaAB betaAB sigmaAB];   


xAB = sAB .* cos(thetaAB);
yAB = sAB .* sin(thetaAB);
zAB = sAB .* sigmaAB; 

figure(1)
plot3(xAB, yAB, zAB)
grid on
grid minor
title("AB segment - straight line")



%% BC segment left curve 


Rbc = 110;  % radius of the turn 

Lbc = pi * Rbc; % length of the turn approximate 

%minSbc = max(sAB(:,1)); 
minSbc = 0; 

sBC = minSbc: 0.1 :Lbc+minSbc; 
sBC = sBC';

stepThetaBC = (2*pi)/(length(sBC)-1);
% left turn - heading 
thetaBC = 0:stepThetaBC:2*pi; 
thetaBC= thetaBC';


% slope 4.5% 

sigmaBC = zeros(length(sBC),1);

maxSigmaBC = asin(12/100);

stepSigmaBC = maxSigmaBC/50; 

%sigmaBC(1:51,1) = 0:stepSigmaBC:maxSigmaBC; 
sigmaBC(1:length(sBC),1) = maxSigmaBC; 



%  banking 5%

betaBC = zeros(length(sBC),1);

maxbetaBC = asin(15/100);

stepbetaBC = maxbetaBC/50; 

betaBC(1:51,1) = 0:stepbetaBC:maxbetaBC; 
betaBC(52:length(sBC),1) = maxbetaBC; 



% detached 



%thetaBC = 

anglesBC = [thetaBC betaBC sigmaBC];   


xBC = sBC .* cos(thetaBC) ;
yBC = sBC .* sin(thetaBC) ;
zBC = sBC .* sigmaBC; 

figure(2)
plot3(xBC, yBC, zBC)
grid on
grid minor
title("BC segment - straight line")

%% calculate beta_dot theta_dot sigma_dot and kappa ni tau 


theta_dot = thetaBC ./ 0.1; 
%theta_dot = theta_dot;

sigma_dot =  sigmaBC ./ 0.1; 
%sigma_dot = [0, sigma_dot;

beta_dot =  betaBC ./ 0.1; 
%beta_dot = beta_dot';


kappa = theta_dot - beta_dot.*sin(sigmaBC); % rotation on z -axis 

ni =  sigma_dot.*cos(thetaBC) + beta_dot.*sin(betaBC).*cos(sigmaBC) ; % rotation on y - axis 

tau = beta_dot.*cos(sigmaBC).*cos(thetaBC) - sin(betaBC).*sigma_dot; % rotation on x - axis 



pathTerrain = [xBC yBC zBC thetaBC sigmaBC betaBC kappa ni tau sBC]; 

save("pathTerrain.mat", "pathTerrain");  % path export 


%% plot banking with road scenario and way points 

resRate = 10;

xRoad = resample(xBC, 1, resRate);
yRoad = resample(yBC, 1, resRate);
zRoad = resample(zBC, 1, resRate);

% banking angle 

scenario3 = drivingScenario;

% transpose waypoints so they visually align with bank angles below
roadCenters3 = zeros(length(xRoad)-1,3);

roadCenters3(:,1) = xRoad(1:end-1,1); 
roadCenters3(:,2) = yRoad(1:end-1,1); 
roadCenters3(:,3) = zRoad(1:end-1,1); 


bankAngles = zeros(length(xRoad)-1,1);

bankAngles(:,1)= rad2deg(maxbetaBC);

road(scenario3, roadCenters3, bankAngles, 'lanes', lanespec(4));
plot(scenario3,'RoadCenters','off');
view(-30,10)
%zlim([-10, 200])






% 
%  xABC = [xAB; xBC];
%  yABC = [yAB; yBC];
%  zABC = [zAB; zBC];
% % 
% % % stack them together
% figure(3)
% plot3(xABC, yABC, zABC)
% grid on
% grid minor
% title("ABC segment - straight line")

