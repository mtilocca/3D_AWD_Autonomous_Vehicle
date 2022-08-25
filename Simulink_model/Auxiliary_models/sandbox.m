clc 
clear all 
close all 
%% 

v = 44.2;


switch v

case v*(v > 0 & v < 10.1)
az =  9.7770; 

case v*(v>= 10.1 & v < 20.1 )
az =   9.7802;

case v*(v>= 20.1 & v < 30.1 )
az =  9.7881;

case v*(v>= 30.1 & v < 40.8)
az =  9.7957;

otherwise
az = 9.81; 
end

az 
v