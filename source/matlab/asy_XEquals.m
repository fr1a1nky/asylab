function result = asy_XEquals(varargin)
% Arguments incomplete.
% XEquals(real X, bool extend=true)
defaults = struct(...
    'X', [], ...
    'extend', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.X)
    exception = MException('asy:inputError', ...
        'Input error: real X has to be set.' ...
        );
    throw(exception);
end

if ~ischar(args.X)
    args.X = sprintf('%g', args.X);
end

if ~isempty(args.extend) && ~ischar(args.extend)
    if args.extend
        args.extend = 'true';
    else
        args.extend = 'false';
    end
end

result = asy_command('XEquals', args);

end