# components
A set of functions to calculate the enthalpy of outgoing flows from components.  
Available components are pumps, boilers, steam turbines, condensers, compressors and gas turbines.
To use the functions for compressors and gas turbines you need to download [XAir](https://github.com/jojojona372/XAir) as well.

Inputs should be structure arrays, for example:
```
n1.t = 45.8075;  % °C
n1.p = 0.1;      % bar
n1.h = 191.8123; % kJ/kg
```

The function will try to calculate the enthalpy from the properties of the ingoing flow.  
The output will be a single enthalpy value.

An example of modelling a pump:  
```
clear

% Input pressure
n(1).p = 0.1; % bar
% Using XSteam to calculate the saturation temperature of the ingoing flow
n(1).t = XSteam('tsat_p',n(1).p); % °C

% It's necessary to calculate the enthalpy of the ingoing flow manually, because the ingoing flow is a saturated liquid.
n(1).h = XSteam('hL_p',n(1).p);

% Declaring the desired output pressure
n(2).p = 10;

% Flow 1 enters a pump with an isentropic efficiency of 80%. The output of the function is the enthalpy of flow 2.
n(2).h = pump(n(1),n(2),0.80);

% Calculating the other properties of flow 2 based on the enthalpy
n(2).s = xs('s_ph',n(2).p,n(2).h);
n(2).t = xs('t_ph',n(2).p,n(2).h);
```
