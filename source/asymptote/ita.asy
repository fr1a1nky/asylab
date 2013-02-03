import graph;

usepackage("upgreek");

real log2(real x) {static real log2=log(2); return log(x)/log2;}
real pow2(real x) {return 2^x;}
scaleT Log2 = scaleT(log2 ,pow2, logarithmic=true);

real deg(real x) {return x/pi*180;}
real rad(real x) {return x/180*pi;}
scaleT Deg = scaleT(deg, rad, logarithmic=false);

real to_dB(real x) {return 20*log10(x);}
real from_dB(real x) {return 10^(x/20);}
scaleT dB = scaleT(to_dB, from_dB, logarithmic=false);

real[] ita_freq_ticks = {1, 2, 4, 6, 10, 20, 40, 60, 100, 200, 400, 600, 1000, 2000, 4000, 6000, 10000, 20000};
real[] ita_phase_ticks = {-pi, -pi/2, 0, pi/2, pi};

string ita_freq_label(real value){
	if (value >= 1000){
		return format("$%.0f\mathrm{k}$", value/1000);
	}
	else {
		return format("$%.0f$", value);
	}
}

string ita_only_label(real value, real[] only){
	if (find(value==only) == -1) {
		return "";
	}
	else {
		return ita_freq_label(value);
	}
}

string ita_phase_label_deg(real value){
	return format("%g", value/pi*180);
}

string ita_degree_label(real value){
	return format("\SI{%g}{\degree}", value);
}

string ita_phase_label_pi(real value){
	if (abs(value - pi) < 0.001) {
		return "$\uppi$";
	}
	else if (abs(value + pi) < 0.001) {
		return "$-\uppi$";
	}
	else if (value == 0) {
		return "$0$";
	}
	else if (value > 0) {
		return format("$\frac{\uppi}{%g}$", pi/value);
	}
	else {
		return format("$-\frac{\uppi}{%g}$", -pi/value);
	}
}

pen ita_line = linewidth(linewidth());
pen ita_thin = linewidth(0.5*linewidth());

ticks itaFreqTicks = LeftTicks(ita_freq_ticks, ticklabel=ita_freq_label, pTick=ita_line+dotted, extend=true);
ticks itaYTicks = RightTicks(pTick=ita_line+dotted, extend=true);

picture ita_plot(string filepath, int N_channels, scaleT scale_x=Log2, scaleT scale_y=Linear, pen[] pChannel={currentpen}, 
				 Label[] legend={""}, Label label_x="", Label label_y="", ticks ticks_x=NoTicks, ticks ticks_y=NoTicks,
				 axis axis_x=BottomTop, axis axis_y=LeftRight, real size_x, real size_y=size_x, bool keepAspect=false,
				 bool add_legend=true, pair dir_legend=NE, pair align_legend=SW, filltype filltype_legend=UnFill,
				 real linelength_legend=legendlinelength, real xmargin_legend=legendmargin, int perline=1,
				 real xmin=-infinity, real xmax=infinity, real ymin=-infinity, real ymax=infinity, bool crop=NoCrop, real xlow=-infinity)
{
	file fin = input(filepath);
	
	pChannel.cyclic=true;
	
	picture plot;
	scale(pic=plot, x=scale_x, y=scale_y);
	
	real[] x;
	real[] y;
	
	for (int i_channel = 0; i_channel < N_channels; ++i_channel) {
		x = fin.line();
		y = fin.line();
		draw(pic=plot, g=graph(plot, x, y), p=pChannel[i_channel], legend=legend[i_channel]);
	}
	
	if (xlow > -infinity) {draw(pic=plot, (scale_x.T(xlow), point(pic=plot, S).y)--(scale_x.T(xlow), point(pic=plot, N).y), p=red+dashed);}
	
	//xlimits(pic=plot, min=xmin, max=xmax);
	//ylimits(pic=plot, min=ymin, max=ymax);
	limits(pic=plot, min=(xmin,ymin), max=(xmax,ymax), crop=crop);
	//crop(pic=plot);
	
	if (xmin > -infinity) {draw(pic=plot, (scale_x.T(xmin), point(pic=plot, W).y)--point(pic=plot, E), p=invisible);}
	if (xmax <  infinity) {draw(pic=plot, (scale_x.T(xmax), point(pic=plot, E).y)--point(pic=plot, W), p=invisible);}
	if (ymin > -infinity) {draw(pic=plot, (point(pic=plot, S).x, scale_y.T(ymin))--point(pic=plot, N), p=invisible);}
	if (ymax <  infinity) {draw(pic=plot, (point(pic=plot, N).x, scale_y.T(ymax))--point(pic=plot, S), p=invisible);}
	
	xaxis(pic=plot, L=label_x, xmin=xmin, xmax=xmax, axis=axis_x, ticks=ticks_x, above=false);
	yaxis(pic=plot, L=label_y, ymin=ymin, ymax=ymax, axis=axis_y, ticks=ticks_y, above=false);
	
	//xaxis(pic=plot, L="", xmin=xmin, xmax=xmax, axis=axis_x, ticks=NoTicks, above=true);
	//yaxis(pic=plot, L="", ymin=ymin, ymax=ymax, axis=axis_y, ticks=NoTicks, above=true);

	//size(pic=plot, x=size_x, y=size_y, keepAspect=keepAspect);
	size(pic=plot, xsize=size_x, ysize=size_y, point(pic=plot, SW), point(pic=plot, NE));
	
	if (add_legend) {
		add(dest=plot, src=legend(pic=plot, linelength=linelength_legend, xmargin=xmargin_legend, perline=perline), position=point(pic=plot, dir=dir_legend, user=true), align=align_legend, filltype=filltype_legend);
	}
	
	return plot;
};
