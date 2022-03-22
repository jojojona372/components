% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = heatextrAir(n,f1,f2,comp,nr,setname)
    if isempty(setname)
        setname = 1;
    end
    if setname
        n = setflowname(n,f1,f2);
    end
    if isempty(comp(nr).name)
        comp(nr).name = "Heat extractor "+nr;
    end
    % TODO change all this stuf to assert()
    if isempty(n(f1).p)
        error("The pressure is missing from the input stream.");
    end
    if isempty(n(f1).t)
        warning("The temperature is missing from the input stream.");
    end
    if isempty(n(f2).t)
        error("The temperature is missing from the output stream.");
    end
    
    n(f1).h = XAir('h_t',n(f1).t);
    n(f1).s = XAir('s_ph',n(f1).p,n(f1).h);
    n(f2).p = n(f1).p;
    
    n(f2).h = XAir('h_t',n(f2).t);
    if isnan(n(f2).h)
        warning("The enthalpy of the outgoing stream is NaN. Check if your input and output values are correct.");
    end
    comp(nr).qout = n(f1).h-n(f2).h;
    comp(nr).qin = -comp(nr).qout;
%     comp(nr).qin = -comp(nr).qout/comp(nr).ef;
    
    % Thermal power in/output in kW. Always positive.
    comp(nr).P = comp(nr).qout*n(f1).m;
    n(f2).s = XAir('s_ph',n(f2).p,n(f2).h);
end