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
        vehRoute = load('/Users/mariotilocca/Desktop/Thesis/Simulink_model/3D_model/set_up/pathTerrain.mat');
     
    end

    %% Methods
   methods  (Access = protected)
        
    %% setupImpl - used for initialization
    function setupImpl(obj)
        % Build the clothoid list for the vehicle route 

       % pathTerrain = [xBC yBC zBC thetaBC sigmaBC betaBC kappa ni tau sBC]; 

        obj.X = obj.vehRoute.pathTerrain(:,1);
        obj.Y = obj.vehRoute.pathTerrain(:,2);
        obj.Z = obj.vehRoute.pathTerrain(:,3);

        obj.theta = obj.vehRoute.pathTerrain(:,4);
        obj.sigma = obj.vehRoute.pathTerrain(:,5);
        obj.beta = obj.vehRoute.pathTerrain(:,6);

        obj.kappa = obj.vehRoute.pathTerrain(:,7);
        obj.ni = obj.vehRoute.pathTerrain(:,8);
        obj.tau = obj.vehRoute.pathTerrain(:,9); 
        obj.S = obj.vehRoute.pathTerrain(:,10);
        obj.length_vehRoute = obj.S(end,1);


        %         numOfClothoids_route = size(obj.refRoute_points,1);
%         for i = 1:numOfClothoids_route-1
%             obj.vehRoute.push_back_G1(obj.refRoute_points(i,1),obj.refRoute_points(i,2),obj.refRoute_points(i,3), obj.refRoute_points(i+1,1),obj.refRoute_points(i+1,2),obj.refRoute_points(i+1,3)); 
%         end
%         obj.length_vehRoute = obj.vehRoute.length;
    end

    %% stepImpl - called at each time step

    function [targetPoint_latControl, speed_req, endOfCircuit] = stepImpl(obj,vehPose)
        x_vehCoM = vehPose(1);  % Current vehicle CoM x coord [m]
        y_vehCoM = vehPose(2);  % Current vehicle CoM y coord [m]
        z_vehCoM = vehPose(3); % Current vehicle CoM z coord [m]
        theta_vehCoM = vehPose(4);  % Current vehicle attitude [rad]
        sigma_vehCoM  = vehPose(5);
        beta_vehCoM = vehPose(6);
      

        j = length(obj.X); 

        distances = zeros(j,1); 
        targetPoint_latControl = zeros(10,1);

        % calculate vehicle distance w.r.t each path point 

        for i=1:j
      
            x_diff = (x_vehCoM - obj.X(i,1))^2 ; 
            y_diff = (y_vehCoM - obj.Y(i,1))^2 ; 
            z_diff = (z_vehCoM - obj.Z(i,1))^2;

            distances(i,1) = sqrt(x_diff + y_diff + z_diff); 
        end 


        %minDiff = min(distances(:,1)); 

        indexP = find(distances == min(distances(:,1))); 

            % Use pure pursuit arc path following
            % Curvilinear coord of the point belonging to the road middle line
            % that is closest w.r.t. the current vehicle position
%             [~,~,s_closest,~,~,~] = obj.vehRoute.closestPoint(x_vehCoM,y_vehCoM);
                s_closest = obj.S(indexP,1);

                curvAbscissa_lookAhead = s_closest+obj.purePursuit_lookAhead;  % route closest point length value + lookahead 
          
            if (curvAbscissa_lookAhead > obj.length_vehRoute)  % if end of circuit point then last S -- control targets 
                curvAbscissa_lookAhead = obj.length_vehRoute;
            end
              
            curvAbscissa_lookAhead = round(curvAbscissa_lookAhead, 1, 'decimals');  
            
            indexTgP = find(obj.S == curvAbscissa_lookAhead);   % if we cannot find exact number ? -- we need to round it -- ** Possible problem 


            x_lookAhead = obj.X(indexTgP,1); 
            y_lookAhead = obj.Y(indexTgP,1); 
            z_lookAhead = obj.Z(indexTgP,1); 


            theta_lookAhead = obj.theta(indexTgP,1); 
            sigma_lookAhead = obj.sigma(indexTgP,1); 
            beta_lookAhead = obj.beta(indexTgP,1); 

            kappa_lookAhead = obj.kappa(indexTgP,1); 
            ni_lookAhead = obj.ni(indexTgP,1); 
            tau_lookAhead = obj.tau(indexTgP,1); 
            
            
            
            
            
            % maybe theta, sigma, beta, kappa, ni tau not from lookahread
            % point but where they are ? -- possible hint 
            
            targetPoint_latControl(1) = x_lookAhead; 
            targetPoint_latControl(2) = y_lookAhead; 
            targetPoint_latControl(3) = z_lookAhead; 
            targetPoint_latControl(4) = theta_lookAhead; 
            targetPoint_latControl(5) = sigma_lookAhead; 
            targetPoint_latControl(6) = beta_lookAhead; 
            targetPoint_latControl(7) = kappa_lookAhead; 
            targetPoint_latControl(8) = ni_lookAhead; 
            targetPoint_latControl(9) = tau_lookAhead; 


            %[x_lookAhead,y_lookAhead,theta_lookAhead,curv_lookAhead] = obj.vehRoute.evaluate(curvAbscissa_lookAhead);

           % targetPoint_latControl = [x_lookAhead, y_lookAhead,
           % z_lookAhead, ...
           % theta_lookAhead, sigma_lookAhead, beta_lookAhead, ...
           % kappa_lookAhead, ni_lookAhead, tau_lookAhead];
       
            
        
        % desired vehicle speed [m/s]
        speed_req = 15/3.6;  

        endCicruitID = find(obj.S == obj.S(end,1)); 

        x_End = obj.X(endCicruitID,1);
        y_End = obj.Y(endCicruitID,1);
        z_End = obj.Z(endCicruitID,1);
        
        if (x_vehCoM>= x_End && y_vehCoM>= y_End && z_vehCoM >= z_End)   % (s_closest >= obj.vehRoute.length-10)
            speed_req = 0.1;  % brake when reaching the parking lot
            endOfCircuit = 1; % flag to indicate whether the end of the circuit has been reached or not
        else
            endOfCircuit = 0;
        end
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
