#Name: Sara Stickley
#Title: Get continuous variable distribution information from training set
#Description: Get continuous variable distribution information from training set for 
#             standardization/scaling (i.e., mean, sd, min, max, etc.).

###############################################################################################
rm(list=ls())       #Remove all objects from current workspace (R memory)

#Set as working directory
setwd("StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred")

#Load libraries

#Load functions

###############################################################################################
#Read training data
data_train=readRDS('StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred/overall_training_set.rds')
data_train[1:5,1:5]
dim(data_train)

###############################################################################################
#Select continuous variable columns to standardize or min/max scale (not including subject ID)
col_to_fix=which(sapply(data_train, is.numeric))

###############################################################################################
#Subset by these continuous variables
data_train_continuous=data_train[c(col_to_fix)]
data_train_continuous[1:5,1:5]
dim(data_train_continuous)

###############################################################################################
#Get info from continuous variables for standardization/scaling

#Create empty df
var_dist_info=data.frame()

#Loop through continuous variables to be standardized/scaled (begining at column 2 to exclude subject ID)
for (x in colnames(data_train_continuous[c(2:ncol(data_train_continuous))])){
  
  print(x)
  
  #Get mean
  var_mean=mean(data_train_continuous[[x]], na.rm = TRUE)
  
  #Get SD
  var_sd=sd(data_train_continuous[[x]], na.rm = TRUE)
  
  #Get min
  var_min=min(data_train_continuous[[x]], na.rm = TRUE)
  
  #Get max
  var_max=max(data_train_continuous[[x]], na.rm = TRUE)
  
  #Create df with vars
  var_dist_info_temp=data.frame(Var=x, Mean=var_mean, SD=var_sd, Min=var_min, Max=var_max)
  
  #Add to df
  var_dist_info=rbind(var_dist_info, var_dist_info_temp)
  
}

###############################################################################################
#Save
write.csv(var_dist_info, 'continuous_var_dist_info_training_set.csv', row.names = FALSE)
