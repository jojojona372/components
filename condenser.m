% Author: Jona van der Pal
% Date: 13/03/2022

function [h,qout] = condenser(in1,in2)
    if (isfield(in1,'p')&&isfield(in2,'p'))&&in1.p~=in2.p
        error("The inlet pressure is not equal to the outlet pressure!")
    end
    if isfield(in1,'p')
        h = XSteam('hV_p',in1.p);
    elseif isfield(in2,'p')
        h = XSteam('hV_p',in2.p);
    elseif isfield(in2,'t')
        h = XSteam('hV_t',in2.t);
    else
        error("Please enter the pressure or the temperature of the outgoing flow.")
    end
    if isnan(h)
        error("The enthalpy of the outgoing stream is NaN. Please calculate the enthalpy of the ingoing stream before calling this function.");
    end
    qout = n1.h-h;
end