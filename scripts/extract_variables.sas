/*
Hent ut alle variablene fra alle datasettene i bibliotekene skde19 og npr19
*/

proc contents data=skde19._all_ noprint
          out = data_info_skde
		  (keep = libname memname name type length label format)
;
run;


proc contents data=npr19._all_ noprint
          out = data_info_npr
		  (keep = libname memname name type length label format)
;
run;


data data_info;
set data_info_skde data_info_npr;
run;


proc sort data=data_info;
by name;
run;
