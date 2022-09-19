clc
clear all
close all
%%  palm beach 

% the fitting can be executed through the lateral and longitudinal
% velocities , the yaw, the pitch and the roll angle and the steering angle
% of the vehicle 

%load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/20130222_01_01_03_grandsport.mat'); 

%load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/20130222_01_02_03_grandsport.mat')

%load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/20130223_01_02_03_grandsport.mat')

%% laguna seca 3D 


load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/20130222_01_02_03_grandsport.mat')



 %load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/3DTrack/20130810_02_01_01_grandsport.mat')
 % best so far 

 

% load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/3DTrack/20130811_02_01_01_grandsport.mat')  % quite good 



mass = params.mass.value; 

a = params.wheelbaseFront_a.value;
b = params.wheelbaseRear_b.value;
m = params.mass.value; 
vx = insData.vxCG.value; 
vy = insData.vyCG.value; 

alphaFront = tireData.alphaFront.value;
alphaRear = tireData.alphaRear.value; 
%alphaFront= deg2rad(alphaFront);
alphaRear = deg2rad(alphaRear);

t = tireData.alphaFront.time;

yawR = insData.yawRateFilt.value; % yaw rate 

ay = insData.ayCGFilt.value; % lateral acc 

delta = tireData.roadWheelAngle.value; 
%% plot raw data 
figure(1)  
plot(t, alphaFront)
grid on 
hold on 
plot(t, alphaRear)
title('alpha front vs alpha rear ... slip angles ? ')
grid minor 

figure(2)
plot(vx*3.6)
title('longitudinal velocity [kph]')
grid on 
grid minor 



% figure(3)
% plot(t, yawR)
% title('yaw rate')
% grid on 
% grid minor 

figure(4)
plot(t, ay)
title('y-axis acceleration ')
grid on 
grid minor 
xlabel("time [s]")
ylabel("a_y [m/s^2]")
title("lateral acceleration at CoG")

figure(5)
plot(tireData.roadWheelAngle.time, delta, 'r', "DisplayName","steer avg")
title('steering angle delta')
grid on 
grid minor 
hold on 
plot(tireData.roadWheelAngleFR.time, tireData.roadWheelAngleFR.value, 'k', "DisplayName","steer FR")
plot(tireData.roadWheelAngleFL.time, tireData.roadWheelAngleFL.value, 'b', "DisplayName", "steer FL")
title("Steering behavior")
legend

figure(6)
plot(tireData.alphaFront.time, alphaFront, 'r',"DisplayName","front side slip")
grid on 
grid minor 
xlabel("time [s]")
ylabel("\alpha front [deg]")
title("Front side slip angle")
legend


figure(7)
plot(tireData.alphaRear.time, rad2deg(alphaRear), "DisplayName","rear side slip")
grid on 
grid minor 
xlabel("time [s]")
ylabel("\alpha rear [deg]")
title("Rear side slip angle")
legend 


% 
% figure(4)
% subplot(5,1,1)
% plot(ayF)
% title('ay')
% grid on 
% grid minor 
% subplot(5,1,2)
% plot(yawRF)
% title('yaw rate')
% grid on 
% grid minor 
% subplot(5,1,3)
% plot(deltaF)
% title('steering angle')
% grid on 
% grid minor 
% subplot(5,1,4)
% plot(alphaFf)
% title('front side slip angle')
% grid on 
% grid minor 
% subplot(5,1,5)
% plot(alphaRf)
% title('Rear side slip angle')
% grid on 
% grid minor 




% figure(5)
% scatter(tF, abs(CalphaR))
% title("Rear side slip cornering stiffness at 20 km/h")
% grid on 
% grid minor
% 
% figure(6)
% scatter(tF, abs(CalphaF))
% title("Front side slip cornering stiffness at 20 km/h")
% grid on 
% grid minor 


%% polynomial fitting 




% figure(8)
% plot(tF, CalphaF, 'o')
% grid on 
% grid minor 
% hold on 
% plot(tF, CfFit)
% title("front side slip cornering stiffness")
% hold off 

% 
% figure(9)
% plot(tF, CalphaR, 'o')
% grid on 
% grid minor 
% hold on 
% plot(tF, CRFit)
% title("rear side slip cornering stiffness")
% hold off 

%%







FyF = params.massFront.value.*ay; 
FyR = params.massRear.value .*ay; 

%pCf = polyfit(tF, CalphaF, 1);  CfFit = polyval(pCf, tF);

% figure(10)
% plot(alphaFront,  params.massFront.value.*ay, 'o') % filtering needed
% hold on 
% plot(alphaFront, pFitF)
% grid on 
% grid minor

FyF_filt = (FyF > -922) & (FyF < 8) & (alphaFront >= 1.45); 
FyF_f = FyF(~FyF_filt);
%FyF_f = resample(FyF_f, 1,50); 

alphaFront_filt = (FyF > -922) & (FyF <  8) & (alphaFront >= 1.45); 
alphaFront_f = alphaFront(~alphaFront_filt);
alphaFront_f = deg2rad(alphaFront_f);
%alphaFront_f = resample(alphaFront_f, 1,50); 
alphaFront = deg2rad(alphaFront);

coeff1 = polyfix(alphaFront_f, FyF_f, 1, 0, 0, [],[]); 
coeff2 = polyfix(alphaRear, FyR, 1, 0, 0 ,[], []);

pFitF = polyval(coeff1, alphaFront_f); 
pFitR = polyval(coeff2, alphaRear);

figure(11)
plot(alphaFront_f, FyF_f, '.', 'DisplayName','data')
xlabel("Front side slip angle [rad]")
ylabel("F_y Front [N]")
grid on
grid minor 
hold on 
plot(alphaFront_f, pFitF,  'DisplayName','fitting')
title("front side slip cornering stiffness")
legend
hold off

figure(12)
plot(alphaRear, FyR, '.', 'DisplayName','data')
xlabel("Rear side slip angle [rad]")
ylabel("F_y Rear [N]")
grid on 
grid minor 
hold on 
title("Rear side slip cornering stiffness")
plot(alphaRear, pFitR, 'DisplayName','fitting')
legend
hold off

%%
% coeff1  % front 
% 
% coeff2  % rear 