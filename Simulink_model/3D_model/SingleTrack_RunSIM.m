clc;
clear all; 
%% Initialization

Initialization;
%% Define initial conditions for the simulation & load constats of the vehicle and path 
% ----------------------------
X0 = IConditions(); 

%% Simulation parameters

    t0 = 0;     % [s] starting time
    step_size = 0.001; % [s] discrete solver step
    tf = 20;    % [s] stop simulation time
         

%% Start Simulation

fprintf('Simulation Started: \n')
tic;
model_sim = sim('SingleTrack');
total_time_simulation = toc;
fprintf('Simulation completed in: %.3f [s]\n', total_time_simulation )

%% Post-Processing

dataAnalysis(model_sim,vehicle_data,Tf); 
