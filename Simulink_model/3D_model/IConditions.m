function [cond, F0, pose0] = IConditions()

    % This script is used to define the initial conditions of the vehicle
    % and the model states 

    %% Load vehicle and Road data

    datas = getdatumStruct(); 

%     m  = datas.vehicleM; % vehicle mass
%     Lr = datas.vehicleLr; % Wheel base rear 
%     Lf = datas.vehicleLr;  % Wheel base front 
%     L  = Lf + Lr; % wheel base summed 
%     h = datas.vehicleH; % vehicle height 
%     Ixx = datas.vehicleIxx; % roll inertia
%     Iyy = datas.vehicleIyy; % pitch inertia
%     Izz = dats.vehicleIzz; % yaw inertia
%     Ixz = datas.vehicleIxz; % cross inertia
%     w = datas.vehicleW; % width
    %adC = datas.vehicleMu; % adherence coefficient 
    %Kr = datas.vehicleKr; % rear cornering slip
    %Kf = datas.vehicleKf; % front cornering slip 
    g  = 9.81; 
    

    %% defined in road scenario 


%     datas.roadS = 0; % length of the curve 
%     datas.roadKappa0 = 0; % road curvature -- transversal plane (xy)
%     datas.roadVu0 = 0; % road curvature -- sagittal plane (xz)
%     datas.roadSigmaS0 = 0; % 
%     datas.roadW = 0; % [m] path width 
% 
%     datas.roadTheta0 = 0; % path heading 
%     datas.roadBeta0 = 0; % path banking 
%     datas.roadSigma0 = 0; % path slope 

    %% ICs for all the states

    pathT = load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model/set_up/pathTerrain.mat'); 

    x0 = pathT.pathTerrain(1,1); % [m] initial x-coordinate of the vehicle CoM
    y0 = pathT.pathTerrain(1,2); % [m] initial y-coordinate of the vehicle CoM
    z0 = pathT.pathTerrain(1,3);  % [m] initial z-coordinate of the vehicle CoM 

    % pathTerrain = [xBC yBC zBC thetaBC sigmaBC betaBC kappa ni tau sBC]; 
    

    theta0 = pathT.pathTerrain(1,4);
    sigma0 = pathT.pathTerrain(1,5);
    beta0 = pathT.pathTerrain(1,6);

    s0  = pathT.pathTerrain(1,10); % [m] length of the curve 
    n0 = 0; % [m] lateral coordinate -- init error equal to 0 
    alpha0 = 0; % [rad] yaw angle 

    u0 = 15/3.6; % [m/s] initial x-axis velocity  -- cruise ctrl already activated to keep speed at that. 
    v0 = 0; % [m/s] initial y-axis velocity
    w0 = 0; % [m/s] initial z-axis velocity

    omegaX0 = 0; % [rad/s] x-axis angular speed 
    omegaY0 = 0; % [rad/s] y-axis angular speed 
    omegaZ0= 0; % [rad/s] z-axis angular speed

    a = datas.a;
    b = datas.b;

    Nr0 = datas.M * g * (b/(a+b)); % [N] vertical rear tire force
    Nf0 = datas.M * g * (a/(a+b));% [N] vertical front tire force

    S0 = 0; % [N] longitudinal tire force 
    delta0 = 0; % [rad] initial steering angle 
    
    pedal0 = 0; % [-] initial value for the throttle/brake pedal  --> [-1;1]

%     Fy0 = 0 ; % longitudinal force -- assume steady state velocity -- cruise control  


     diffVel =  u0 - ((u0 /100)*0.05); 
    omegaFront0 = diffVel / datas.Rwf;
    omegaRear0 = diffVel / datas.Rwr; 

    
    %cond= [x0, y0, z0, theta0, sigma0,  beta0, s0, n0, alpha0, u0, v0, w0, omegaX0, omegaY0, omegaZ0, Nr0, Nf0, S0, delta0, pedal0];
    cond = [x0, y0, z0, u0, v0, w0, beta0, sigma0, theta0, omegaX0, omegaY0, omegaZ0, pedal0, delta0, s0, n0, alpha0, omegaFront0, omegaRear0]; 

    pose0 = [x0, y0, z0, theta0, sigma0, beta0]; 

%     
% dX(1) = u_dot ;
% dX(2) = v_dot;
% dX(3) = w_dot;
% dX(4) = u;
% dX(5) = v;
% dX(6) = w;
% dX(7) = omegaX;
% dX(8) = omegaY;
% dX(9) = omegaZ;
% dX(10) = omegaXdot;
% dX(11) = omegaYdot;
% dX(12) = omegaZdot;
% dX(13) = ped_dot;
% dX(14) = delta_dot;
% dX(15) = s_dot;
% dX(16) = n_dot;
% dX(17) = alpha_dot; 
% dX(18) = omegaFront_dot;
% dX(19) = omegaRear_dot; 




    F0 = zeros(9,1);
    Fzf = datas.M * g *(datas.a/(datas.a+datas.b));
    Fzr = datas.M * g *(datas.b/(datas.b+datas.a));

    [Fx_new, Fy_new, Fz_new] = Brush_tyre_model(u0, v0, delta0, omegaZ0, omegaFront0, omegaRear0); 

    Fxf = Fx_new(1); % longitudinal tire forces at 0 -- or maybe not ? 
    Fxr = Fx_new(2); 

    TwF = 0;
    TwR = 0; 

    F0(1) = Fxf; %Fxf;
    F0(2) = Fxr; %Fxr;
    F0(3) = 0; %Fyf;
    F0(4) = 0; %Fyr;
    F0(5) = Fzf;
    F0(6) = Fzr;
    F0(7) = 0; % omegaX;
    F0(8) = TwF ;% TwF;
    F0(9) = TwR; %TwR; 

    % how to calculate vehicle pose in simulink ? ** important ** 
       
end

