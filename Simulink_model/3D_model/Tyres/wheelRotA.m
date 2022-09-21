function w_dot = wheelRotA(Fx, f)

Iw = 80; % wheel inertia 

% map the torque according to the vehicle velocity -- lookup table fashion 


R=0;
hp = 250; 
Tmax = 476;  % max corvette 1963 torque --- map torque later on 

dFront = 3.5; 
dRear = 2.5; 

if f 
    Tw = Tmax / dFront;    
    R= 1.87/(2*pi);
else 
    Tw = Tmax/ dRear; 
    R = 2.01/(2*pi);
end 

w_dot = (-Fx*R + Tw) / Iw; 


end 