function result = asy_usepackage(varargin)
% Arguments incomplete.
% void usepackage(string s, string options="");

defaults = struct(...
    's', [], ... 
    'options', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.s)
    exception = MException('asy:inputError', ...
        'Input error: string s has to be set.' ...
        );
    throw(exception);
end

if ~startswith(args.s, '"')
    args.s = sprintf('"%s"', args.s);
end

if ~isempty(args.options) && ~startswith(args.options, '"')
    args.options = sprintf('"%s"', args.options);
end

result = asy_command('usepackage', args);

end