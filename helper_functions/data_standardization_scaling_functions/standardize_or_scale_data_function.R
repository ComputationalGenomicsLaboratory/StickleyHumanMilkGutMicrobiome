#Name: Sara Stickley
#Title: Standardize or scale data function
#Description: Function to standardize or scale dataset.

#Load libraries

#Load functions
source('StickleyHumanMilkGutMicrobiome/helper_functions/data_standardization_scaling_functions/standardize_or_scale_custom_mean_sd_function.R')

standardize_or_scale_function=function(data, which_data, var_dist_info, standardize_or_scale){
  
  #Create copies of dataframe for standardization and scaling
  data_standardize=data
  
  data_scale=data
  
  #Loop through variables in variable distribution info dataframe
  for (x in var_dist_info$Var){
    
    print(paste0('Starting standardization/scaling of: ', x, ' (', which_data, ')'))
    
    #Subset variable distribution info for variable of interest
    var_dist_info_temp=subset(var_dist_info, Var==x)
    
    #Get mean, sd, min, and max
    mean_temp=var_dist_info_temp$Mean
    
    sd_temp=var_dist_info_temp$SD
    
    min_temp=var_dist_info_temp$Min
    
    max_temp=var_dist_info_temp$Max
    
    if (standardize_or_scale == 'standardize'){
      
      #Perform standardization based on custom mean/SD (in variable distribution info)
      data_standardize[[x]]=standardize_or_scale_custom_mean_sd_function(data = data_standardize[[x]], standardize_or_scale = 'standardize', 
                                                                         data_mean = mean_temp, data_sd = sd_temp)
      
    } else if (standardize_or_scale == 'scale'){
      
      #Perform standardization based on mean/SD (in variable distribution info)
      data_scale[[x]]=standardize_or_scale_custom_mean_sd_function(data = data_scale[[x]], standardize_or_scale = 'scale', 
                                                                   data_min = min_temp, data_max = max_temp, 
                                                                   scale_low = (-1), scale_high = (1))
      
    }
    
  }
  
  if (standardize_or_scale == 'standardize'){
    
    return(data_standardize)
    
  } else if (standardize_or_scale == 'scale'){
    
    return(data_scale)
    
  }

}
