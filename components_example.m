%% Example for using component functions to simulate a pump
% Date: 13/03/2022
% Author: Jona van der Pal

clear
clc

[n,comp,defflow,defcomp] = defaultSettings;

% Flow names are not required, they are just here to make it easier to
% understand.

n(1).name = 'Flow 1';
n(2).name = 'Flow 2s';
n(3).name = 'Flow 2';

comp(1).name = "Pump 1";
comp(1).ef = 0.80;  % Isentropic efficiency

% The input pressure is 0.1 bar
n(1).p = 0.1;   % bar
n(1).t = 20;    % °C
n(1).h = XSteam('h_pt',n(1).p,n(1).t);
n(1).s = XSteam('s_ph',n(1).p,n(1).h);

% The output pressure is 10 bar
n(3).p = 10;    % bar

% These two lines set defaults for all components and flows, to ensure that
% all necessary fields exist. This (hopefully) prevents errors from occurring.
n = setdefflow(n,defflow,3);
comp = setdefcomp(comp,defcomp,1);

% This is the line that calculates the properties of the flow that comes
% from the pump.
% n is the structure that contains the flows.
% 1,2,3 are the numbers of the ingoing, isentropic, and
% outgoing flow in that order.
% comp is the structure that contains the components
% The 1 after comp is the component number of the pump
[n,comp] = pump(n,1,2,3,comp,1);

% This opens the variable window so you can see all the properties that have
% been calculated.
open n

disp("Pump work output: "+comp(1).wout+" kJ/kg.")
disp(sprintf("As you can see, the work output is negative.\nThis is because it is a pump, so it requires a work input.")) %#ok<DSPS>