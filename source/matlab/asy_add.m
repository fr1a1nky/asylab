function result = asy_add(varargin)
% void add(frame dest, frame src);
% void add(picture src, bool group=true,
%       filltype filltype=NoFill, bool above=true);
% void add(picture dest, picture src, bool group=true,
%       filltype filltype=NoFill, bool above=true);
% void add(picture src, pair position, bool group=true,
%       filltype filltype=NoFill, bool above=true);
% void add(picture dest, picture src, pair position,
%       bool group=true, filltype filltype=NoFill, bool above=true);
% void add(picture dest=currentpicture, frame src, pair position=0,
%       bool group=true, filltype filltype=NoFill, bool above=true);
% void add(picture dest=currentpicture, frame src, pair position,
%       pair align, bool group=true, filltype filltype=NoFill,
%       bool above=true);


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

result = asy_command('add', args);

end