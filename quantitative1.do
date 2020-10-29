//Quantitative methods STATA practice
*use "http://fmwww.bc.edu/ec-p/data/wooldridge/bwght" // open data file, or an online resource

*this data is about birth weight*

*insheet using "" // improt excel or csv

*infile y x1 x2 x3 using "" // txt file with spaces

*infix id 1-2 eng 3-4 math 5-6 sex 7 micro 8-9 macro 10-11 using [data.txt] // without spaces

sysuse auto // US car industry data
count //to count the numbers of rows

describe //to list the information of the data

list //to list every observation on the window

br // difference of br and list is that br is used to check data on another page.

codebook // to look the details of every variables

sum // to culculate the descriptive statistics

sum price weight, detail // more information with detail

tab price //frequency

tab price weight // cross table of two variables

tabulate 

tabstat price // culculate the mean 

sum weight if price >= 4000

sum weight if price==4000 // we should put double =

sum in 1/50 // to sum row 1~50

sum in 1/50, detail //to sum row 1~50 and view the distribution

gen turn1=log(turn) // to create a new variable

des

drop displacement headroom //to drop variables

keep mpg weight price // keep variables

rename mpg m //rename variables
rename weight w
rename price p

describe m w p

//to merge data horizontally
*step1: sort data1
*use[data1]
*sort [common var]
*save[data1], replace
*use[data2], clear
*sort[common var]
*save[data2], replace
*use[data1]
*merge[var] using[data2]


reg p w m 

twoway (scatter p w)(lfit p w) // scatter plot with line
 
twoway (scatter p w) // scatter plot
histogram p, percent // with percentage

graph box p w m //vertical box plot

graph hbox p w // horizontal box plot

stem p 

help[stem]



