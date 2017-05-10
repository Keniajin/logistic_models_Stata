	*cd "E:\Wits\BiostatisticsII\2017\icu"
***check on Applied Logistic Regression, Second Edition - Author(s): David W. Hosmer, Stanley Lemeshow

 ***Close any log file open
	cap log close

**define your log file
	log using "icu.log",text replace

***load the data	
	insheet using  "icu.csv" , clear

***mortality
	tab sta
	
***logistic sta age
	
***stepwise
*------------------------------------------------
	stepwise , pr(0.20) lockterm1: logistic sta ser age gender race  can crn inf cpr sys hra  
**selected model is
	logistic sta i.ser age  sys crn cpr
	estat ic

*****using lrdrop1
**install lrdrop1
	findit lrdrop1
****drops one variable and gives you a ll value or IC
	logistic sta ser age gender race  can crn inf cpr sys hra
	estat ic
	est store A
	lrdrop1
	
	logistic sta ser age gender   can crn inf cpr sys hra
	estat ic
	est store B
***gvselect******
***installing gvselect 
**then select  SJ-15-4 st0413  
	findit gvselect

*--------------------------------------
** nmodels(x) -- specifies the number of models to be given per level
	gvselect <term> age gender race ser can crn inf cpr sys hra, nmodels(2): logistic sta <term> i.ser
**pick the model with the lowest BIC
	logistic sta age sys i.ser
	estat ic

**with the same BIC as stepwise --similar with gvsselsct
	logistic sta age sys cpr crn i.ser
	
	
****chtest
***
**findit chest -- chagua SJ-7-2  st0124
	findit chest 
	help chest
*-------------------------------------
	logistic sta ser age gender race  can crn inf cpr sys hra  
	chest ser  , backward eform
	chest ser, eform(Odds ratio) xline(1)
	
	
*******question *** try this
	 ** question 2 pg 214
	 /*
	 Multivariable models for the
	ICU study were formed. Assess the fit of the model(s) that you feel
	was (were) best among those considered. This assessment should include
	an overall assessment of fit and use of the diagnostic statistics.
	Does the model fit? 

Are there any particular subjects, or covariate patterns, which seem to be poorly fit or overly influential? 

If so, how would you propose to deal with them?
	 
	 */
