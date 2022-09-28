function LongSlip = longSlipEst(Vx, wf, wr) % function for the estiamtion of the longitudinal slip of the front tyres 

debug = true;

%syms Vx wf wr Rwr Rwf SaF SaR
Rwf = 1.87/(2*pi);
Rwr =2.01 /(2*pi) ; 

if debug
disp("----------- longitudinal slip function -----")
disp("Velocity")
disp(Vx)
disp("front wheel rot speed ")
disp(wf)
disp("rear wheel rot speed ")
disp(wr)
disp("---------------")
end 

SaF = (Vx - wf*Rwf) / Vx;

disp("long slip front function")
disp(SaF)
disp("~~~~~~~~~~~~************~~~~~~~~")

SaR = (Vx - wr*Rwr)/ Vx;




%latex(SaR)
%latex(SaF)

LongSlip = [SaF, SaR];
end 