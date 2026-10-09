#Name: Sara Stickley
#Title: Perform training/testing split of data
#Description: Perform training/testing split of data by each health outcome. A 70/30 train/test set split was used, 
#             with no validation set since cross-validation will be performed. 

###############################################################################################
rm(list=ls())       #Remove all objects from current workspace (R memory)

#Set as working directory
setwd("StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred")

#Load libraries
library(caret)

#Load functions

###############################################################################################
#Read data multi-omics data (health outcomes, gut microbes, human milk components, prs, and covariates)
#Note: binary variables in dataframe are already factored
#data_multi_omics=readRDS('ADD_PATH_TO_DATA')
head(data_multi_omics)
dim(data_multi_omics)

###############################################################################################
#Get list of health outcomes names
data_multi_omics=colnames(data_multi_omics)[c(8:13,15,17)]

###############################################################################################
#Initiate log file
sink('training_testing_split_by_health_outcome.log')

###############################################################################################
#Set seed
set.seed(1)

print('Seed set to 1')

###############################################################################################
#Loop through health outcomes
for (x in health_outcomes){
  
  print('**************************************')
  
  print(x)
  
  #Remove NAs from health outcome
  data_temp=data_multi_omics[!is.na(data_multi_omics[[x]]),]
  
  print('Overall Health Outcome Distribution:')
  print(summary(data_temp[[x]]))

  #Split data into training and testing set (70/30 split for training/testing, since using cross validation won't need validation set)
  train_index=createDataPartition(data_temp[[x]], p = 0.7, list = FALSE)
  
  data_train=data_temp[train_index,]
  data_test=data_temp[-train_index,]
  
  print('Overall Training Set Info:')
  print(summary(data_train[[x]]))
  
  print('Overall Testing Set Info:')
  print(summary(data_test[[x]]))
  
  
  #Save
  saveRDS(data_train, paste0('training_data/', x, '_training_set.rds'))
  
  saveRDS(data_test, paste0('testing_data/', x, '_testing_set.rds'))

}

sink()
