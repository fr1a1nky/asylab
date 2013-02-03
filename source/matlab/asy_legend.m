function result = asy_legend(varargin)
% Arguments incomplete.
% frame legend(picture pic=currentpicture, int perline=1,
%              real xmargin=legendmargin, real ymargin=xmargin,
%              real linelength=legendlinelength,
%              real hskip=legendhskip, real vskip=legendvskip,
%              real maxwidth=0, real maxheight=0, 
%              bool hstretch=false, bool vstretch=false, pen p=currentpen);

defaults = struct(...
    'pic', [], ... currentpicture
    'perline', [], ... 1
    'xmargin', [], ... legendmargin
    'ymargin', [], ... xmargin
    'linelength', [], ... legendlinelength
    'p', [] ... currentpen // boundding box
    );

args = ita_parse_arguments(defaults, varargin);

if ~isempty(args.perline) && ~ischar(args.perline)
    args.perline = sprintf('%d', args.perline);
end

if ~isempty(args.xmargin) && ~ischar(args.xmargin)
    args.xmargin = sprintf('%g', args.xmargin);
end

if ~isempty(args.ymargin) && ~ischar(args.ymargin)
    args.ymargin = sprintf('%g', args.ymargin);
end

if ~isempty(args.linelength) && ~ischar(args.linelength)
    args.linelength = sprintf('%g', args.linelength);
end

result = asy_command('legend', args);

end