% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = preheaterAtoL(n,f1,f2,f3,f4,comp,nr)
    if isempty(comp(nr).name)
        comp(nr).name = "Preheater "+nr;
    end
    
%     n = setflowname(n,f1,f2,f3,f4);
    
%     n = setflowname(n,f1,f2);
%     n = setflowname(n,f3,f4);
    if isempty(n(f1).p)
        error("The pressure is missing from input stream 1.");
    end
    if isempty(n(f1).t)
        error("The temperature is missing from input stream 1.");
    end
    
    assert(~isempty(n(f2).t),"The temperature is missing from output stream 2.");
    
    n(f2).p = n(f1).p;
    n(f4).p = n(f3).p;
    
    n(f2).m = n(f1).m;
    n(f4).m = n(f3).m;
    
%     n(f4).t = n(f1).t;
%     n(f2).t = n(f3).t;
%     n(f2).h = XAir('h_t',n(f2).t);
    
%     It might be necessary to make n2 as well, and declare
%     n2 = n;
    
    comp2 = struct('name',{},'ef',1,'win',{},'wout',{},'qin',{},'qout',{},'P',{});
    [~,comp2,defflow,defcomp] = defaultSettings;
    comp2 = setdefcomp(comp2,defcomp,2);
    [n,comp2] = heatextrAir(n,f1,f2,comp2,1,0);
    comp2(2).P = comp2(1).P;
    [n,comp2] = boiler(n,f3,f4,comp2,2,0);
    
%     comp(nr).qout = n(f1).h-n(f2).h;
%     comp(nr).
%     comp(nr).qin = comp(nr).qout;
    
    
    
    
%     n(f4).h = XSteam('h_pt',n(f4).p,n(f4).t);
    
    
    % Don't do it like this. It costs too much time. Model the power
    % transfer between the flows without a boiler.
    
%     [n,comp2] = heatextrAir(n,f1,f2,comp2,1);
%     comp(nr).P = comp2(1).P;
%     [n,comp] = boiler(n,f3,f4,comp,nr);
    
end