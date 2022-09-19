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


Rbc = 40;  % radius of the turn 

Lbc = pi * Rbc; % length of the turn approximate 

minSbc = max(sAB(:,1)); 


sBC = minSbc: 0.1 :Lbc+minSbc; 
sBC = sBC';


% left turn - heading 
thetaBC = 0:0.005:2*pi; 
thetaBC= thetaBC';


% slope 4.5% 

sigmaBC = zeros(length(sBC),1);

maxSigmaBC = asin(12/100);

stepSigmaBC = maxSigmaBC/50; 

%sigmaBC(1:51,1) = 0:stepSigmaBC:maxSigmaBC; 
sigmaBC(1:length(sBC),1) = maxSigmaBC; 



%  banking 5%

betaBC = zeros(length(sBC),1);

maxbetaBC = asin(7.5/100);

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




%% plot banking with road scenario and way points 





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

