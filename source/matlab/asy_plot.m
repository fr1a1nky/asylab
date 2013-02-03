function asy_plot(varargin)

args = struct(...
    'filepath', [], ...
    'data', [], ...
    'fun', '', ...
    'xlim', [-inf inf], ...
    'ylim', [-inf inf], ...
    'crop', 'NoCrop', ...
    'xlabel', '', ...
    'ylabel', '', ...
    'xunit', '', ... 
    'yunit', '', ... 
    'xscale', 'Log', ...
    'yscale', 'Linear', ...
    'db', false, ...
    'xaxis', 'BottomTop', ...
    'yaxis', 'LeftRight', ...
    'xticks', 'ita', ... something ToDo
    'xticks_', [], ... atm only if xticks is set to numeric array
    'yticks', [], ... something ToDo
    'xticklabel', 'ita_freq_label', ... something ToDo
    'yticklabel', [], ... something ToDo
    'extend', 'fdda_extendticks', ... true
    'Tickspen', 'fdda_Tickspen', ... dotted
    'color', 'blue', ...
    'linestyle', 'solid', ...
    'linewidth', 'fdda_linewidth', ... 1.0
    'width', 'fdda_width', ... 15cm
    'height', 'fdda_height', ... 5cm
    'leftmargin', '2cm', ...
    'rightmargin', '0cm', ...
    'topmargin', '0cm', ...
    'bottommargin', '2cm', ...
    'legend', true, ...
    'legend_margin', '5pt', ...
    'legend_pos', 'NE', ...
    'legend_align', 'SW', ...
    'legend_perline', 1, ...
    'legend_linelength', '0.5cm', ...
    'import', {{'fdda'}}, ...
    'usepackage', {{'siunitx', 'fdda_all'}} ...
    );

if nargin > 1
%     args = ita_parse_arguments(args, varargin);
    for index = 1:2:numel(varargin)
        args.(varargin{index}) = varargin{index+1};
    end
else
    args = setfields(args, varargin{1});
end

if iscell(args.fun)
    fun = args.fun;
else
    fun = {args.fun};
end

if ~iscell(args.data)
    data  = {args.data};
else
    data = args.data;
end

N_channels = cell(size(fun));

db = tocellofsize(args.db, size(fun));

for i_row = 1:size(fun, 1)
    for i_col = 1:size(fun, 2)
        fileID = fopen([args.filepath '.data' subid(i_row, i_col)], 'w');
        N_channels{i_row, i_col} = 0;
        if isnumeric(fun{i_row, i_col})
            % interpret value as index of data set
            % just plot this data set
            i_data = fun{i_row, i_col};
            
            data_x = data{i_data}.freqVector;
            data_y = data{i_data}.freq;

            if startswith(args.xscale, 'Log') && data_x(1) == 0
                data_x = data_x(2:end);
                data_y = data_y(2:end,:);
            end
            
            if db{i_row, i_col}
                data_y = 20*log10(data_y);
            end
            
            N_channels{i_row, i_col} = data{i_data}.nChannels;
            for index = 1:data{i_data}.nChannels
                addline(fileID, matrix_to_string(data_x));
                addline(fileID, matrix_to_string(data_y(:,index)));
            end
        else
            % interpret value as function to apply on data
            % plot all given data sets
            for i_data = 1:numel(data)
                data_x = data{i_data}.freqVector;
                data_y = data{i_data}.freq;

                if ~isempty(fun{i_row, i_col})
                    eval(['data_y = ' fun{i_row, i_col} '(data_y);']);
                end

                if startswith(args.xscale, 'Log') && data_x(1) == 0
                    data_x = data_x(2:end);
                    data_y = data_y(2:end,:);
                end
            
                if db{i_row, i_col}
                    data_y = 20*log10(data_y);
                end
                
                N_channels{i_row, i_col} = N_channels{i_row, i_col} + data{i_data}.nChannels;
                for index = 1:data{i_data}.nChannels
                    addline(fileID, matrix_to_string(data_x));
                    addline(fileID, matrix_to_string(data_y(:,index)));
                end
            end
        end
        fclose(fileID);
    end
end

%% create .asy file
fileID = fopen([args.filepath '.asy'], 'w');

% stuff mutual in all plots
addline(fileID, 'import graph;');
addline(fileID, 'import ita;');
for index = 1:numel(args.import)
    addline(fileID, ['import ' args.import{index} ';']);
end
addline(fileID, '');
for index = 1:numel(args.usepackage)
    if ischar(args.usepackage{index})
        addline(fileID, [asy_usepackage('s', args.usepackage{index}) ';']);
    else
        C = args.usepackage{index};
        options='';
        for i_C = 2:numel(C)
            if i_C > 2
                options = [options ','];
            end
            options = [options C{i_C}];
        end
        addline(fileID, [asy_usepackage('s', args.usepackage{index}, 'options', options) ';']);
    end
end
addline(fileID, '');
if ~ischar(args.extend)
    if args.extend
        extend = 'true';
    else
        extend = 'false';
    end
else
    extend = args.extend;
end
addline(fileID, ['bool extendticks = ' extend ';']);
addline(fileID, ['pen Tickspen = ' args.Tickspen ';']);
addline(fileID, '');

% addline(fileID, ['int N_channels = ' sprintf('%d', N_channels) ';']);
addline(fileID, ['int N_columns = ' sprintf('%d', size(fun, 2)) ';']);
addline(fileID, ['real leftmargin = ' args.leftmargin ';']);
addline(fileID, ['real rightmargin = ' args.rightmargin ';']);
addline(fileID, ['real topmargin = ' args.topmargin ';']);
addline(fileID, ['real bottommargin = ' args.bottommargin ';']);
addline(fileID, ['real total_width = ' args.width ';']);
addline(fileID, ['real col_width = (total_width-N_columns*(leftmargin+rightmargin))/N_columns;']);
addline(fileID, ['real row_height = ' args.height ';']);
addline(fileID, '');

% make pen for lines
if ischar(args.color)
    pChannel = {args.color};
elseif iscell(args.color)
    pChannel = {};
    for index = 1:numel(args.color)
        if ischar(args.color{index})
            pChannel = [pChannel args.color(index)];
        else
            col = aprintf('rgb(%g,%g,%g)', args.color{index});
            pChannel = [pChannel col.'];
        end
    end
else
    pChannel = aprintf('rgb(%g,%g,%g)', args.color);
end

if ischar(args.linestyle)
    for index = 1:numel(pChannel)
        pChannel{index} = [pChannel{index} '+' args.linestyle];
    end
else
    % ToDo
end

if ischar(args.linewidth)
    for index = 1:numel(pChannel)
        pChannel{index} = [pChannel{index} '+' args.linewidth];
    end
else
    % ToDo
end

addline(fileID, ['pen[] p_channel = ' asy_array_init(pChannel) ';']);

% legend
channelNames = {};
for i_data = 1:numel(data)
    channelNames = [channelNames; data{i_data}.channelNames];
end
legend_channel = aprintf('Label("%s", black)', channelNames);
addline(fileID, ['Label[] legend_channel =' asy_array_init(legend_channel) ';']);

addline(fileID, '');
if isempty(args.xticks)
    addline(fileID, ['ticks ticks_x = ' asy_LeftTicks('ticklabel', args.xticklabel, 'extend', 'extendticks', 'pTick', 'Tickspen') ';']);
elseif ischar(args.xticks)
    if strcmp(args.xticks, 'ita')
        addline(fileID, ['ticks ticks_x = ' asy_LeftTicks('ticklabel', args.xticklabel, 'Ticks', 'ita_freq_ticks', 'extend', 'extendticks', 'pTick', 'Tickspen') ';']);
    else
        addline(fileID, ['ticks ticks_x = ' args.xticks ';']);
    end
elseif isnumeric(args.xticks)
    addline(fileID, ['ticks ticks_x = ' asy_LeftTicks('ticklabel', args.xticklabel, 'Ticks', args.xticks, 'extend', 'extendticks', 'pTick', 'Tickspen', 'ticks', args.xticks_, 'ptick', 'Tickspen') ';']);
end
addline(fileID, '');

% mutual arguments
a.scale_x = args.xscale;
a.label_x = args.xlabel;
if ~isempty(args.xunit)
    a.label_x = [a.label_x ' in ' args.xunit];
end
a.ticks_x = 'ticks_x';
a.pChannel = 'p_channel';
a.legend = 'legend_channel';
a.axis_x = args.xaxis;
a.axis_y = args.yaxis;
a.size_x = 'col_width';
a.size_y = 'row_height';
a.linelength_legend = args.legend_linelength;
a.xmargin_legend = args.legend_margin;
a.filltype_legend = 'UnFill';
a.perline = args.legend_perline;
if ~isinf(args.xlim(1))
    a.xmin = args.xlim(1);
end
if ~isinf(args.xlim(2))
    a.xmax = args.xlim(2);
end

% subplot specific stuff
yticks = tocellofsize(args.yticks, size(fun));
yticklabel = tocellofsize(args.yticklabel, size(fun));
ticks_y = cell(size(fun));
for i_row = 1:size(fun, 1)
    for i_col = 1:size(fun, 2)
        if isempty(yticks{i_row, i_col})
            ticks_y{i_row, i_col} = asy_RightTicks('extend', 'extendticks', 'pTick', 'Tickspen');
        elseif ischar(yticks{i_row, i_col})
            if strcmp(yticks{i_row, i_col}, 'phase')
                ticks_y{i_row, i_col} = asy_RightTicks('ticklabel', yticklabel{i_row, i_col}, 'Ticks', 'ita_phase_ticks', 'extend', 'extendticks', 'pTick', 'Tickspen');
            else
                ticks_y{i_row, i_col} = yticks{i_row, i_col};
            end
        elseif isnumeric(yticks{i_row, i_col})
            if ~isscalar(yticks{i_row, i_col})
                ticks_y{i_row, i_col} = asy_RightTicks('ticklabel', yticklabel{i_row, i_col}, 'Ticks', yticks{i_row, i_col}, 'extend', 'extendticks', 'pTick', 'Tickspen');
            elseif (yticks{i_row, i_col} > 0)
                ticks_y{i_row, i_col} = asy_RightTicks('ticklabel', yticklabel{i_row, i_col}, 'N', yticks{i_row, i_col}, 'extend', 'extendticks', 'pTick', 'Tickspen');
            elseif (yticks{i_row, i_col} < 0)
                ticks_y{i_row, i_col} = asy_RightTicks('ticklabel', yticklabel{i_row, i_col}, 'Step', abs(yticks{i_row, i_col}), 'extend', 'extendticks', 'pTick', 'Tickspen');
            end
        end
    end
end
scale_y = tocellofsize(args.yscale, size(fun));
label_y = tocellofsize(args.ylabel, size(fun));
unit_y = tocellofsize(args.yunit, size(fun));
for i_fun = 1:numel(fun)
    if ~isempty(unit_y{i_fun})
        label_y{i_fun} = [label_y{i_fun} ' in ' unit_y{i_fun}];
    end
end
legend = tocellofsize(args.legend, size(fun));
dir_legend = tocellofsize(args.legend_pos, size(fun));
align_legend = tocellofsize(args.legend_align, size(fun));
ylim = tocellofsize(args.ylim, size(fun));
crop = tocellofsize(args.crop, size(fun));
for i_row = 1:size(fun, 1)
    for i_col = 1:size(fun, 2)
        relativepath = split(args.filepath, '/');
        relativepath = split(relativepath{end}, '\');
        a.filepath = [relativepath{end} '.data' subid(i_row, i_col)];
        a.N_channels = N_channels{i_row, i_col};
        a.scale_y = scale_y{i_row, i_col};
        a.label_y = label_y{i_row, i_col};
        a.ticks_y = ticks_y{i_row, i_col};
        a.add_legend = legend{i_row, i_col};
        a.dir_legend = dir_legend{i_row, i_col};
        a.align_legend = align_legend{i_row, i_col};

        if ~isinf(ylim{i_row, i_col}(1))
            a.ymin = ylim{i_row, i_col}(1);
        end
        if ~isinf(ylim{i_row, i_col}(2))
            a.ymax = ylim{i_row, i_col}(2);
        end
        a.crop = crop{i_row, i_col};

        addline(fileID, ['picture pic' subid(i_row, i_col) ' = ' asy_ita_plot(a) ';']);
    end
end

addline(fileID, '');

for i_row = 1:size(fun, 1)
    for i_col = 1:size(fun, 2)
        s_col = sprintf('%d', i_col-1);
        s_row = sprintf('%d', i_row-1);
        addline(fileID, ['frame f' subid(i_row, i_col) ' = pic' subid(i_row, i_col) '.fit();']);
        addline(fileID, ['f' subid(i_row, i_col) ' = shift(-point(pic' subid(i_row, i_col) ', NW, false)) * shift(leftmargin + (col_width+leftmargin+rightmargin) * ' s_col ', -topmargin -(row_height+topmargin+bottommargin) * ' s_row ') * f' subid(i_row, i_col) ';']);
        addline(fileID, ['add(f' subid(i_row, i_col) ');']);
        addline(fileID, '');
    end
end

fclose(fileID);

end

function C = tocellofsize(arg, shape)
    if ~iscell(arg)
        arg = {arg};
    end
    C = repmat(arg, shape - size(arg) + 1);
end

function result = subid(i_row, i_col)
    result = sprintf('%d%d', i_row, i_col);
end

function addline(fileID, s)
    fprintf(fileID, '%s\n', s);
end