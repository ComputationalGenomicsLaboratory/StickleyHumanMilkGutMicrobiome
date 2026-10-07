#Name: Sara Stickley
#Title: Subset data by covariates function
#Description: Function to subset data by covariates of interest (including subject ID) and remove NAs from dataframe.

#Load libraries

#Load functions

subset_data_by_covars_function=function(data, outcome, env, genetics, covar){
  
  #Create list of all covariates
  covar_all=c('FID', outcome, env, genetics, covar)
  
  #Subset data by all covariates
  data=data[,c(covar_all)]
  
  #Remove all NAs
  data=na.omit(data)
  
  return(data)
}