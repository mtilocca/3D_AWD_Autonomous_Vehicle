function sideSlip = sideSlipEst(Vx, Vy, delta, w) % function for the estiamtion of the sidel slip of the tires 

a = 1.2; 
b = 1.29;

%syms a b Vy delta w Vx 


alphaF = ((Vy + a*w) / Vx) - delta;
alphaR = ((Vy - b*w) /Vx); 

%latex(alphaF) 

%latex(alphaR)

sideSlip = [alphaF, alphaR];
end 