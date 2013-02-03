function result = asy_scale(varargin)
%  void scale(picture pic=currentpicture, scaleT x, scaleT y);
% 
%  void scale(picture pic=currentpicture, bool xautoscale=true,
%             bool yautoscale=xautoscale, bool zautoscale=yautoscale);

defaults = struct(...
    'pic', [], ...
    'x', [], ...
    'y', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.x)
    exception = MException('asy:inputError', ...
        'Input error: scaleT x has to be set.' ...
        );
    throw(exception);
end

if isempty(args.y)
    exception = MException('asy:inputError', ...
        'Input error: scaleT y has to be set.' ...
        );
    throw(exception);
end

result = asy_command('scale', args);

end