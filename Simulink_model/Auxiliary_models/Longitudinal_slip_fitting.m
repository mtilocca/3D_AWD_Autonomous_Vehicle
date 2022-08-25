clc
clear all
close all
%%  load and select data 

load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/Auxiliary_models/Data/20130222_01_02_03_grandsport.mat')


vx = insData.vxCG.value; 
tvx = insData.vxCG.time; 

theta = insData.roadGradeAngle.value;  % theta - road grade angle 

ax = insData.axCGFilt.value; 

tlon = insData.axCGFilt.time; 

mf = params.massFront.value;
mr =params.massRear.value; 

g = 9.81; % g acc 

Rf = params.rollingCircumferenceFL.value ;
Rr = params.rollingCircumferenceRR.value; 


%% retrieve and average velocity through hall effect sensor 

hallWFL = tireData.wheelTicksFL; % front left 
hallWFR = tireData.wheelTicksFR; % front right 
hallWRR = tireData.wheelTicksRR; % rear right
hallWRL = tireData.wheelTicksRL; % rear left 

 VFL = omegaCalc(hallWFL, Rf);  % front wheels 

 %VFR = omegaCalc(hallWFR, Rf);   % discard it cuz does not work 


VRR = omegaCalc(hallWRR, Rr);
VRL = omegaCalc(hallWRL, Rr);

% figure(3)
% plot(tvx, vx)
% resample vx at VFLx 

vxnewF = interp1(tvx, vx, VFL.t); 


% resample VRR and VRL 

VRL.v = interp1(VRL.t, VRL.v, VRR.t) ; % interpolation 
% compute average of the two 

VRavg = (VRL.v+VRR.v)./2; 




% resample VRavg and vx 

%% calculate Fx and plot it against Slip 

Fxf = mf .* ax;
Fxr = mr .*ax;

Fxr = interp1(tlon, Fxr, VRR.t); 
vxRes = interp1(tlon, vx, VRR.t);

Fxf = interp1(tlon, Fxf, VFL.t); 


% calculate rear and front slip 

SlipF = (VFL.v - vxnewF)./vxnewF; 

SlipR = (VRavg -vxRes) ./ vxRes; 

Fxf_rID= (SlipF < -0.4);  % filter front 
Fxf = Fxf(~Fxf_rID); 
SlipF = SlipF(~Fxf_rID); 
tFxf = VFL.t(~Fxf_rID);


Fxr_rID= (SlipR < -0.4);  % filter front 
Fxr = Fxr(~Fxr_rID); 
SlipR = SlipR(~Fxr_rID); 
tFxr = VRR.t(~Fxr_rID); 

%% fitting of Cxf and Cxr 

% 

coeff1 = polyfix(SlipF, Fxf, 1, [0, -0.06], [0, -4933], [],[]); 
coeff2 = polyfix(SlipR, Fxr, 1, [0, -0.11], [0, -4590] ,[], []);

pFitF = polyval(coeff1, SlipF); 
pFitR = polyval(coeff2, SlipR);


% plot front -- data vs fitting 
figure(1)
plot(SlipF, Fxf, 'o', "DisplayName", "data")
xlim([-0.1 0.1])
grid on 
grid minor 
hold on 
plot(SlipF, pFitF)
xlabel("longitudinal slip", "DisplayName", "fitting")
ylabel("F_x [N]")
legend




% plot rear -- data vs fitting 

figure(2)
plot(SlipR, Fxr, 'o' , "DisplayName", "data")
xlim([-0.1 0.1])
title("Rear Longitudinal Slip")
grid on 
grid minor 
hold on 
plot(SlipR, pFitR, "DisplayName", "fitting")
xlabel("longitudinal slip")
ylabel("F_x [N]")
legend


figure(3)
plot(tFxf, Fxf, 'k')
grid on 
grid minor 
xlabel("time [s]")
ylabel("F_x front [N]")
title("Front longitudinal force")


figure(4)
plot(tFxr, Fxr, 'm')
grid on 
grid minor 
xlabel("time [s]")
ylabel("F_x Rear [N]")
title("Rear longitudinal force")


figure(5)
plot(tFxf, SlipF, 'r')
grid on 
grid minor 
xlabel("time [s]")
ylabel("front slip [rad]")
title('Front longitudinal slip')

figure(6)
plot(tFxr, SlipR, 'b')
grid on 
grid minor 
xlabel("time [s]")
ylabel("rear slip [rad]")
title('Rear longitudinal slip')

% figure(7)
% plot(SlipF, Fxf, '--')

coeff1 
coeff2

%% Auxiliary function - find velocity of the wheel through hall effect sensor measurements 

function vel = omegaCalc(HallT, circum)

[~,loc] = findpeaks(-HallT.value);

time_peaks = HallT.time(loc);

delta = diff(time_peaks);
v=(circum)./delta;

vel.v = v;
vel.t = time_peaks(1:end-1); 

end 


