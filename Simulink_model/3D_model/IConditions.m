function cond = IConditions()

    % This script is used to define the initial conditions of the vehicle
    % and the model states 

    %% Load vehicle and Road data

    datas = getdatumStruct(); 

    m  = datas.vehicleM; % vehicle mass
    Lr = datas.vehicleLr; % Wheel base rear 
    Lf = datas.vehicleLr;  % Wheel base front 
    L  = Lf + Lr; % wheel base summed 
    h = datas.vehicleH; % vehicle height 
    Ixx = datas.vehicleIxx; % roll inertia
    Iyy = datas.vehicleIyy; % pitch inertia
    Izz = dats.vehicleIzz; % yaw inertia
    Ixz = datas.vehicleIxz; % cross inertia
    w = datas.vehicleW; % width
    p = datas.vehicleP; % vehicle power in kW
    adC = datas.vehicleMu; % adherence coefficient 
    Kr = datas.vehicleKr; % rear cornering slip
    Kf = datas.vehicleKf; % front cornering slip 
    tauN = datas.vehicleTauN; % tire load relaxation time
    tauS= datas.vehicleTauS; % speed relaxation time
    g  = 9.81; 
    
    datas.roadS = 0; % length of the curve 
    datas.roadKappa0 = 0; % road curvature -- transversal plane (xy)
    datas.roadVu0 = 0; % road curvature -- sagittal plane (xz)
    datas.roadSigmaS0 = 0; % 
    datas.roadW = 0; % [m] path width 

    datas.roadTheta0 = 0; % path heading 
    datas.roadBeta0 = 0; % path slope 
    datas.roadSigma0 = 0; % path banking 

    %% ICs for all the states

    x0 = 0; % [m] initial x-coordinate of the vehicle CoM
    y0 = 0; % [m] initial y-coordinate of the vehicle CoM
    z0 = 0;  % [m] initial z-coordinate of the vehicle CoM 

    s0  = 0; % [m] length of the curve 
    n0 = 0; % [m] lateral coordinate 
    alpha0 = 0; % [rad] yaw angle 

    u0 = 0; % [m/s] initial x-axis velocity 
    v0 = 0; % [m/s] initial y-axis velocity
    w0 = 0; % [m/s] initial z-axis velocity

    omegaX0 = 0; % [rad/s] x-axis angular speed 
    omegaY0 = 0; % [rad/s] y-axis angular speed 
    omegaZ0= 0; % [rad/s] z-axis angular speed

    Nr0 = 0; % [N] vertical rear tire force
    Nf0 = 0; % [N] vertical front tire force

    S0 = 0; % [N] longitudinal tire force 
    delta0 = 0; % [rad] initial steering angle 
    
    pedal0 = 0; % [-] initial value for the throttle/brake pedal  --> [-1;1]
    
    cond= [x0, y0, z0, s0, n0, alpha0, u0, v0, w0, omegaX0, omegaY0, omegaZ0, Nr0, Nf0, S0, delta0, pedal0];
       
end
