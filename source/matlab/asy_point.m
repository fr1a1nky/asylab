function result = asy_point(varargin)
% pair point(picture pic=currentpicture, pair dir, bool user=true);

defaults = struct(...
    'pic', [], ...
    'dir', [], ...
    'user', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.dir)
    exception = MException('asy:inputError', ...
        'Input error: pair dir has to be set.' ...
        );
    throw(exception);
end

if ~isempty(args.user) && ~ischar(args.user)
    if args.user
        args.user = 'true';
    else
        args.user = 'false';
    end
end

result = asy_command('point', args);

end