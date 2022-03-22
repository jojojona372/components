% Author: Jona van der Pal
% Date: 13/03/2022
% Version: 22032022

function comp = setdefcomp(comp,defcomp,num)
% num is the total number of components
if num<length(comp)&&num~=0
    warning("The number of components is "+length(comp)+", not "+num);
    num = length(comp);
end
% Get the list of field names of the defaults structure
fields = fieldnames(defcomp);
for cfield = 1:length(fields)
    % For each flow
    for ccomp = 1:num
        try
            % If the specific fiels is not set, assign the default value
            if isempty(comp(ccomp).(fields{cfield}))||~isfield(comp(ccomp),fields{cfield})
                comp(ccomp).(fields{cfield}) = defcomp.(fields{cfield});
            end
        catch ME
            switch ME.identifier
                case 'MATLAB:badsubscript'
                    comp(ccomp).(fields{cfield}) = defcomp.(fields{cfield});
                otherwise
                    rethrow(ME)
            end
        end
    end
end