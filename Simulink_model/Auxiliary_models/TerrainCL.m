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