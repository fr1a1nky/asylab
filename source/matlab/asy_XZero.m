function result = asy_XZero(varargin)
% Arguments incomplete.
% XZero(bool extend=true)
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

result = asy_command('XZero', args);

end