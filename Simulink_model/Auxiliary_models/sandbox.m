clc 
clear all 
close all 
%% 

v = 44.2;


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

az ;
v; 

%% rotational matrix 
syms t 
fxtd = 2*pi.*t.^2+cos(t); 

% fx_dot = diff(fxtd)
% fx_dot_dot = diff(fx_dot)
% 
% fy = 0.4*sin(t)+1 + cos(t); 
% 
% fy_dot = diff(fy)
% 
% fy_dot_dot = diff(fy_dot)
% 
% 
% fz = 4*sin(t)+2; 
% 
% fz_dot = diff(fz)
% 
% fz_dot_dot = diff(fz_dot)
% 
% 
% 
%            
% 
%             kappa = fz_dot_dot
% 
%             ni = fy_dot_dot + fx_dot *fz_dot_dot
% 
%             tau =  fx_dot_dot -fz_dot_dot*fy_dot


%% latex report 

syms mu n d W s Cs Ca alpha a omega  vx vy delta theta beta sigma 


n = mu*W*(1+s);
d = 2*sqrt( (Cs*s)^2 + (Ca *tan(alpha)^2) );

LamC=  n/d;

fy = delta*( (1 + (a^2 * omega^2)/(vx^2))  - ((vy + a*omega)/vx) ); 
% latex(LamC)
% latex(fy)


syms theta sigma beta 

Rz = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]; % theta --- heading 
Rx = [1 0 0; 0 cos(beta) -sin(beta) ; 0 sin(beta) cos(beta)]; % beta --- banking
Ry = [cos(sigma) 0 sin(sigma); 0 1 0; -sin(sigma) 0 cos(sigma)];% sigma ---- slope 




Rc = Rz * Ry * Rx; 

RcT = transpose(Rc);

Rc_der = diff(Rc, theta, sigma, beta);


W = Rc_der * RcT; 

%latex(W)


%%  vehicle model 