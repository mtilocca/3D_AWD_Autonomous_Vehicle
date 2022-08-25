clc
clear all 
close all
%% 

Terr = TerrainCL(5, 0.05); 

road = Terr.TwDTrj(true, 0.06, 3.8, 15, 3); 

road3D = Terr.TrDTrj(true, 0.06, 3.8, 15, 3, 0.4, 1, 4, 2);
