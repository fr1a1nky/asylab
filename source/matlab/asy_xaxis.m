function result = asy_xaxis(varargin)
% Arguments incomplete.
% void xaxis(picture pic=currentpicture, Label L="", axis axis=YZero,
%                 real xmin=-infinity, real xmax=infinity, pen p=currentpen, 
%                 ticks ticks=NoTicks, arrowbar arrow=None, bool above=false);

defaults = struct(...
    'pic', [], ...
    'L', [], ...
    'axis', [], ...
    'xmin', [], ...
    'xmax', [], ...
    'ticks', [], ...
    'above', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if ~isempty(args.L) && ~startswith(args.L, '"')
    args.L = sprintf('"%s"', args.L);
end

if ~isempty(args.xmin) && ~ischar(args.xmin)
    args.xmin = sprintf('"%g"', args.xmin);
end

if ~isempty(args.xmax) && ~ischar(args.xmax)
    args.xmax = sprintf('"%g"', args.xmax);
end

if ~isempty(args.above) && ~ischar(args.above)
    if args.above
        args.above = 'true';
    else
        args.above = 'false';
    end
end

result = asy_command('xaxis', args);

end