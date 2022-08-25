function LongSlip = longSlipEst(Vx, wf, wr) % function for the estiamtion of the longitudinal slip of the front tyres 

Rwf = 1.87/(2*pi);
Rwr =2.01 /(2*pi) ; 

SaF = (Vx - wf*Rwf) / Vx;

SaR = (Vx - wr*Rwr)/ Vx;

LongSlip = [SaF, SaR];
end 