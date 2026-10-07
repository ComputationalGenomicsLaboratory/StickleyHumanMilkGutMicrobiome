#Name: Sara Stickley
#Title: Adjust multiple testing function
#Description: Function to adjust P-values to account for multiple tests (i.e., perform multiple testing correction of P-values), 
#             using the Bonferroni or Benjamini-Hochberg correction methods.

#Load libraries
library(stringr)

#Load functions

adjust_multiple_testing_function=function(res, adjust_method, num_tests, pval_name, adjust_terms, adjust_var){
  
  #Bonferroni
  if (adjust_method=='Bonf'){
    
    #Calculate threshold
    sig_thresh=0.05/num_tests
    print(paste0('BONF ADJUSTED SIG THRESHOLD: ', sig_thresh))
    
    #Calculate adjusted p values
    res_adjust=res
    res_adjust[['P_Bonf']]=res_adjust[[pval_name]]*num_tests
    res_adjust[['P_Bonf']][res_adjust[['P_Bonf']]>=1]=1
    
    # #Check
    # adjust_test=p.adjust(res_adjust[[pval_name]][1:num_tests], method = 'bonferroni', n=num_tests)
    # 
    # check_adjust=all(adjust_test==res_adjust[['P_Bonf']][1:num_tests])
    # if(!check_adjust){
    #   stop('STOP! --> Bonferroni correction does not match')
    # }
  }
  
  #Benjamini-Hochberg
  if (adjust_method=='BH'){
    
    #Create empty df
    res_adjust=data.frame()
    
    for (x in adjust_terms){
      
      #Check if x matches name in adjust var and if not add 1 to match 1 added in GLM
      if (!(x %in% res[[adjust_var]])){
        x=paste0(x,1)
      }
      
      #Get subset df to adjust
      res_temp=res[res[[adjust_var]]==x,]
      
      #Adjust
      res_temp[['P_BH']]=p.adjust(res_temp[[pval_name]], method='BH', n=num_tests)
      
      #Add to df
      res_adjust=rbind(res_adjust, res_temp)
    }
  }
  
  #Both
  if (adjust_method=='Both'){
    
    #Bonferroni
    
    #Calculate threshold
    sig_thresh=0.05/num_tests
    print(paste0('BONF ADJUSTED SIG THRESHOLD: ', sig_thresh))
    
    #Calculate adjusted p values
    res_adjust=res
    res_adjust[['P_Bonf']]=res_adjust[[pval_name]]*num_tests
    res_adjust[['P_Bonf']][res_adjust[['P_Bonf']]>=1]=1
    
    # #Check
    # adjust_test=p.adjust(res_adjust[[pval_name]][1:num_tests], method = 'bonferroni', n=num_tests)
    # 
    # check_adjust=all(adjust_test==res_adjust[['P_Bonf']][1:num_tests])
    # if(!check_adjust){
    #   stop('STOP! --> Bonferroni correction does not match')
    # }
    
    
    #BH
    
    #Create empty df
    res_adjust2=data.frame()
    
    for (x in adjust_terms){
      
      #Check if x matches name in adjust var and if not add 1 to match 1 added in GLM
      if (!(x %in% res[[adjust_var]])){
        x=paste0(x,1)
      }
      
      #Get subset df to adjust
      res_temp=res_adjust[res_adjust[[adjust_var]]==x,]
      
      #Adjust
      res_temp[['P_BH']]=p.adjust(res_temp[[pval_name]], method='BH', n=num_tests)
      
      #Add to df
      res_adjust2=rbind(res_adjust2, res_temp)
    }
    
    res_adjust=res_adjust2
  }
    
  return(res_adjust)
}
