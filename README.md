# components
A set of functions to calculate the properties of outgoing flows from components.  
Available components are pumps, boilers, steam turbines, condensers, compressors and gas turbines.
To use the functions for compressors and gas turbines you need to download [XAir](https://github.com/jojojona372/XAir) as well.

Inputs should be structure arrays, for example:
```
n(1).t = 45.8075;  % °C
n(1).p = 0.1;      % bar
n(1).h = 191.8123; % kJ/kg
```

The function will try to calculate the properties of the outgoing flow from the properties of the ingoing flow and the properties of the component.  
It will output the updated array of flow properties and the updated array of components.  

An example of modelling a pump:  
```
%% Example for using component functions to simulate a pump
% Date: 13/03/2022
% Author: Jona van der Pal

clear
clc

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

% This is the line that calculates the properties of the flow that comes
% from the pump.
% n is the structure that contains the flows.
% 1,2,3 are the numbers of the ingoing, isentropic, and
% outgoing flow in that order.
% comp is the structure that contains the components
% The last 1 is the component number of the pump
[n,comp] = pump(n,1,2,3,comp,1);

% This open the variable window so you can see all the properties that have
% been calculated.
open n

disp("Pump work output: "+comp(1).wout+" kJ/kg.")
disp(sprintf("As you can see, the work output is negative.\nThis is because it is a pump, so it requires a work input.")) %#ok<DSPS>
```
