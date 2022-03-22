% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = gasturbine(n,f1,f2s,f2,comp,nr)
    n = setflowname(n,f1,f2s,f2);
    
    if isempty(comp(nr).name)
        comp(nr).name = "Gas turbine "+nr;
    end
    
    n(f2s).p = n(f2).p;
    
    if ~isempty(n(f1).m)
        n(f2).m = n(f1).m;
        n(f2s).m = n(f2).m;
    end
    
    if isempty(n(f1).h)
        if ~isempty(n(f1).t)
            n(f1).h = XAir('h_t',n(f1).t);
        elseif ~isempty(n(f1).p)&&~isempty(n(f1).s)
            n(f1).h = XAir('h_ps',n(f1).p,n(f1),s);
        else
            error("System is underdeterminate: The enthalpy is missing from the ingoing flow, and cannot be determined from the other flow properties.");
        end
    end
    if isempty(n(f1).s)
        n(f1).s = XAir('s_ph',n(f1).p,n(f1).h);
    end
    n(f2s).s = n(f1).s;
    n(f2s).h = XAir('h_ps',n(f2s).p,n(f2s).s);
    n(f2).h = n(f1).h-(comp(nr).ef*(n(f1).h-n(f2s).h));
    if isnan(n(f2).h)
        error("The enthalpy of the outgoing stream is NaN. Please calculate the enthalpy of the ingoing stream before calling this function.");
    end
    n(f2).s = XAir('s_ph',n(f2).p,n(f2).h);
    n(f2).t = XAir('t_h',n(f2).h);
    % Calculating the work output
    comp(nr).wout = n(f1).h-n(f2).h;
    comp(nr).win = n(f2s).h-n(f1).h;
end