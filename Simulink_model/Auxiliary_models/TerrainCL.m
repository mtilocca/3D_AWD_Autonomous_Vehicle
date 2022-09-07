classdef TerrainCL

    properties
        T % Length of simulation
        dT 
        Tdt 
   
    end 

    methods 

        function obj = TerrainCL(T, step) % init function 

            obj.T = T;
            obj.dT = step;
            obj.Tdt = [0:obj.dT:obj.T];
            
        end 
        
        function road2D = TwDTrj(obj, saved, a, b, c, d)

            fx = @(t) a*pi.*t.^b + c*sin(t) + d*cos(t) + sin(t); % heading 
           
            roadD = fx(obj.Tdt); 

            figure(1)
            plot(roadD)
            grid on 
            xlabel('x-coordinates [m]');
            ylabel('y-coordinates [m]');
            title('2D road heading')

            if saved 
                road2D = roadD' ; 
            else
                road2D = 0; 
            end 


        end % end function 2D modeling 

        function [road3Dd, knt] = default3D(obj, saved)

            fx = @(t) 2*pi.*t.^2; % heading 
            fy = @(t) 0.4*sin(t); % slope 
            fz = @(t) 4*sin(t); % banking
            
            obj.Tdt = [0:obj.dT:obj.T];
            X = fx(obj.Tdt);
            Y = fy(obj.Tdt);
            Z = fz(obj.Tdt);


            fx_dot = @(t) 4*pi*t - sin(t);
            fx_dot_dot = @(t) 4*pi - cos(t); 

            fy_dot = @(t) (2*cos(t))/5 - sin(t);
            fy_dot_dot =@(t) - cos(t) - (2*sin(t))/5; 


            fz_dot = @(t) 4*cos(t);
            fz_dot_dot = @(t) -4*sin(t); 



            kappa = @(t) -4*sin(t);

            ni = @(t) 4*sin(t).*(sin(t) - 4*pi*t) - (2*sin(t))/5 - cos(t);

            tau = @(t) 4*pi - cos(t) + 4*sin(t).*((2*cos(t))/5 - sin(t)); 


            Kppa = kappa(obj.Tdt); 
            Nni = ni(obj.Tdt);
            Ttau = tau(obj.Tdt); 


            figure(2)
%plot3(X,Z,Y, "ko")

%hold on
plot3(X,Z,Y, "r")
grid on
grid minor
zlim([0 15])
xlabel({'heading','(x-axis)'})
ylabel({'banking','(z-axis)'})
zlabel({'slope','(y-axis)'})
title('paramteric trajectory modeling')
            if saved 
                road3Dd = [X' ,  Y' , Z'];
                knt = [Kppa' , Nni' , Ttau']; 
            end 

        end 


        function road3D = TrDTrj(obj, saved, a, b, c, d, e , f, g, h)

            road3D = 0; 
            fx = @(t) a*pi.*t.^b + c*sin(t) + d*cos(t) + sin(t); % heading 
            fy = @(t) e*sin(t) +f + cos(t); % slope 
            fz = @(t) g*sin(t)+h; % banking

            X = fx(obj.Tdt);
            Y = fy(obj.Tdt);
            Z = fz(obj.Tdt); 

            figure(2);
            plot3(X,Z,Y, "r")
            grid on
            grid minor
            zlim([0 15])
            xlabel({'heading','(x-axis)'})
            ylabel({'banking','(z-axis)'})
            zlabel({'slope','(y-axis)'})
            title('paramteric trajectory modeling')

            if saved 
                road3D = [X' ,  Y' , Z'];
            end 
                        end  % end 3 D modeling
    
    end % end methods 
end % end class 