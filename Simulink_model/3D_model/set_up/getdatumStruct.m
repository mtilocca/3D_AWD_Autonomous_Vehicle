function datum = getdatumStruct()

    datum.vehicleM = 0; % vehicle mass
    datum.vehicleLr = 0; % Wheel base rear 
    datum.vehicleLr = 0;  % Wheel base front 
   
    datum.vehicleH = 0; % vehicle height 
    datum.vehicleIxx = 0; % roll inertia
    datum.vehicleIyy = 0; % pitch inertia
    datum.vehicleIzz = 0; % yaw inertia
    datum.vehicleIxz = 0; % cross inertia
    datum.vehicleW = 0; % width
    datum.vehicleP = 0; % vehicle power in kW
    datum.vehicleMu = 0; % adherence coefficient 
    datum.vehicleKr = 0; % rear cornering slip
    datum.vehicleKf = 0; % front cornering slip 
    datum.vehicleTauN = 0; % tire load relaxation time
    datum.vehicleTauS = 0; % speed relaxation time

    datum.roadS = 0; % length of the curve 
    datum.roadKappa0 = 0; % road curvature -- transversal plane (xy)
    datum.roadVu0 = 0; % road curvature -- sagittal plane (xz)
    datum.roadSigmaS0 = 0; % 
    datum.roadW = 0; % [m] path width 

    datum.roadTheta0 = 0; % path heading 
    datum.roadBeta0 = 0; % path slope 
    datum.roadSigma0 = 0; % path banking 


end


