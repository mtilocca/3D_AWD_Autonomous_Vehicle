function [TwF,TwR] = BrakeModel(reqBrakeTorqueF, reqBrakeTorqueR, omegaF ,omegaR)

    % ----------------------------------------------------------------
    %% Function purpose: compute braking torques at front wheels with brake model
    % ----------------------------------------------------------------

    max_brake_torque = 476*2;
    
    regularSignScale = 1;  % find this value 
    
    % Check that the braking torques have correctly been specified as
    % negative quantities. Otherwise, correct them by changing the sign
    if (reqBrakeTorqueF > 0)
        reqBrakeTorqueF = - reqBrakeTorqueF;
    end

    if (reqBrakeTorqueR > 0)
        reqBrakeTorqueR = - reqBrakeTorqueR;
    end
    
    
    % Check that the requested braking torque is lower than the one that
    % the hydraulic system can apply. 
    % Use regularized sign functions (sin(atan(.))) to make sure that the 
    % vehicle correctly stops at zero forward speed, to avoid that negative 
    % speed values could be reached during braking


    if (abs(reqBrakeTorqueF) < abs(max_brake_torque))

        TwF = reqBrakeTorqueF*sin(atan(omegaF/regularSignScale)); % check rear wheels 

    else

        TwF = -max_brake_torque*sin(atan(omegaF/regularSignScale));

    end


    if (abs(reqBrakeTorqueR) < abs(max_brake_torque))

        TwR = reqBrakeTorqueR*sin(atan(omegaR/regularSignScale));

    else

        TwR= -max_brake_torque*sin(atan(omegaR/regularSignScale));

    end



end

