/*Quantitative 4*/
cd C:\Users\mm_wi\Documents\ntu_agecon\qunatitative
use ch10.dta, clear
save quantitative4.dta, replace
use quantitative4.dta

sum
*Hausman test
*Step1:First stage
reg x z1 z2
predict vhat, residuals

di vhat

*Step2: Second stage
reg y x vhat

*Estimation: 2sls
ivregress 2sls y (x=z1), small

*Weak IV
ivregress 2sls y (x=z1), small
estat firststage