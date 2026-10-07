#Name: Sara Stickley
#Title: Get GLM formula function
#Description: Function to get GLM formula from outcome, env, genetics, and other covariates.

#Load libraries

#Load functions

get_glm_form_function=function(outcome, env, genetics, covar){
  
  #Check if there is interaction term or not and define formula
  if (is.null(genetics)){
    form=paste(outcome, '~', env)
  } else {
    form=paste(outcome, '~', env, '*', genetics)
  }
  
  #Add other covariates to formula
  for (c in covar){
    form=paste(form, '+', c)
  }
  
  return(form)
}