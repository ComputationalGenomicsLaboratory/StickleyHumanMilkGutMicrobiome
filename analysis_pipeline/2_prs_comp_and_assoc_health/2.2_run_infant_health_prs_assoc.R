#Name: Sara Stickley
#Title: Run infant health PRS association
#Description: Run infant health PRS association using logistic regression (with glm helper functions) to identify 
#             associations between infant health outcomes & respective disease polygenic risk scores (PRS).

###############################################################################################
rm(list=ls())       #Remove all objects from current workspace (R memory)

#Set working directory
setwd("StickleyHumanMilkGutMicrobiome/analysis_pipeline/2_prs_comp_and_assoc_health")

#Load libraries

#Load functions
source('StickleyHumanMilkGutMicrobiome/helper_functions/glm_functions/run_glm_function.R')

###############################################################################################
#Read dataframe (dataframe with subject IDs, infant health outcomes, PRSs, and other covariates)
#Note: binary variables in dataframe are already factored
#data_infant_health_prs=readRDS('ADD_PATH_TO_DATA')
head(data_infant_health_prs)
dim(data_infant_health_prs)

###############################################################################################
#Get function arguments for GLM (ones that are long)
work_dir='StickleyHumanMilkGutMicrobiome/analysis_pipeline/2_prs_comp_and_assoc_health'

covar=c('PC1', 'PC2', 'PC3', 'PC4', 'PC5', 'PC6', 'PC7', 'PC8', 'PC9', 'PC10', 'infant_sex')

#Get list of microbes
infant_health=colnames(data_infant_health_prs)[c(2,4,18,19,20,31)]

#Get list of prs
prs=c('PIVIDORI_GRS_ELIZABETH', 'FERREIRA_GRS_ELIZABETH')

###############################################################################################
#Run GLM (PRS)
res_glm_infant_health_prs=run_glm_function(outcome_list = infant_health, env_list = prs, work_dir = work_dir, 
                                           data = data_infant_health_prs, genetics = NULL, covar = covar, glm_family = 'binomial', 
                                           pval_name = 'Pr(>|z|)', adjust_yes = FALSE, adjust_method = 'Bonf', 
                                           num_tests = NULL, pval_thresh = 0.05, model_type = 'pred', 
                                           adjust_terms = NULL, adjust_var = 'Covariates',
                                           save_all_output=FALSE)
#head(res_glm_infant_health_prs)
dim(res_glm_infant_health_prs)     #168   8

#Save
write.csv(res_glm_infant_health_prs, 'StickleyHumanMilkGutMicrobiome/analysis_pipeline/2_prs_comp_and_assoc_health/res_prs_health.csv', row.names = FALSE)
