% Author: Jona van der Pal
% Date: 13/03/2022

function h = compressor(n1,n2,eff)
    if ~isfield(n2,'p')
        warning("Please declare the pressure of the outgoing flow before calling this function.");
    end
    if ~isfield(n1,'h')
        if isfield(n1,'t')
            n1.h = xa('h_t',n1.t);
        elseif isfield(n1,'p')&&isfield(n1,'s')
            n1.h = xa('h_ps',n1.p,n1,s);
        else
            error("The enthalpy and the temperature and/or the pressure and/or the entropy are missing from the input stream.");
        end
    end
    if ~isfield(n1,'s')
        n1.s = xa('s_ph',n1.p,n1.h);
    end
    n2s.s = n1.s;
    n2s.h = xs('h_ps',n2.p,n2s.s);
    h = (n2s.h-n1.h)/eff+n1.h;
    if isnan(h)
        error("The enthalpy of the outgoing stream is NaN. Please calculate the enthalpy of the ingoing stream before calling this function.");
    end
end