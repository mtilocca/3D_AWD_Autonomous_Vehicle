%% Initialization
clc
clear all;
close all;

addpath(genpath('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model')); % -- to be used when expanding the model 

%% Open Simulink model

% 
% Open the model unless it is already opened 
%
openModels = find_system('SearchDepth', 0);
if (isempty(find(strcmp(openModels,'SingleTrack'),1)))
    load_system('SingleTrack');
    open_system('SingleTrack');
end 

