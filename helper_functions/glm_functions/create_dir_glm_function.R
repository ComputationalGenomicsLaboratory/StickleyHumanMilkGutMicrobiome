#Name: Sara Stickley
#Title: Create directories function
#Description: Function to create results directory (labeled as outcome/dependent variable) and 
#             sub directory (labeled as main covariate/independent variable) for GLM results.

#Load libraries

#Load functions

create_dir_glm_function=function(work_dir, outcome, env){
  
  #Check if there is a results directory and if not create one
  res_dir=paste0(work_dir, '/', outcome)
  if(!dir.exists(res_dir)){
    dir.create(res_dir)
  }
  
  #Check if there is a results sub-directory for env exposure and if not create
  res_sub_dir=paste0(res_dir, '/', env)
  if(!dir.exists(res_sub_dir)){
    dir.create(res_sub_dir)
  }
  
  return(res_sub_dir)
}