% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp] = steamturbine(n,f1,f2s,f2,comp,nr)
    %% This checks if the outgoing flow already has a pressure.
    % If f2s has a pressure value but f2 does not.
    if isfield(n(f2s),'p')&&~isempty(n(f2s).p)&&(~isfield(n(f2),'p')||isempty(n(f2).p))
        n(f2).p = n(f2s).p;
    % If f2 has a pressure value but f2s does not.
    elseif isfield(n(f2),'p')&&~isempty(n(f2).p)&&(~isfield(n(f2s),'p')||isempty(n(f2s).p))
        n(f2s).p = n(f2).p;
    else
        error("Please declare the pressure of the outgoing flow before calling this function.");
    end
    if n(f2).p~=n(f2s).p
        error("System is overdeterminate: The pressure of the isentropic outgoing flow is not the same as the pressure of the normal outgoing flow.")
    end
    %% 
    if ~isfield(n(f1),'h')||isempty(n(f1).h)
        if isfield(n(f1),'t')&&~isempty(n(f1).t)&&isfield(n(f1),'p')&&~isempty(n(f1).p)
            n(f1).h = XSteam('h_pt',n(f1).p,n(f1).t);
        elseif isfield(n(f1),'p')&&~isempty(n(f1).p)&&isfield(n(f1),'s')&&~isempty(n(f1).s)
            n(f1).h = XSteam('h_ps',n(f1).p,n(f1).s);
        else
            error("System is underdeterminate: The enthalpy is missing from the ingoing flow, and cannot be determined from the other flow properties.");
        end
    end
    if ~isfield(n(f1),'s')||isempty(n(f1).s)
        n(f1).s = XSteam('s_ph',n(f1).p,n(f1).h);
    end
    n(f2s).s = n(f1).s;
    n(f2s).h = XSteam('h_ps',n(f2).p,n(f2s).s);
    n(f2).h = n(f1).h-(comp(nr).ef*(n(f1).h-n(f2s).h));
    if isnan(n(f2).h)
        error("The enthalpy of the outgoing stream is NaN. Please calculate the enthalpy of the ingoing stream before calling this function.");
    end
    n(f2).s = XSteam('s_ph',n(f2).p,n(f2).h);
    n(f2).t = XSteam('t_ph',n(f2).p,n(f2).h);
    % Calculating the work output
    comp(nr).wout = n(f1).h-n(f2).h;
    % The work "input" is equal to ws = h2s-h1, which is equal to the work
    % output divided by the isentropic efficiency.
    comp(nr).win = -comp(nr).wout/comp(nr).ef; %= n(f2s).h-n(f1).h;
    % Calculating the quality of the mixture at the turbine exit
    n(f2s).x = XSteam('x_ph',n(f2s).p,n(f2s).h);
    n(f2).x = XSteam('x_ph',n(f2).p,n(f2).h);
end