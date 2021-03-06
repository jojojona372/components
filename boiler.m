% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = boiler(n,f1,f2,comp,nr,setname)
    if isempty(setname)
        setname = 1;
    end
    if setname
        n = setflowname(n,f1,f2);
    end
    if isempty(comp(nr).name)
        comp(nr).name = "Boiler "+nr;
    end
    if isempty(n(f1).p)
        error("The pressure is missing from the input stream.");
    end
    if isempty(n(f1).t)
        warning("The temperature is missing from the input stream.");
    end
    
    n(f1).h = XSteam('h_pt',n(f1).p,n(f1).t);
    n(f1).s = XSteam('s_ph',n(f1).p,n(f1).h);
    
    n(f2).p = n(f1).p;
    
    if ~isempty(n(f1).m)
        n(f2).m = n(f1).m;
    end
    
    if isempty(comp(nr).P)
        if isempty(n(f2).t)
            error("The temperature is missing from the output stream.");
        end
        n(f2).h = XSteam('h_pt',n(f2).p,n(f2).t);
        if isnan(n(f2).h)
            warning("The enthalpy of the outgoing stream is NaN. Check if your input and output values are correct.");
        end
        comp(nr).qout = n(f1).h-n(f2).h;
        comp(nr).qin = -comp(nr).qout/comp(nr).ef;
    else
        assert(~(~isempty(comp(nr).P)&&~isempty(comp(nr).qin)),"Power input is missing.")
        if isempty(comp(nr).qin)
            comp(nr).qin = comp(nr).P/n(f1).m;
        end
        comp(nr).qout = -comp(nr).qin*comp(nr).ef;
        n(f2).h = n(f1).h-comp(nr).qout;
        n(f2).t = XSteam('t_ph',n(f2).p,n(f2).h);
    end
    n(f2).s = XSteam('s_ph',n(f2).p,n(f2).h);
end