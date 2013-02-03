import graph;
import ita;

usepackage("fdda_all");

pen[] pChannels = {red, blue};
Label[] legende = {Label("Channel 1", black), Label("Channel 2", black)};

//draw(magnitude, (2, ita_ymin)--(2, ita_ymax), invisible);

Label label_x = Label("$\mathrm{Frequency}$", MidPoint);
Label label_y = "$\up{Re}\{\zeta\}$";

picture pic1 = ita_plot(filepath="test.data", N_channels=2, pChannel=pChannels, legend=legende, 
						size_x=14cm, size_y=5cm, linelength_legend=0.5cm, xmargin_legend=3pt,
						dir_legend=SE, align_legend=NW, ticks_x=itaXTicks, ticks_y=itaYTicks);

frame f1 = pic1.fit();
add(f1);
