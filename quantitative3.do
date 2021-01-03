use "http://stata.com/data/s4poe/food", clear
*1.1 Graph treatment
reg food_exp income
predict ehat, residual

twoway(scatter ehat income)
*1.2 White test
*1.2.1 Statistics
*1.2.2 White test method1
reg food_exp income
predict ehat, residual

gen ehat2=ehat^2
gen inc2 = income^2

reg ehat2 income inc2

scalar LM = e(N)*e(r2)
dis chi2tail(2,LM)

/*pvalue =  .02287893

.02287893 < .05 reject h0, there is Heteroskedasticity.*/
*1.2.3 White test method2
reg food_exp income
estat imtest, white
*1.3 B-P test
*1.3.2 B-P test Method2
reg food_exp income
estat hettest income, iid
*1.4- G-QTest
*1.4.2 Code
sort income

reg food_exp income in 1/20
	scalar s_small = e(rmse)^2
	scalar df_small = e(df_r)

reg food_exp income in 21/40
	scalar s_large = e(rmse)^2
	scalar df_large = e(df_r)

scalar GQ = s_large/s_small
dis Ftail(df_large,df_small,GQ)

/*result

.00459644

.00459644 < 0.05, reject H0, there is heteroskedasticity.*/
*2.1 White's Robust Standard Error
*2.1.1 Fixed Standard Error
reg food_exp income, vce(robust)
*2.2 General Least Squares (GLS)
*2.2.1 Assumption
*2.2.1 Method1 Data Transformation
gen income_new = income^(-1)
gen food_exp_new = food_exp/income

reg food_exp_new income_new
*2.2.1 Method1 Weighted Regression
reg food_exp income [aweight = 1/income]
*2.3 Feasible General Least Squares
*2.3.1 Estimate h
reg food_exp income
predict ehat, residual

gen lnehat = log(ehat^2)
gen x_ = log(income)

reg lnehat x_

reg food_exp income [aweight =income^-(_b[x_])/2]