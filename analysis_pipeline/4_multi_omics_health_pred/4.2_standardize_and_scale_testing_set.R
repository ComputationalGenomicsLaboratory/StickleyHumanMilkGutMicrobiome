#Name: Sara Stickley
#Title: Standardize/scale testing set
#Description: Standardize/scale testing set based on continuous variable distribution 
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
#Read testing set
data_test=readRDS('StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred/overall_testing_set.rds')
data_test[1:5,1:5]
dim(data_test)

###############################################################################################
#Read training set continuous variable distribution info (i.e., mean, sd, min, max, etc.)
cont_var_dist_info=read.csv('StickleyHumanMilkGutMicrobiome/analysis_pipeline/4_multi_omics_health_pred/continuous_var_dist_info_training_set.csv')
head(cont_var_dist_info)
dim(cont_var_dist_info)

###############################################################################################
#Standardize data
data_test_standardized=standardize_or_scale_function(data = data_test, which_data = 'Testing set', var_dist_info = cont_var_dist_info, 
                                                     standardize_or_scale = 'standardize')
data_test_standardized[1:5,1:5]
dim(data_test_standardized)

#Check all means are 0 and SD are 1 --> NO BECAUSE TRAINING SET PARAMATERS USED FOR TESTING SET
all(round(sapply(data_test_standardized[,cont_var_dist_info$Var], mean, na.rm=TRUE), 5) == 0)
#[1] FALSE

all(round(sapply(data_test_standardized[,cont_var_dist_info$Var], sd, na.rm=TRUE), 5) == 1)
#[1] FALSE

###############################################################################################
# #Scale
# data_test_scaled=standardize_or_scale_function(data = data_test, which_data = 'Testing set', var_dist_info = cont_var_dist_info, 
#                                                 standardize_or_scale = 'scale')
# data_test_scaled[1:5,1:5]
# dim(data_test_scaled)
# 
# #Check all mins are -1 and maxs are 1 --> NO BECAUSE TRAINING SET PARAMATERS USED FOR TESTING SET
# all(round(sapply(data_test_scaled[,cont_var_dist_info$Var], min, na.rm=TRUE), 5) == (-1))
# #[1] FALSE
# 
# all(round(sapply(data_test_scaled[,cont_var_dist_info$Var], max, na.rm=TRUE), 5) == 1)
# #[1] FALSE

###############################################################################################
#Save
saveRDS(data_test_standardized, 'data_testing_standardized.rds')

# saveRDS(data_test_standardized, 'data_testing_scaled.rds')
