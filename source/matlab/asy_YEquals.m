function result = asy_YEquals(varargin)
% Arguments incomplete.
% YEquals(real Y, bool extend=true)
defaults = struct(...
    'Y', [], ...
    'extend', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.Y)
    exception = MException('asy:inputError', ...
        'Input error: real Y has to be set.' ...
        );
    throw(exception);
end

if ~ischar(args.Y)
    args.Y = sprintf('%.f', args.Y);
end

if ~isempty(args.extend) && ~ischar(args.extend)
    if args.extend
        args.extend = 'true';
    else
        args.extend = 'false';
    end
end

result = asy_command('YEquals', args);

end