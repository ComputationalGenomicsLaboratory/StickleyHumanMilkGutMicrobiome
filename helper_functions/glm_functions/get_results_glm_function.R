#Name: Sara Stickley
#Title: Get GLM results function
#Description: Function to get results from GLM model, save results to dataframe, and perform P-value adjustment (i.e., multiple testing correction).

#Load libraries
library(stringr)

#Load functions

get_results_glm_function=function(mod, res_sub_dir, env, genetics, save_all_output=FALSE){
  
  #Get summary
  sum_mod=summary(mod)
  
  #Get sum df
  sum_coef_all=as.data.frame(summary(mod)[['coefficients']])
  sum_coef_all[['Covariates']]=rownames(sum_coef_all)
  rownames(sum_coef_all)=NULL
  
  #Add confidence interval
  conf_int=as.data.frame(confint(mod))
  conf_int[['Covariates']]=rownames(conf_int)
  rownames(conf_int)=NULL
  sum_coef_all=merge(sum_coef_all, conf_int, by=c('Covariates'))
  
  #Save all output files (mod, sum mod, sum mod coef all)
  if (save_all_output==TRUE){
    saveRDS(mod, paste0(res_sub_dir, '/', env, '_mod'))
    saveRDS(sum_mod, paste0(res_sub_dir, '/', env, '_sum_mod'))
    write.csv(sum_coef_all, paste0(res_sub_dir, '/', env, '_sum_coef_all.csv'))
  }
  
  #Select only covar of interest/interaction term
  if (is.null(genetics)){
    covar_row=which(str_detect(sum_coef_all[['Covariates']], env))
    sum_coef=sum_coef_all[covar_row,]
  } else {
    covar_row=which(str_detect(sum_coef_all[['Covariates']], ':'))
    sum_coef=sum_coef_all[covar_row,]
  }
  
  #Save
  if (save_all_output==TRUE){
    write.csv(sum_coef, paste0(res_sub_dir, '/', env, '_sum_coef.csv'))
  }
  
  return(sum_coef)
}