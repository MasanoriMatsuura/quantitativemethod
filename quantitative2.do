*Stata2
*the data of relationship between food expenditure and income
use "http://stata.com/data/s4poe/food", clear
save data2.dta, replace
use data2.dta, clear
reg food_exp income
*scalar
scalar two = 1 + 1
*display the result
di "one pluse one is ="two

*Critical value
scalar tc975 = invttail(38,.025)
di "t critical value 97.5 percentile =" tc975
di "t(38) 97.5th percentile " = invttail(38,.025)

*Interval estimation
reg food_exp income

/*step2:to calculate t-value*/
scalar define tc975 = invttail(38,.025)

/*step3:to calculate upper bound and lower bound*/
scalar ub2 = _b[income] + tc975*_se[income]  /*upper bound*/
scalar lb2 = _b[income] - tc975*_se[income]  /*lower bound*/

di "beta 2 95% interval estimate is" lb2 "," ub2

*Hypothesis test
*Two tail hypothesis test
*Method1 provide p-value to calculate tvalue
 reg food_exp income  /*we must run a regression model first*/
/*step2:to calculate t-value*/
scalar tstat0 = (_b[income]-7.5)/_se[income]
di "t statistic for H0: beta2=7.5 =" tstat0
/*step3:calculate critical t-value*/
di "t(38) 99.5th percentile =" invttail(38,.005)

*Method2 provide t-value to calculate 
reg food_exp income
*to calculate t-value
scalar tstat0=(_b[income]-7.5)/_se[income]
*converse t-value to p-value
scalar phalf=ttail(38, abs(tstat0))
scalar p0=phalf*2
di "p value for two tail test H0: beta2 = 7.5 is" p0
/*Right tail hypothesis test*/
*method1 provide p-value to calculate t-value*/
reg food_exp income
scalar tstat1 = (_b[income]-5.5)/_se[income]
di "t statistic for H0: beta2=5.5 =" tstat1 
*calculate critical t-value
di "t(38) 99th percentile =" invttail(38, .01)

/*Provide t-value to calculatep-value*/
reg  food_exp income
*cvalculate p-value
scalar tstat1 = (_b[income]-5.5)/_se[income]
*calculate critical t-value
di "p value  right tail test H0: beta2 = 5.5 is" ttail(38, tstat1)

/*Left tail hypothesis test*/
reg food_exp income
*to calculate t-value*
scalar tstat1 = (_b[income]-15)/_se[income]
di "t statistic for H0: beta2=15 =" tstat1
*calculate critical t-value*
di "t(38) 99th percentile =" invttail(38, .99)

/* to get the report directly */
*method1
reg food_exp income
*get the report
lincom income - 15
*method2
reg food_exp income
*get the report
test income=15
test (_b[income]=15)