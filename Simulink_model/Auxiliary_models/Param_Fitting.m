function data = Param_Fitting(dbName, dbPath, startTimeSerDate, endTimeSerDate, ltz, angleUnit)
%PILOTYAWCOGTIMESERIES IPESSA Pilot plot of yaw and COG.
% 
% Usage:
%   pilotCogSogTimeseries(dbName, dbPath)
%   pilotCogSogTimeseries(dbName, dbPath, startTimeSerDate)
%   pilotCogSogTimeseries(dbName, dbPath, startTimeSerDate, endTimeSerDate)
%   pilotCogSogTimeseries(dbName, dbPath, startTimeSerDate, endTimeSerDate, ltz)
%   pilotCogSogTimeseries(dbName, dbPath, startTimeSerDate, endTimeSerDate, ltz, angleUnit)
%
% Inputs:
%   dbName  
%     Name of the .db file
%   dbPath  
%     Path of the .db file (absolute or relative to current Matlab working 
%     directory)
%   startTimeSerDate
%   endTimeSerDate
%     Start and end times of the data to be plotted. Given as Matlab serial
%     dates. If both or either one is left out, all data or all data from or
%     to the specified date is plotted. Depending on the value of ltz, given
%     either in UTC or local time.
%   ltz     
%     Local time zone offset in hours with respect to UTC. Optional, 
%     default 0. If nonzero, start and end times are assumed to be given in
%     local time zone.
%   angleUnit
%     Angle unit to be used in the plot, either 'rad' (default) or 'deg'.

% Check arguments
dbPath = checkDbPath(dbPath);

if nargin < 3 || isempty(startTimeSerDate)
    startTimeSerDate = datenum(2021, 1, 1, 0, 0, 0);
end

if nargin < 4
    endTimeSerDate = [];
end

if nargin < 5 || isempty(ltz)
    ltz = 0;
end

coeff = 1;
unitStr = 'rad';
if nargin == 6 
    switch angleUnit
        case 'deg'
            coeff = rad2deg(1);
            unitStr = 'deg';
        case 'rad'
        otherwise
            error('Unknown angleUnit.');
    end
end

% Get data
mksqlite('open', [dbPath dbName]);
mksqlite('result_type', 1);
result2 = mksqlite('SELECT name FROM sqlite_master WHERE type=''table'' AND name=''rtkgnssdata''');
result3 = mksqlite('SELECT name FROM sqlite_master WHERE type=''table'' AND name=''odometerdata''');
result4 = mksqlite('SELECT name FROM sqlite_master WHERE type=''table'' AND name=''sensorfusiondata''');
mksqlite('close');

if isempty(result2.name)
    % No data in DB
    close;
    return;
end

if isempty(result3.name)
    % No data in DB
    close;
    return;
end

if isempty(result4.name)
    % No data in DB
    close;
    return;
end


[startIdRTK, endIdRTK] = getStartAndEndIds(dbName, dbPath, 'rtkgnssdata', startTimeSerDate, endTimeSerDate, ltz);
[startOdom, endOdom] = getStartAndEndIds(dbName, dbPath, 'odometerdata', startTimeSerDate, endTimeSerDate, ltz);
[startSensorFusion, endSensorFusion] = getStartAndEndIds(dbName, dbPath, 'sensorfusiondata', startTimeSerDate, endTimeSerDate, ltz);

mksqlite('open', [dbPath dbName]);
mksqlite('result_type', 1);
rtkGNSSResult = mksqlite(['SELECT Date, Time, COG, SOG, Latitude, Longitude, Height FROM rtkgnssdata WHERE COG IS NOT NULL AND SOG IS NOT NULL  and Latitude IS NOT NULL AND Longitude IS NOT NULL AND Height IS NOT NULL AND id >=' num2str(startIdRTK) ' AND id <=' num2str(endIdRTK)]);
odomresult = mksqlite(['SELECT Date, Time, SteeringAngleFront FROM odometerdata WHERE SteeringAngleFront IS NOT NULL  AND id >=' num2str(startOdom) ' AND id <=' num2str(endOdom)]);
SensorFusionResult =  mksqlite(['SELECT Date, Time, Yaw, Pitch, Roll FROM sensorfusiondata WHERE Yaw IS NOT NULL  AND  Pitch IS NOT NULL AND  Roll IS NOT NULL AND  id >=' num2str(startSensorFusion) ' AND id <=' num2str(endSensorFusion)]); 

mksqlite('close');



data = [sqliteTime2datenum(rtkGNSSResult, ltz), coeff * rtkGNSSResult.Cog, rtkGNSSResult.Sog, odomresult.SteeringAngleFront, SensorFusionResult.Yaw, SensorFusionResult.Pitch, SensorFusionResult.Roll, rtkGNSSResult.Latitude, rtkGNSSResult.Longitude, rtkGNSSResult.Height, sqliteTime2datenum(odomresult, ltz), sqliteTime2datenum(SensorFusionResult, ltz)]; 
end 
