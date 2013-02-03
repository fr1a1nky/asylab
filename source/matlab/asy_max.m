function result = asy_max(varargin)
% pair max(picture pic, user=false);

defaults = struct(...
    'pic', [], ...
    'user', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.pic)
    exception = MException('asy:inputError', ...
        'Input error: picture pic has to be set.' ...
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

result = asy_command('max', args);

end