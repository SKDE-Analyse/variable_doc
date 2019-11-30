%macro extract_variables(dsn =);

/*!
Exctract all variables from dataset &dsn

Return text file

Part of code taken from 
https://chemicalstatistician.wordpress.com/2015/01/06/get-a-list-of-the-variable-names-of-a-sas-data-set/
*/

* export the variable names and their position number into a data set called "data_info";
proc contents
     data = sashelp.class
          noprint
          out = data_info
               (keep = name varnum);
run;


* sort "data_info" by "varnum";
* export the sorted data set with the name "variable_names", and keep just the "name" column;
proc sort
     data = data_info
          out = variable_names(keep = name);
     by varnum;
run;


* view the list of variables;
proc print
     data = variable_names
          noobs;
run;

%mend;