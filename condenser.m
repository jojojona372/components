% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = condenser(n,f1,f2,comp,nr)
    if isempty(n(f1).p)
        error("The pressure is missing from the input stream.");
    end
    if isempty(n(f1).t)
        error("The temperature is missing from the input stream.");
    end
    
    n(f1).h = XSteam('h_pt',n(f1).p,n(f1).t);
    
    n(f2).p = n(f1).p;
    n(f2).t = XSteam('tsat_p',n(f2).p);
    n(f2).h = XSteam('hL_p',n(f2).p);
    n(f2).s = xs('sL_p',n(f2).p);
    n(f2).x = 0;
    
    comp(nr).qout = n(f1).h-n(f2).h;
    comp(nr).qin = -comp(nr).qout;
end