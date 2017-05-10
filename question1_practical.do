*cd "E:\Wits\BiostatisticsII\2017\icu"
 ***Close any log file open
cap log close

**define your log file
log using "lec2lrti.log",text replace

***load the data	
use "lec2lrti.dta" , clear

***check on your data
****this doesnt make sense since its agregated data
	tab ses
	
**define the frequency weights
	tab ses [fweight=num]   
	tab ses creche [fweight=num]  if lrti==0	
	tab ses creche [fweight=num]  if lrti==1	
****association between creche and lrti
********cs var_case var_exposed
	cs lrti creche [fweight=num] ,or	
	***ignoring confounding there is an association
	
****confounding factor considered was socio-economic status
***since children attending creches in this part of Brazil tend to be from poorer families

*1) ***Dealing with confounding -- a stratified analysis
*** Pr>chi2 = 0.0685  some evidence of EM	
	cs lrti creche [fweight=num] , by(ses) 
	cs lrti creche [fweight=num] , by(ses) or	
	
	***OR --tell the difference
	mhodds lrti creche ses [fweight=num]

**2) ***Dealing with confounding --logistic regression
***** there is a difference of more than 10% after including the confounding variable 
**then the adjusted variable is a confounder
	logistic lrti  i.creche [fweight=num] 
	est store A
***stratified logistic	
	logistic lrti  i.creche  [fweight=num] if ses==1
	logistic lrti  i.creche  [fweight=num] if ses==0

****adjusting for the variable
	logistic lrti  i.creche i.ses [fweight=num] 
	est store B
	lrtest B A
	
**with interaction effect
	logistic lrti  i.creche##i.ses [fweight=num] 
	est store C
	lrtest C B
