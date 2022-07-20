clc
clear all
close all
%%  data extraction 


dbName = 'T6_empiric_data.db';
dbPath = 'C:\Users\M. Tilocca\Desktop';


ltz = 0;
angleUnit = 'rad';

data = Param_SF(dbName, dbPath, angleUnit);
data1 = Param_odometer(dbName, dbPath,  angleUnit);

writematrix(data, 'Sensor_Fusion_NON_RESAMPLED.csv');
writematrix(data1, 'Odometer_data.csv')

