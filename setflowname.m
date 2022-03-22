% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function n = setflowname(n,f1,f2,f3,f4)
% TODO
% Assign flow names per cycle. Allow user to set a starting flow number for each
% cycle. Count up from this number for each cycle.
% Assign flow numbers automatically as well. Count up from the starting
% flow number. 
    if isempty(n(f2).n)
        persistent flowcount
        if isempty(flowcount)
            flowcount = 1;
        end
        switch nargin
            case 3
                n(f1).n = string(flowcount);
                n(f2).n = string(flowcount+1);
                flowcount = flowcount+1;
            case 4
                n(f1).n = string(flowcount);
                n(f2).n = (flowcount+1)+"s";
                n(f3).n = string(flowcount+1);
                flowcount = flowcount+1;
            case 5
                n(f1).n = string(flowcount);
                n(f2).n = string(flowcount+1);
                n(f3).n = string(flowcount+2);
                n(f4).n = string(flowcount+3);
    %             n(f3).n = string(num);
    %             n(f4).n = string(num+1);
                flowcount = flowcount+3;
        end
    end
end