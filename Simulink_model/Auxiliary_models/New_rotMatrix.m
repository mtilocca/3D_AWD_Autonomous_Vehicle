clc 
clear all;
close all; 
clear all;
clc;
%% rotational matrix derivation 

syms theta sigma beta theta_dot sigma_dot  beta_dot  s



Rz = [cos(theta)    -sin(theta)     0; ...
          sin(theta)    cos(theta)      0; ...
                 0                   0           1];

Ry =[cos(sigma)     0       sin(sigma) ; ...
            0                 1               0; ...
     -sin(sigma)        0           cos(sigma)];

Rx = [1         0                   0; ...
           0    cos(beta)           -sin(beta); ...
           0    sin(beta)               cos(beta)];


Rc = Rz * Ry * Rx ; 

RcT = Rc' ; 


i = [1 0 0]';
j = [0 1 0]'; 
k = [0 0 1]'; 


% kappa = theta_dot * k; 
% ni = sigma_dot * Rz *j ; 
% tau = beta_dot * Rz * Ry * i ; 


x = [beta_dot sigma_dot theta_dot]';


omega = [cos(theta)*cos(sigma)     -sin(beta)    0 ;        cos(sigma)*sin(beta)     cos(theta)   0 ;     -sin(sigma)     0     1];


Wc = omega*x; 

kappa = Wc(3,1);
ni= Wc(2,1);
tau = Wc(1,1); 


%Rc = Rz * Ry * Rx;
% 
% %RcCompt = [cos(beta)*cos(theta), sin(beta)*cos(theta)*sin(sigma) - cos(sigma)*sin(theta), sin(sigma)*sin(theta) + sin(beta)*cos(sigma)*cos(theta);
%     %cos(beta)*sin(theta), cos(sigma)*cos(theta) + sin(beta)*sin(sigma)*sin(theta), sin(beta)*cos(sigma)*sin(theta) - cos(theta)*sin(sigma);
%        %  -sin(beta),                                    cos(beta)*sin(sigma),                                    cos(beta)*cos(sigma)];
%  
% %RcThe = diff(Rz, theta);
% %RcSig = diff(Rx, sigma);
% %RcBet = diff(Ry, beta);
% 
% %Rc_der = RcThe * RcSig * RcBet;
% Rc_derZ = diff(Rz, s);
% RcTZ = transpose(Rz);
% % 
% WcZ = Rc_derZ * RcTZ; 
% 
% Rc_derY = diff(Ry, s);
% RcTY = transpose(Ry);
% % 
% WcY = Rc_derY * RcTY; 
% 
% Rc_derX = diff(Rx, s);
% RcTX = transpose(Rx);
% % 
% WcX = Rc_derX * RcTX; 








% % calculate Wc tensor 
% 
% % derivative ? 
% 
% % 
 Rc_o = [cos(theta) -sin(theta) cos(theta)*sigma+sin(theta)*beta; sin(theta) cos(theta) sin(theta)*sigma-cos(theta)*beta; -sigma beta 1]; 

 
% 
% Rc_oT = transpose(Rc_o);
% 
% Rc_o_D = diff(Rc_o, s); 
% 
% 
% Wc_o = Rc_o_D * Rc_oT; 
% 
% 
% Wc11 = (sin(theta(s))*beta(s) + cos(theta(s))*sigma(s))*(sin(theta(s))*diff(beta(s), s) + cos(theta(s))*diff(sigma(s), s) + cos(theta(s))*beta(s)*diff(theta(s), s) - sin(theta(s))*sigma(s)*diff(theta(s), s)); 
% 
% latex(Wc11)
%  

% 
% %eqprova = cos(theta(s));
% 
% %d3 = diff(eqprova, s)


%%  trial 


% Rz = [cos(theta(s)) -sin(theta(s)) 0 ; sin(theta(s)) cos(theta(s)) 0 ; 0 0 1]; 
% 
% RzT = transpose(Rz);
% 
% RzDot = diff(Rz, s); 
% 
% 
% RzP = RzDot * RzT; 
