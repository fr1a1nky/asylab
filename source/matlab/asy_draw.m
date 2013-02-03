function result = asy_draw(varargin)
% Arguments incomplete.
% void draw(picture pic=currentpicture, Label L="", path g,
%           align align=NoAlign, pen p=currentpen,
%           arrowbar arrow=None, arrowbar bar=None, margin margin=NoMargin,
%           Label legend="", marker marker=nomarker);

defaults = struct(...
    'pic', [], ... currentpicture
    'L', [], ... ""
    'g', [], ...
    'p', [], ... currentpen
    'legend', [], ... ""
    'marker', [] ... nomarker
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.g)
    exception = MException('asy:inputError', ...
        'Input error: path g has to be set.' ...
        );
    throw(exception);
end

if ~isempty(args.L) && ~startswith(args.L, '"')
    args.L = sprintf('"%s"', args.L);
end

if ~isempty(args.legend) && ~startswith(args.legend, '"')
    args.legend = sprintf('"%s"', args.legend);
end

result = asy_command('draw', args);

end