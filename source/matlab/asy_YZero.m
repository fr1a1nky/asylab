function result = asy_YZero(varargin)
% Arguments incomplete.
% YZero(bool extend=true)
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

result = asy_command('YZero', args);

end