#Name: Sara Stickley
#Title: Fix results table function
#Description: Function to fix final results table (i.e., reorder and rename some columns).

#Load libraries

#Load functions

fix_result_table_function=function(res, adjust_yes, adjust_method){
  
  #Rearrange results
  if(adjust_yes==TRUE){
    if(adjust_method=='Both'){
      res=res[,c(8,1,5,9,10,2,3,4,6,7)]
    }else{
      res=res[,c(8,1,5,9,2,3,4,6,7)]
    }
    
  }else{
    res=res[,c(8,1,5,2,3,4,6,7)]
  }
  
  #Rename p value
  res=res[order(res[,3]),]
  
  #Sort by p value
  colnames(res)[3]='P_unadj'
  
  return(res)
}