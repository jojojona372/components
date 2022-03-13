% Author: Jona van der Pal
% Date: 13/03/2022

function [h,qin] = boiler(n1,n2)
    if isfield(in2,'p')&&isfield(in1,'t')
        h = XSteam('h_pt',n2.p,n2.t);
    elseif isfield(in2,'p')&&isfield(in2,'s')
        h = XSteam('h_ps',n2.p,n2.s);
    else
        error("The temperature and/or the pressure and/or the entropy are missing from the output stream.");
    end
    if isnan(h)
        error("The enthalpy of the outgoing stream is NaN. Please calculate the enthalpy of the ingoing stream before calling this function.");
    end
    qin = h-n1.h;
end