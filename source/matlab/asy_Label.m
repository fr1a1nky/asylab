function result = asy_Label(varargin)
% Arguments incomplete.
% Label Label(string s="", pair position, align align=NoAlign,
%             pen p=nullpen, embed embed=Rotate, filltype filltype=NoFill);
% Label Label(string s="", align align=NoAlign,
%             pen p=nullpen, embed embed=Rotate, filltype filltype=NoFill);
% Label Label(Label L, pair position, align align=NoAlign,
%             pen p=nullpen, embed embed=L.embed, filltype filltype=NoFill);
% Label Label(Label L, align align=NoAlign,
%             pen p=nullpen, embed embed=L.embed, filltype filltype=NoFill);

defaults = struct(...
    's', [], ... ""
    'position', [], ...
    'align', [], ... NoAlign
    'p', [], ... nullpen
    'filltype', [] ... NoFill
    );

args = ita_parse_arguments(defaults, varargin);

if ~isempty(args.s) && ~startswith(args.s, '"')
    args.s = sprintf('"%s"', args.s);
end

result = asy_command('Label', args);

end