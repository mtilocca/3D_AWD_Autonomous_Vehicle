function w_dot = wheelRotA(Fx, f, Tw)

% implement the torque from motor 


Iw = 80; % wheel inertia 

% map the torque according to the vehicle velocity -- lookup table fashion 

if f
R= 1.87/(2*pi);
else
R=2.01 /(2*pi) ; 
end


w_dot = (-Fx*R + Tw) / Iw; 


end 