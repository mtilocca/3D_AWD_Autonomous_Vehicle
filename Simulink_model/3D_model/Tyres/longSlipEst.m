function LongSlip = longSlipEst(Vx, wf, wr) % function for the estiamtion of the longitudinal slip of the front tyres 


%syms Vx wf wr Rwr Rwf SaF SaR
Rwf = 1.87/(2*pi);
Rwr =2.01 /(2*pi) ; 

SaF = (Vx - wf*Rwf) / Vx;

SaR = (Vx - wr*Rwr)/ Vx;




%latex(SaR)
%latex(SaF)

LongSlip = [SaF, SaR];
end 