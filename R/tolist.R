#' List of EVs
#'
#' @description
#' A sub-function used by \code{\link{compile.vars}}.
#'
#' @param regimes The flow regimes list from \code{\link{compile.vars}}
#' @param regm.indx The index to which flow regime is to be used
#' @param vars The number of variables in a candidate model
#' @param ranges The ranges index list corresponding to regimes
#' @param leaps_list Output from \code{\link{compute.leaps.for}}
#'
#' @details
#' Lorem ipsum...
#'
#' @return A list of subsets of EVs (y), their ranks (rank),
#' and the full set of EVs for each quantile
#'@export
tolist <-function(regimes, regm.indx, vars, ranges, leaps_list){
  # Function orginially designed by Tom Over and Mike Olson, 03 July 2015.
  # Modified by William Farmer, 06 July 2015.
  # Modified by TMO, 6/2016, to remove hardwiring of regime breaks
  #  and change parameter names
  # Implemented by Amy Russell, 9/2016

  names = regimes[[regm.indx]] #added by TMO, 6/2016
  range = ranges[[regm.indx]] #added by TMO, 6/2016
  ioffset <- range[1]-1 #Added by TMO, 6/2016 - to replace "if(names[1]=="0.XX") conditions below
  rank = list()
  y = list()
  for(i in range){
    xt = leaps_list[[i]][[vars]]
    #order models by R^2
    xt=xt[,order(xt[2,], decreasing=T)]
    ### WHF, 07/06/2015: Added to avoid case without candidate models.
    if(is.vector(xt)) {
      # if(names[1]=="0.0002") {
      #   ndx <- i
      # }
      # if(names[1]=="0.2") {
      #   ndx <- i - 9
      # }
      # if(names[1]=="0.95") {
      #   ndx <- i-19
      # }
      ndx <- i-ioffset  #Added by TMO, 6/2016
      rank[[ndx]] <- NA
      y[[ndx]] <- NULL
      saveForOut <- as.character(xt[((1:((length(xt)-1)/3))*3+1)])
      next
    }
    saveForOut <- as.character(xt[((1:((length(xt[,1])-1)/3))*3+1),1])
    #Create model ranks
    # if(names[1]=="0.0002") rank[[i]] = c((ncol(xt)-1):1)
    # if(names[1]=="0.2") rank[[i-9]] = c((ncol(xt)-1):1)
    # if(names[1]=="0.95") rank[[i-19]] = c((ncol(xt)-1):1)
    rank[[i-ioffset]] = c((ncol(xt)-1):1) #Added by TMO, 6/2016
    xt = xt[((1:((length(xt[,1])-1)/3))*3+1), 1:length(xt[1,])]
    if (ncol(xt)>2) {
      xt[,-1] = apply(xt[,-1], 2, as.numeric)
    } else {
      xt[,2] <- as.numeric(xt[,2])
    }
    temp = array(" ", dim = c(vars, (length(xt[1,])-1)))
    #extract variable names for each predictor variable in each model
    for(j in 1:(length(xt[1,])-1)){
      temp[,j] = as.character(xt[c(which(!is.na(xt[,j+1])))[-1],1])
    }
    #correct for different indices for each flow regime
    # if(names[1]=="0.0002") y[[i]] = temp
    # if(names[1]=="0.2") y[[i-9]] = temp
    # if(names[1]=="0.95") y[[i-19]] = temp
    y[[i-ioffset]] = temp
  }
  return(list(y, rank, saveForOut))
}
