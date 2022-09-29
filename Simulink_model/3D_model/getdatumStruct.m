function datum = getdatumStruct()

%     datum.vehicleM = 0; % vehicle mass
%     datum.vehicleLr = 0; % Wheel base rear 
%     datum.vehicleLr = 0;  % Wheel base front 
%    
%     datum.vehicleH = 0; % vehicle height 
%     datum.vehicleIxx = 0; % roll inertia
%     datum.vehicleIyy = 0; % pitch inertia
%     datum.vehicleIzz = 0; % yaw inertia
%     datum.vehicleIxz = 0; % cross inertia
%     datum.vehicleW = 0; % width
%     datum.vehicleP = 0; % vehicle power in kW
%     datum.vehicleMu = 0; % adherence coefficient 
%     datum.vehicleKr = 0; % rear cornering slip
%     datum.vehicleKf = 0; % front cornering slip 
%     datum.vehicleTauN = 0; % tire load relaxation time
%     datum.vehicleTauS = 0; % speed relaxation time

%     datum.roadS = 0; % length of the curve 
%     datum.roadKappa0 = 0; % road curvature -- transversal plane (xy)
%     datum.roadVu0 = 0; % road curvature -- sagittal plane (xz)
%     datum.roadSigmaS0 = 0; % 
%     datum.roadW = 0; % [m] path width 
% 
%     datum.roadTheta0 = 0; % path heading 
%     datum.roadBeta0 = 0; % path slope 
%     datum.roadSigma0 = 0; % path banking 
% 
% 
% 


datum.M = 1014; % mass of the vhicle 

datum.a = 1.2; % rear axle length from centre of mass 
datum.b = 1.29; % front axle length from centre of mass 
datum.h = 0.5; % height from the terrain w.r.t. centre of mass 

datum.Kr = 90232.5227453858; % side slip cornering stiffness - rear
datum.Kf = 67740.0047457928; % side slip cornering stiffness - front 

datum.Skf = 82216.6666666667;
datum.Skr = 41727.2727272727; % rear longitudinal slip coefficient 

datum.Iyy =50; % pitch inertia [kg*m^2]
datum.Ixz =1950; % cross inertia 
datum.Izz =1730; % yaw inertia 
datum.Ixx = 590; % roll inertia 




datum.tau_D =14;
datum.tau_H = 0.03;

datum.tau_ped= 0.03; 

datum.maxTorque = 476; 
datum.brakeRatio = 0.5 ; 
datum.brakeTorqueMax = datum.maxTorque * 2; 
datum.tau_redF = 3.5;   
datum.tau_redR = 2.5;
datum.Rwf = 1.87/(2*pi);
datum.Rwr =2.01 /(2*pi) ; 
    


end


