function result = asy_command(name, varargin)
% Arguments have to be converted to strings already.

if numel(varargin) > 1
    for index = 1:2:numel(varargin)
        args.(varargin{index}) = varargin{index+1};
    end
elseif numel(varargin) == 1
    args = varargin{1};
else
    args = struct;
end

% remove empty fields
params = fieldnames(args);
for index = 1:numel(params)
    if isempty(args.(params{index}))
        args = rmfield(args, params{index});
    end
end

params = fieldnames(args);

result = [name '('];
for index = 1:numel(params)
    if index > 1
        result = [result ', '];
    end
    result = [result params{index} '=' args.(params{index})];
end
result = [result ')'];

end