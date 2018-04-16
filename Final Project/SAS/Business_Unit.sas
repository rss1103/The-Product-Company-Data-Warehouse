/* Lab-3 Business Unit */;
libname Mylib 'C:\Users\Student\Desktop\ABC';
data Mylib.SSS;
length NAME $41;
length ABBREV $41;
infile 'C:\Users\Student\Desktop\BU_inter.csv' dsd delimiter = ',' firstobs = 2 ;
input BUID$ NAME$ ABBREV$; 
run;
proc print data = Mylib.SSS;
	title 'Input from the Pentaho ';
run;



data  Mylib.SSS;
modify Mylib.SSS; 
if ABBREV = 'Chemicals' then ABBREV = 'Chemical';
if ABBREV = 'Supply' then ABBREV = 'Supplies';
run;

proc sort data = Mylib.SSS nodup;
by BUID; 
run;


proc export data=Mylib.SSS outfile='C:\Users\Student\Desktop\ABC\bu_clean.csv' dbms=dlm replace;
delimiter =',';
run;


proc print data = Mylib.SSS;
	title 'Input from the Pentaho ';
run;
