function LongSlip = longSlipEst(Vwxf, Vwxr, wf, wr, Rwf, Rwr) % function for the estiamtion of the longitudinal slip of the front tyres 

SaF = (Vwxf - wf*Rwf) / Vwxf;

SaR = (Vwxr - wr*Rwr)/ Vwxr;

LongSlip = [SaF, SaR];
end 