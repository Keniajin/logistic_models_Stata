***set working directory
cd "F:\Tutoring\bio 2"
***save in a log file
log using "F:\Tutoring\bio 2\question2.log",text replace

***loading data
use "F:\Tutoring\bio 2\prostate.dta", clear

***checking for association between exposure and outcome
tab xray nodal, row chi2
tab size nodal , row chi2
tab grade nodal , row chi2
***generate log transformed acid
gen acid2=log( acid)

***univariate logistic
logistic nodal age
logistic nodal acid
logistic nodal i.xray
logistic nodal i.size
logistic nodal i.grade

logistic nodal acid2

***stepwise-backward approach
xi: stepwise, pr(0.10) : logistic nodal age acid xray size grade acid2


***multivariate analysis
logistic nodal acid2 i.size i.xray
est store A
logistic nodal acid2 i.size i.xray age
est store B
lrtest A B
logistic nodal acid2 i.size i.xray i.grade
est store C
lrtest A C
logistic nodal acid2 i.size i.xray i.grade age
est store D
lrtest A D

****checking for interaction
logistic nodal acid2 i.size i.xray i.grade xray# grade
est store E
lrtest A E
logistic nodal acid2 i.size i.xray i.grade size# grade
est store F
lrtest A F


***final model
logistic nodal acid2 i.size i.xray i.grade size# grade
