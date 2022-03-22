% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function n = setdefflow(n,defflow,num)
if ~exist('num','var')
    num = 0;
end
% num is the total number of flows
if num<length(n)&&num~=0
    warning("The number of flows is "+length(n)+", not "+num);
    num = length(n);
end
% Get the list of field names of the defaults structure
fields = fieldnames(defflow);
for cfield = 1:length(fields)
    % For each flow
    for cflow = 1:num
        try
            % If the specific fiels is not set, assign the default value
            if isempty(n(cflow).(fields{cfield}))||~isfield(n(cflow),fields{cfield})
                n(cflow).(fields{cfield}) = defflow.(fields{cfield});
            end
        catch ME
            switch ME.identifier
                case 'MATLAB:badsubscript'
                    n(cflow).(fields{cfield}) = defflow.(fields{cfield});
                otherwise
                    rethrow(ME)
            end
        end
    end
end