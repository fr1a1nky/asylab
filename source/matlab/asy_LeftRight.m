function result = asy_LeftRight(varargin)
% Arguments incomplete.
% LeftRight(bool extend=false)
defaults = struct(...
    'extend', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if ~isempty(args.extend) && ~ischar(args.extend)
    if args.extend
        args.extend = 'true';
    else
        args.extend = 'false';
    end
end

result = asy_command('LeftRight', args);

end