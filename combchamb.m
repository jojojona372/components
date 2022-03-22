% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = combchamb(n,f1,f2,comp,nr)
    n = setflowname(n,f1,f2);
    if isempty(comp(nr).name)
        comp(nr).name = "Combustion chamber "+nr;
    end
    if isempty(n(f1).p)
        error("The pressure is missing from the input stream.");
    end
    if isempty(n(f1).t)
        warning("The temperature is missing from the input stream.");
    end
    
    n(f1).h = XAir('h_t',n(f1).t);
    n(f1).s = XAir('s_ph',n(f1).p,n(f1).h);
    
    n(f2).p = n(f1).p;
    
    if ~isempty(n(f1).m)
        n(f2).m = n(f1).m;
    end
    
    if isempty(comp(nr).qin)
        if isempty(n(f2).t)
            error("The temperature is missing from the output stream.");
        end
        n(f2).h = XAir('h_t',n(f2).t);
        if isnan(n(f2).h)
            warning("The enthalpy of the outgoing stream is NaN. Check if your input and output values are correct.");
        end
        comp(nr).qout = n(f1).h-n(f2).h;
        comp(nr).qin = -comp(nr).qout/comp(nr).ef;
    else
        comp(nr).qout = -comp(nr).qin*comp(nr).ef;
        n(f2).h = n(f1).h-comp(nr).qout;
        n(f2).t = XAir('t_h',n(f2).h);
    end
    n(f2).s = XAir('s_ph',n(f2).p,n(f2).h);
end