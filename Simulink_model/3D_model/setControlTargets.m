classdef (StrictDefaults)setControlTargets < matlab.System & matlab.system.mixin.Propagates
    
    %% Public, tunable properties
    properties
        purePursuit_lookAhead   = 0;
        %refRoute_points         = 0;
        %Lf                      = 0;
    end

    %% Private properties
    properties(Access = private)
        % Initialize a clothoid list for the vehicle route 
        vehRoute = load('path.mat');
     
    end

    %% Methods
   methods  (Access = protected)
        
    %% setupImpl - used for initialization
    function setupImpl(obj)
        % Build the clothoid list for the vehicle route 
        numOfClothoids_route = size(obj.refRoute_points,1);
        for i = 1:numOfClothoids_route-1
            obj.vehRoute.push_back_G1(obj.refRoute_points(i,1),obj.refRoute_points(i,2),obj.refRoute_points(i,3), obj.refRoute_points(i+1,1),obj.refRoute_points(i+1,2),obj.refRoute_points(i+1,3)); 
        end
        obj.length_vehRoute = obj.vehRoute.length;
    end

    %% stepImpl - called at each time step

    function [targetPoint_latControl,speed_req,endOfCircuit] = stepImpl(obj,vehPose)
        x_vehCoM = vehPose(1);  % Current vehicle CoM x coord [m]
        y_vehCoM = vehPose(2);  % Current vehicle CoM y coord [m]
        theta_vehCoM = vehPose(3);  % Current vehicle attitude [rad]
      
            % Use pure pursuit arc path following
            % Curvilinear coord of the point belonging to the road middle line
            % that is closest w.r.t. the current vehicle position
            [~,~,s_closest,~,~,~] = obj.vehRoute.closestPoint(x_vehCoM,y_vehCoM);
                curvAbscissa_lookAhead = s_closest+obj.purePursuit_lookAhead;
          
            if (curvAbscissa_lookAhead>obj.length_vehRoute)
                curvAbscissa_lookAhead = obj.length_vehRoute;
            end
            [x_lookAhead,y_lookAhead,theta_lookAhead,curv_lookAhead] = obj.vehRoute.evaluate(curvAbscissa_lookAhead);
            targetPoint_latControl = [x_lookAhead,y_lookAhead,theta_lookAhead,curv_lookAhead];
       
            
        
        % desired vehicle speed [m/s]
        speed_req = 15/3.6;  
%         if (x_vehCoM>=obj.x_parkLot && y_vehCoM>obj.y_lowBound_parkLot && y_vehCoM<obj.y_uppBound_parkLot)   % (s_closest >= obj.vehRoute.length-10)
%             speed_req = 0.1;  % brake when reaching the parking lot
%             endOfCircuit = 1; % flag to indicate whether the end of the circuit has been reached or not
%         else
            endOfCircuit = 0;
%         end
    end


    %%
    function [sz_1,sz_2,sz_3] = getOutputSizeImpl(~) 
        sz_1 = [1 4];
        sz_2 = [1];
        sz_3 = [1];
    end

    function [fz1,fz2,fz3] = isOutputFixedSizeImpl(~)
        fz1 = true;
        fz2 = true;
        fz3 = true;
    end

    function [dt1,dt2,dt3] = getOutputDataTypeImpl(~)
        dt1 = 'double';
        dt2 = 'double';
        dt3 = 'double';
    end

    function [cp1,cp2,cp3] = isOutputComplexImpl(~)
        cp1 = false;
        cp2 = false;
        cp3 = false;
    end
        
    end
end
