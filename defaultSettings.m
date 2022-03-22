% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function [n,comp,defflow,defcomp] = defaultSettings(n,comp)
    if ~exist("comp","var")&&~exist("comp2","var")
        clear setflowname
        comp = struct('name',{},'ef',{},'win',{},'wout',{},'qin',{},'qout',{},'P',{});
    end
    
    defcomp.name = [];
    defcomp.ef = 1;
    defcomp.win = [];
    defcomp.wout = [];
    defcomp.qin = [];
    defcomp.qout = [];
    defcomp.P = [];
    
    if ~exist("n","var")
        n = struct('n',{},'t',{},'p',{},'h',{},'s',{},'x',{},'m',{});
    end
    
    defflow.n = [];
    defflow.t = [];
    defflow.p = [];
    defflow.h = [];
    defflow.s = [];
    defflow.x = [];
    defflow.m = [];
end