#Name: Sara Stickley
#Title: Plot GLM function
#Description: Function to plot GLM model term of interest.

#Load libraries
library(sjPlot)

#Load functions

plot_glm_function=function(res_sub_dir, mod, env, genetics, model_type){
  
  #Set working directory
  setwd(res_sub_dir)
  
  #Get term to plot
  if (is.null(genetics)){
    plot_term=env
  } else{
    plot_term=paste0(env, ':', genetics)
  }
  
  #Plot
  jpeg(paste0(plot_term, '.jpeg'))
  p=plot_model(mod, type=model_type, terms=plot_term)
  p=p+font_size(title = 15, axis_title.x = 18, axis_title.y = 18, labels.x = 20, labels.y = 20)
  print(p)
  dev.off()
}
  


