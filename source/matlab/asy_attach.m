function result = asy_attach(varargin)
% void attach(picture dest=currentpicture, frame src,
%               pair position=0, bool group=true,
%               filltype filltype=NoFill, bool above=true);
% void attach(picture dest=currentpicture, frame src,
%               pair position, pair align, bool group=true,
%               filltype filltype=NoFill, bool above=true);

defaults = struct(...
    'dest', [], ...
    'src', [], ...
    'position', [], ...
    'align', [], ...
    'filltype', [] ...
    );

args = ita_parse_arguments(defaults, varargin);

if isempty(args.src)
    exception = MException('asy:inputError', ...
        'Input error: picture src has to be set.' ...
        );
    throw(exception);
end

result = asy_command('attach', args);

end