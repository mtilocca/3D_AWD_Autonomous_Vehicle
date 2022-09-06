clc 
clear all;
close all; 
clear all;
clc;
%% rotational matrix derivation 

syms theta sigma beta 

Rz = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]; % theta 
Rx = [1 0 0; 0 cos(sigma) -sin(sigma) ; 0 sin(sigma) cos(sigma)]; % sigma
Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];% beta 


Rc = Rz * Ry * Rx

%RcCompt = [cos(beta)*cos(theta), sin(beta)*cos(theta)*sin(sigma) - cos(sigma)*sin(theta), sin(sigma)*sin(theta) + sin(beta)*cos(sigma)*cos(theta);
    %cos(beta)*sin(theta), cos(sigma)*cos(theta) + sin(beta)*sin(sigma)*sin(theta), sin(beta)*cos(sigma)*sin(theta) - cos(theta)*sin(sigma);
       %  -sin(beta),                                    cos(beta)*sin(sigma),                                    cos(beta)*cos(sigma)];
 
RcThe = diff(Rz, theta);
RcSig = diff(Rx, sigma);
RcBet = diff(Ry, beta);

%Rc_der = RcThe * RcSig * RcBet;
Rc_der = diff(Rc, theta, sigma, beta)
RcT = transpose(Rc);

Wc = Rc_der * RcT
% calculate Wc tensor 

% derivative ? 


Rc_o = [cos(theta) -sin(theta) cos(theta)*sigma+sin(theta)*beta; sin(theta) cos(theta) sin(theta)*sigma-cos(theta)*beta; -sigma beta 1]; 

