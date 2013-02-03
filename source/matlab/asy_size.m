function result = asy_size(varargin)
% void size(picture pic=currentpicture, real x, real y=x,
%           bool keepAspect=Aspect);
% void size(picture pic=currentpicture, real xsize, real ysize,
%           pair min, pair max);
% pair size(picture pic, user=false);

defaults = struct(...
    'pic', [], ...
    'x', [], ...
    'y', [], ...
    'keepAspect', [], ...
    'user', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.x)
    exception = MException('asy:inputError', ...
        'Input error: scaleT x has to be set.' ...
        );
    throw(exception);
end

if ~ischar(args.x)
    args.x = sprintf('%g', args.x);
end

if ~isempty(args.y) && ~ischar(args.y)
    args.y = sprintf('%g', args.y);
end

if ~isempty(args.keepAspect) && ~ischar(args.keepAspect)
    if args.keepAspect
        args.keepAspect = 'true';
    else
        args.keepAspect = 'false';
    end
end

if ~isempty(args.user) && ~ischar(args.user)
    if args.user
        args.user = 'true';
    else
        args.user = 'false';
    end
end

result = asy_command('size', args);

end