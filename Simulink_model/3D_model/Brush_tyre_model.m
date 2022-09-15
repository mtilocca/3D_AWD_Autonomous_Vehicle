function [Fx, Fy, Fz] = Brush_tyre_model(vx, vy, delta, omega, wf, wr)

% ********************************************************************************************************
% INPUTS OF THE MODEL 
%
%   mu -----> % coefficient of surface adhesion 
%   W ---->  % vertical load 
% 
%   eps ----> % adhesion reduction coefficient 
%   s ---->  % longitudinal slip
%   alpha ----> % tire slip angle 
%   v ----> % vehicle forward velocity 
%   w ---> wheel rotational speed 
%   vx ---> vehicle longitudinal speed 
%   vy --> vehicle lateral speed 
%   delta --> vehicle front steering angle 
%   omega --> vehicle yaw rate 

% ********************************************************************************************************

%% calculate tyre forces based on  Dugoff model 

CsF = 82216.6666666667; % front logitudinal tire stiffness   -- 
CsR = 41727.2727272727; % rear longitudinal tire stiffness -- 

CaF = 67740.0047457928; % front lateral cornering stiffness -- 
CaR = 90232.5227453858;  % rear lateral cornering stiffness --  


%% Road parameters 
mu = 0.8; % dry road 
% mu = 0.5 % wet road 
% mu = 0.6 % gravel 
% mu = 0.1 % ice 
% mu = 0.2 % snow 

%% vehicle parameters 
a = 1.2; 
b = 1.29;

mf =526;
mr = 488;
%% vertical load mapping according to forward velocity & load transfer model simplified 


switch v

case v*(v > 0 & v < 10.1)
az =  9.7770; 

case v*(v>= 10.1 & v < 20.1 )
az =   9.7802;

case v*(v>= 20.1 & v < 30.1 )
az =  9.7881;

case v*(v>= 30.1 & v < 40.8)
az =  9.7957;

otherwise
az = 9.81; 
end

% simple load transfer model based on empirical data 

Wf = (mf+mr)*az *(a/(a+b));
Wr = (mr +mf)*az *(b/(a+b)); 

Fz = [Wf Wr]; 

%% side slip and front slip angles 

[sf, sr] = longSlipEst(vx, wf, wr); 
[alphaF, alphaR] = sideSlipEst(vx, vy, delta, omega);

%%                FRONT WHEEL/S 
lambdaf = Lambd(CsF, CaF, mu, Wf, sf, alphaF);

% lambda func 

Flambaf = calcLamb(lambdaf); 

% longitudinal force 
Fx_f = (- (CsF *sf )/(1-sf)) * Flambaf; 

% lateral force 

LambfyF = latForce(omega, vx, vy, delta); 
Fy_f = CaF * LambfyF * Wf; 

%%   REAR WHEELS 

lambdar = Lambd(CsR, CaR, mu, Wr, sr, alphaR);

Flambar = calcLamb(lambdar); 

% longitudinal force 
Fx_r = (- (CsR *sr )/(1-sr)) * Flambar; 

% lateral force 

lambfyR = (vy - b*omega) / vx; 
Fy_r = CaR * lambfyR * Wr; 

%% output 
Fx = [Fx_f Fx_r];
Fy = [Fy_f Fy_r]; 

end 

%% Auxiliary functions to Dugoff model 

function LamC = Lambd(Cs, Ca, mu, W, s, alpha)

n = mu*W*(1+s);
d = 2*sqrt( (Cs*s)^2 + (Ca *tan(alpha)^2) );

LamC=  n/d;

end 

%%

function lambdaCalc = calcLamb(lambda)

if lambda >= 1 

    lambdaCalc = 1; 

elseif lambda <1 

    lambdaCalc = (2- lambda)*lambda ; 

end 
end 

%% lat force generation front axle 
function fy = latForce(omega, vx, vy, delta)
 a = 1.2; 

fy = delta*( (1 + (a^2 * omega^2)/(vx^2))  - ((vy + a*omega)/vx) ); 

end 