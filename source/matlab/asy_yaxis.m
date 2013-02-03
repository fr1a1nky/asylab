function result = asy_yaxis(varargin)
% Arguments incomplete.
% void yaxis(picture pic=currentpicture, Label L="", axis axis=XZero,
%                 real ymin=-infinity, real ymax=infinity, pen p=currentpen,
%                 ticks ticks=NoTicks, arrowbar arrow=None, bool above=false,
%                 bool autorotate=true);

defaults = struct(...
    'pic', [], ...
    'L', [], ...
    'axis', [], ...
    'ymin', [], ...
    'ymax', [], ...
    'ticks', [], ...
    'above', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if ~isempty(args.L) && ~startswith(args.L, '"')
    args.L = sprintf('"%s"', args.L);
end

if ~isempty(args.ymin) && ~ischar(args.ymin)
    args.ymin = sprintf('"%g"', args.ymin);
end

if ~isempty(args.ymax) && ~ischar(args.ymax)
    args.ymax = sprintf('"%g"', args.ymax);
end

if ~isempty(args.above) && ~ischar(args.above)
    if args.above
        args.above = 'true';
    else
        args.above = 'false';
    end
end

result = asy_command('yaxis', args);

end