#Name: Sara Stickley
#Title: Standardize/scale training set
#Description: Standardize/scale training set based on continuous variable distribution 
#             information (i.e., mean, sd, min, max, etc.) from training set.

###############################################################################################
rm(list=ls())       #Remove all objects from current workspace (R memory)

#Set as working directory
setwd("StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred")

#Load libraries

#Load functions
source('StickleyHumanMilkGutMicrobiome/helper_functions/data_standardization_scaling_functions/standardize_or_scale_data_function.R')

###############################################################################################
#Set seed
set.seed(1)

###############################################################################################
#Read training set
data_train=readRDS('StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred/overall_training_set.rds')
data_train[1:5,1:5]
dim(data_train)

###############################################################################################
#Read training set continuous variable distribution info (i.e., mean, sd, min, max, etc.)
cont_var_dist_info=read.csv('StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred/continuous_var_dist_info_training_set.csv')
head(cont_var_dist_info)
dim(cont_var_dist_info)

###############################################################################################
#Standardize data
data_train_standardized=standardize_or_scale_function(data = data_train, which_data = 'Training set', var_dist_info = cont_var_dist_info, 
                                                      standardize_or_scale = 'standardize')
data_train_standardized[1:5,1:5]
dim(data_train_standardized)

#Check all means are 0 and SD are 1 --> YES BECAUSE TRAINING SET PARAMATERS USED FOR TRAINING SET
all(round(sapply(data_train_standardized[,cont_var_dist_info$Var], mean, na.rm=TRUE), 5) == 0)
#[1] TRUE

all(round(sapply(data_train_standardized[,cont_var_dist_info$Var], sd, na.rm=TRUE), 5) == 1)
#[1] TRUE

###############################################################################################
# #Scale
# data_train_scaled=standardize_or_scale_function(data = data_train, which_data = 'Training set', var_dist_info = cont_var_dist_info, 
#                                                 standardize_or_scale = 'scale')
# data_train_scaled[1:5,1:5]
# dim(data_train_scaled)
# 
# #Check all mins are -1 and maxs are 1 --> YES BECAUSE TRAINING SET PARAMATERS USED FOR TRAINING SET
# all(round(sapply(data_train_scaled[,cont_var_dist_info$Var], min, na.rm=TRUE), 5) == (-1))
# #[1] TRUE
# 
# all(round(sapply(data_train_scaled[,cont_var_dist_info$Var], max, na.rm=TRUE), 5) == 1)
# #[1] TRUE

###############################################################################################
#Save
saveRDS(data_train_standardized, 'data_training_standardized.rds')

# saveRDS(data_train_standardized, 'data_training_scaled.rds')
