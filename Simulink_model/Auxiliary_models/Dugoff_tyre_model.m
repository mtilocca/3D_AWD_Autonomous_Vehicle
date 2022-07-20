function [Fx, Fy] = Dugoff_tyre_model(Cs, Ca, mu, W, eps, s, alpha, v)

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

% ********************************************************************************************************

%% calculate tyre forces based on  Dugoff model 

CsF = Cs(1); % front logitudinal tire stiffness   -- TODO estimate it 
CsR = Cs(2); % rear longitudinal tire stiffness -- TODO estimate it 

CaF = Ca(1); % front lateral cornering stiffness -- TODO estimate it 
CaR = Ca(2);  % rear lateral cornering stiffness -- TODO estimate it  



% %                FRONT WHEEL/S 
lambda = Lambd(CsF, CaF, mu, W, eps, s, alpha, v );

% lambda func 

Flamba = calcLamb(lambda); 

% longitudinal force 
Fx_f = (- (CsF *s )/(1-s)) * Flamba; 

% lateral force 

Fy_f = (- (CaF *tan(alpha))/(1-s)) * Flamba;

%  %   REAR WHEELS 

% longitudinal force 
Fx_r = (- (CsR *s )/(1-s)) * Flamba; 

% lateral force 

Fy_r = (- (CaR *tan(alpha))/(1-s)) * Flamba;


%% output 
Fx = [Fx_f Fx_r];
Fy = [Fy_f Fy_r]; 
end 

%% Auxiliary functions to Dugoff model 

function LamC = Lambd(Cs, Ca, mu, W, eps, s, alpha, v)

n = mu*W*(1-eps *v *sqrt(s^2 +( tan(alpha) )^2 ) ) * (1-s);
d = 2*Cs^2 *s^2 + Ca^2 * tan(alpha)^2;

LamC=  n/d;

end 



function lambdaCalc = calcLamb(lambda)

if lambda > 1 

    lambdaCalc = 1; 

elseif lambda <1 

    lambdaCalc = 2- lambda ; 

end 
end 