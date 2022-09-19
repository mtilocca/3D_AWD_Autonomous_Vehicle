clc
close all
clear all

%% 1-D straight road 

% no heading, no banking, no slope 
% following A-B line in completely flat terrain

scenario = drivingScenario;

roadCenters = [0 0; 50 0];
roadWidth = 6;

road(scenario, roadCenters, roadWidth);

%figure(1)
plot(scenario,'RoadCenters','on','Centerline','on');

%% 2-D driving scenario 

% flat terrain , heading is included 

scenario1 = drivingScenario;

roadCenters1 = [0 0; 10 0; 53 -20];
roadWidth1 = 6;


road(scenario1, roadCenters1, roadWidth1,'lanes',lanespec(1));
%figure(2)
plot(scenario1,'RoadCenters','on');

%% 3-D driving scenario 

scenario2 = drivingScenario;
roadCenters2 = [ 0 0 0
               25 0 3
               50 0 0];

road(scenario2, roadCenters2, 'lanes',lanespec([1]));

%figure(3)
plot(scenario2,'RoadCenters','on');
view(30,24)


%% 3-D driving scenario 

% banking angle 

scenario3 = drivingScenario;

% transpose waypoints so they visually align with bank angles below
roadCenters3 = ...
    [  0  40  49  50 100  50  49 40 -40 -49 -50 -100  -50  -49  -40    0
     -50 -50 -50 -50   0  50  50 50  50  50  50    0  -50  -50  -50  -50
       0   0 .45 .45 .45 .45 .45  0   0 .45 .45  .45  .45  .45    0    0]';
bankAngles = ...
    [  0   0   9   9   9   9   9  0   0   9   9    9    9    9    0    0];

road(scenario3, roadCenters3, bankAngles, 'lanes', lanespec(1));
plot(scenario3,'RoadCenters','on');
view(-60,20)


