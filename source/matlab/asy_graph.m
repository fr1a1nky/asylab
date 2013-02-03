function result = asy_graph(varargin)
% Arguments incomplete.
% guide graph(picture pic=currentpicture, real[] x, real[] y,
%       interpolate join=operator --);

defaults = struct(...
    'pic', [], ... currentpicture
    'x', [], ...
    'y', [], ...
    'join', [] ... Straight/Spline
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.x)
    exception = MException('asy:inputError', ...
        'Input error: real[] x has to be set.' ...
        );
    throw(exception);
end

if isempty(args.y)
    exception = MException('asy:inputError', ...
        'Input error: real[] y has to be set.' ...
        );
    throw(exception);
end

if ~ischar(args.x)
    % ToDo
end

if ~ischar(args.y)
    % ToDo
end

result = asy_command('graph', args);

end