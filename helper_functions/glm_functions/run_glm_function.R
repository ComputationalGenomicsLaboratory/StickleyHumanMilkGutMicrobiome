#Name: Sara Stickley
#Title: Run GLM Function
#Description: Function to run logistic/linear regression analysis, with/without interaction term, for multiple outcomes/dependent variables 
#             and/or multiple covariates/independent variables and create a results summary dataframe.

#Load libraries
library(stringr)
library(sjPlot)

#Load functions
source('~/2_PhD/UTILITIES/glm_functions/glm_function.R')
source('~/2_PhD/UTILITIES/glm_functions/glm_interaction_function.R')
source('~/2_PhD/UTILITIES/glm_functions/adjust_multiple_testing_function.R')
source('~/2_PhD/UTILITIES/glm_functions/fix_results_table_function.R')

run_glm_function=function(outcome_list, env_list, work_dir, data, genetics, covar, glm_family, pval_name, adjust_yes, adjust_method, num_tests, pval_thresh, model_type, adjust_terms, adjust_var, save_all_output=FALSE, plot_yes=TRUE){
  
  #Create empty df for results
  glm_res=data.frame()
  
  #Check if glm_function or glm_interaction_function
  if (is.null(genetics)){
    
    #Run glm
    for (y in outcome_list){
      for (x in env_list){
        sum_coef=glm_function(work_dir = work_dir, data = data, outcome = y, env = x, genetics = NULL, covar = covar, glm_family = glm_family, pval_name = pval_name, 
                              adjust_yes = adjust_yes, num_tests = num_tests, pval_thresh = pval_thresh, model_type = model_type, save_all_output, plot_yes)
        print(paste(y, '~', x))
        
        #Add column with outcome
        sum_coef[['Outcome']]=y
        
        #Add to df
        glm_res=rbind(glm_res, sum_coef)
      }
    }
    
  } else {
    
    #Run glm interaction
    for (y in outcome_list){
      for (x in env_list){
        sum_coef=glm_interaction_function(work_dir = work_dir, data = data, outcome = y, env = x, genetics = genetics, covar = covar, glm_family = glm_family, pval_name = pval_name, 
                              adjust_yes = adjust_yes, num_tests = num_tests, pval_thresh = pval_thresh, model_type = model_type, save_all_output, plot_yes)
        print(paste(y, '~', x, '*', genetics))
        
        #Add column with outcome
        sum_coef[['Outcome']]=y
        
        #Add to df
        glm_res=rbind(glm_res, sum_coef)
      }
    }
    
  }
  
  #Adjust for multiple testing
  if(adjust_yes==TRUE){
    glm_res_adjust=adjust_multiple_testing_function(res = glm_res, adjust_method = adjust_method, num_tests = num_tests, pval_name = pval_name, adjust_terms = adjust_terms, adjust_var = adjust_var)
  }
  
  #Fix res table
  if(adjust_yes==TRUE){
    glm_res_final=fix_result_table_function(res = glm_res_adjust, adjust_yes = adjust_yes, adjust_method = adjust_method)
  }else{
    glm_res_final=fix_result_table_function(res = glm_res, adjust_yes = adjust_yes)
  }
  
  return(glm_res_final)
}
