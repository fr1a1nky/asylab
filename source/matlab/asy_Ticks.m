function result = asy_Ticks(varargin)
% Arguments incomplete.
%  ticks Ticks(Label format="", ticklabel ticklabel=null,
%                  bool beginlabel=true, bool endlabel=true,
%                  int N=0, int n=0, real Step=0, real step=0,
%                  bool begin=true, bool end=true, tickmodifier modify=None,
%                  real Size=0, real size=0, bool extend=false,
%                  pen pTick=nullpen, pen ptick=nullpen);
%  ticks Ticks(Label format="", ticklabel ticklabel=null, 
%                  bool beginlabel=true, bool endlabel=true, 
%                  real[] Ticks, real[] ticks=new real[],
%                  real Size=0, real size=0, bool extend=false,
%                  pen pTick=nullpen, pen ptick=nullpen)

defaults = struct(...
    'ticklabel', [], ...
    'Ticks', [], ...
    'ticks', [], ...
    'Step', [], ...
    'step', [], ...
    'N', [], ...
    'n', [], ...
    'extend', [], ...
    'pTick', [], ...
    'ptick', [] ...
    );

%args = ita_parse_arguments(defaults, varargin);
args = setfields(defaults, varargin{:});

if ~isempty(args.extend) && ~ischar(args.extend)
    if args.extend
        args.extend = 'true';
    else
        args.extend = 'false';
    end
end

if ~isempty(args.Ticks) && ~ischar(args.Ticks)
    args.Ticks = asy_array_new('real', args.Ticks);
end

if ~isempty(args.ticks) && ~ischar(args.ticks)
    args.ticks = asy_array_new('real', args.ticks);
end

if ~isempty(args.Step) && ~ischar(args.Step)
    args.Step = sprintf('%g', args.Step);
end

if ~isempty(args.step) && ~ischar(args.step)
    args.step = sprintf('%g', args.step);
end

if ~isempty(args.N) && ~ischar(args.N)
    args.N = sprintf('%g', args.N);
end

if ~isempty(args.n) && ~ischar(args.n)
    args.n = sprintf('%g', args.n);
end

result = asy_command('Ticks', args);

end