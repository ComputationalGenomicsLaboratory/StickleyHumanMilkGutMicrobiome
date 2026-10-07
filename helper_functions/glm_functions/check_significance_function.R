#Name: Sara Stickley
#Title: Check significance function
#Description: Function to check if any GLM results are significant prior to multiple testing correction (unadjusted P-value < specified P-value threshold).

#Load libraries
library(stringr)

#Load functions

check_significance_function=function(sum_coef, env, genetics, pval_thresh, pval_name){
  
  #Extract row with term of interest/interaction term
  if (is.null(genetics)){
    check_row=which(str_detect(sum_coef[['Covariates']], env))
    keep_row=sum_coef[check_row,]
  } else {
    check_row=which(str_detect(sum_coef[['Covariates']], ':'))
    keep_row=sum_coef[check_row,]
  }
  
  #Check if significant
  if (keep_row[[pval_name]] < pval_thresh){
    sig_check='YES'
  } else {
    sig_check='NO'
  }
  
  return(sig_check)
  
}  