%% Initialization
clc
clear all;
close all;

%addpath(genpath('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model')); % -- to be used when expanding the model 
addpath(genpath('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model/Tyres'));
addpath(genpath('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model/set_up'));
addpath(genpath('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model/Acc_Brake'));
%% Open Simulink model

% 
% Open the model unless it is already opened 
%
openModels = find_system('SearchDepth', 0);
if (isempty(find(strcmp(openModels,'SingleTrack'),1)))
    load_system('SingleTrack');
    open_system('SingleTrack');
end 

