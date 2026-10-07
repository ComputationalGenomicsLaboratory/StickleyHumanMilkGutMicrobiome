#Name: Sara Stickley
#Title: GLM interaction function
#Description: Function to perform logistic/linear regression with an interaction term.
  
#Load libraries
library(stringr)

#Load functions
source('~/2_PhD/UTILITIES/glm_functions/create_dir_glm_function.R')
source('~/2_PhD/UTILITIES/glm_functions/subset_data_by_covars_function.R')
source('~/2_PhD/UTILITIES/glm_functions/get_glm_form_function.R')
source('~/2_PhD/UTILITIES/glm_functions/get_results_glm_function.R')
source('~/2_PhD/UTILITIES/glm_functions/check_significance_function.R')
source('~/2_PhD/UTILITIES/glm_functions/plot_glm_function.R')

glm_interaction_function=function(work_dir, data, outcome, env, genetics, covar, glm_family, pval_name, adjust_yes, num_tests, pval_thresh, model_type, save_all_output, plot_yes){
  
  #Set working directory
  res_sub_dir=create_dir_glm_function(work_dir = work_dir, outcome = outcome, env = env)
  
  #Subset data by covariates
  data=subset_data_by_covars_function(data = data, outcome = outcome, env = env, genetics = genetics, covar =covar)
  
  #Get glm formula
  form=get_glm_form_function(outcome = outcome, env =env, genetics = genetics, covar = covar)
  
  #Perform glm fit
  mod=glm(formula = form, data = data, family = glm_family, na.action = 'na.fail')
  
  #Get results, adjust for multiple testing, and save results
  sum_coef=get_results_glm_function(mod = mod, res_sub_dir = res_sub_dir, env = env, genetics = genetics, save_all_output=FALSE)
  
  #Check if significant (before multiple test correction)
  sig_check=check_significance_function(sum_coef = sum_coef, env = env, genetics = genetics, pval_thresh = pval_thresh, pval_name = pval_name)
  
  #If significant plot
  if (sig_check=='YES' & plot_yes==TRUE){
    plot_glm_function(res_sub_dir = res_sub_dir, mod = mod, env = env, genetics = genetics, model_type = model_type)
  }
  
  return(sum_coef)
}
