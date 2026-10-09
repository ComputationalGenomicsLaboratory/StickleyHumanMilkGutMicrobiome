#Name: Sara Stickley
#Title: Standardize or scale data function (custom paramaters)
#Description: Function to standardize or scale data based on custom mean and standard deviation.

#Load libraries

#Load functions

standardize_or_scale_custom_mean_sd_function=function(data, standardize_or_scale, data_mean=NULL, data_sd=NULL, data_min=NULL, data_max=NULL, 
                                                      scale_low = (-1), scale_high = 1){
  
  if (standardize_or_scale=='standardize'){
    
    norm_data=(data - data_mean) / data_sd
    
  } else if (standardize_or_scale=='scale'){
    
    norm_data=scale_low + ((data - data_min) / (data_max - data_min)) * (scale_high - scale_low)
    
  }
  
  return(norm_data)
  
}
