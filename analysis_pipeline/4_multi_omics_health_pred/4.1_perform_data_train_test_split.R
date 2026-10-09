#Name: Sara Stickley
#Title: Perform training/testing split of data
#Description: Perform training/testing split of data. A 70/30 train/test set split was used, with no validation set 
#             since cross-validation will be performed. 

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
#Initiate log file
sink('training_testing_split_overall.log')

###############################################################################################
#Set seed
set.seed(1)

print('Seed set to 1')

###############################################################################################
#Perform train test split

#Split data into training and testing set (70/30 split for training/testing, since using cross validation won't need validation set)
train_index=sample(seq_len(nrow(data_multi_omics)), size = floor(0.7*nrow(data_multi_omics)))

data_train=data_multi_omics[train_index,]
data_test=data_multi_omics[-train_index,]

#Save
saveRDS(data_train, 'overall_training_set.rds')

saveRDS(data_test, 'overall_testing_set.rds')

###############################################################################################
#Get list of health outcomes names
data_multi_omics=colnames(data_multi_omics)[c(8:13,15,17)]

###############################################################################################
#Check distributions of training/testing sets for each health outcome

#Loop through health outcomes
for (x in health_outcomes){
  
  print('**************************************')
  
  print(x)
  
  #Health outcome distribution all data
  print('Overall Health Outcome Distribution:')
  print(summary(na.omit(data_multi_omics[[x]])))
  
  
  #Health outcome distribution by training and testing set
  print('Overall Training Set Info:')
  print(summary(na.omit(data_train[[x]])))
  
  print('Overall Testing Set Info:')
  print(summary(na.omit(data_test[[x]])))
  
}

sink()
