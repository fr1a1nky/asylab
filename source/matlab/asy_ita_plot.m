function result = asy_ita_plot(varargin)
% picture ita_plot(string filepath, int N_channels, scaleT scale_x=Log2, scaleT scale_y=Linear, pen[] pChannel={currentpen}, 
% 				 Label[] legend={""}, Label label_x="", Label label_y="", ticks ticks_x=NoTicks, ticks ticks_y=NoTicks,
% 				 axis axis_x=BottomTop, axis axis_y=LeftRight, real size_x, real size_y=size_x, bool keepAspect=false,
% 				 bool add_legend=true, pair dir_legend=NE, pair align_legend=SW, filltype filltype_legend=UnFill,
% 				 real linelength_legend=legendlinelength, real xmargin_legend=legendmargin, 
% 				 real xmin=-infinity, real xmax=infinity, real ymin=-infinity, real ymax=infinity, bool crop=NoCrop)

defaults = struct(...
    'filepath', [], ...
    'N_channels', [], ...
    'scale_x', [], ...
    'scale_y', [], ...
    'pChannel', [], ...
    'legend', [], ...
    'label_x', [], ...
    'label_y', [], ...
    'ticks_x', [], ...
    'ticks_y', [], ...
    'axis_x', [], ...
    'axis_y', [], ...
    'size_x', [], ...
    'size_y', [], ...
    'keepAspect', [], ...
    'add_legend', [], ...
    'dir_legend', [], ...
    'align_legend', [], ...
    'filltype_legend', [], ...
    'linelength_legend', [], ...
    'xmargin_legend', [], ...
    'perline', [], ...
    'xmin', [], ...
    'xmax', [], ...
    'ymin', [], ...
    'ymax', [], ...
    'crop', [] ...
    );

if nargin > 1
    args = ita_parse_arguments(defaults, varargin);
else
    args = setfields(defaults, varargin{1});
end

if isempty(args.filepath)
    exception = MException('asy:inputError', ...
        'Input error: string filepath has to be set.' ...
        );
    throw(exception);
end

if isempty(args.N_channels)
    exception = MException('asy:inputError', ...
        'Input error: int N_channels has to be set.' ...
        );
    throw(exception);
end

if ~isempty(args.filepath) && ~startswith(args.filepath, '"')
    args.filepath = sprintf('"%s"', args.filepath);
end

if ~isempty(args.N_channels) && ~ischar(args.N_channels)
    args.N_channels = sprintf('%d', args.N_channels);
end

if ~isempty(args.pChannel) && ~ischar(args.pChannel)
    if ~iscell(args.pChannel)
        args.pChannel = sprintf('{%s}', args.pChannel);
    else
        args.pChannel = asy_array_new('pen', args.pChannel);
    end
end

if ~isempty(args.legend) && ~ischar(args.legend)
    if ~iscell(args.legend)
        args.legend = sprintf('{%s}', args.legend);
    else
        args.legend = asy_array_new('Label', args.legend);
    end
end

if ~isempty(args.label_x) && ~startswith(args.label_x, '"')
    args.label_x = sprintf('"%s"', args.label_x);
end

if ~isempty(args.label_y) && ~startswith(args.label_y, '"')
    args.label_y = sprintf('"%s"', args.label_y);
end

if ~isempty(args.size_x) && ~ischar(args.size_x)
    args.size_x = sprintf('%g', args.size_x);
end

if ~isempty(args.size_y) && ~ischar(args.size_y)
    args.size_y = sprintf('%g', args.size_y);
end

if ~isempty(args.keepAspect) && ~ischar(args.keepAspect)
    if args.keepAspect
        args.keepAspect = 'true';
    else
        args.keepAspect = 'false';
    end
end

if ~isempty(args.add_legend) && ~ischar(args.add_legend)
    if args.add_legend
        args.add_legend = 'true';
    else
        args.add_legend = 'false';
    end
end

if ~isempty(args.linelength_legend) && ~ischar(args.linelength_legend)
    args.linelength_legend = sprintf('%g', args.linelength_legend);
end

if ~isempty(args.xmargin_legend) && ~ischar(args.xmargin_legend)
    args.xmargin_legend = sprintf('%g', args.xmargin_legend);
end

if ~isempty(args.perline) && ~ischar(args.perline)
    args.perline = sprintf('%d', args.perline);
end

if ~isempty(args.xmin) && ~ischar(args.xmin)
    args.xmin = sprintf('%g', args.xmin);
end

if ~isempty(args.xmax) && ~ischar(args.xmax)
    args.xmax = sprintf('%g', args.xmax);
end

if ~isempty(args.ymin) && ~ischar(args.ymin)
    args.ymin = sprintf('%g', args.ymin);
end

if ~isempty(args.ymax) && ~ischar(args.ymax)
    args.ymax = sprintf('%g', args.ymax);
end

if ~isempty(args.crop) && ~ischar(args.crop)
    if args.crop
        args.crop = 'true';
    else
        args.crop = 'false';
    end
end

result = asy_command('ita_plot', args);

end