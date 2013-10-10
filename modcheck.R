#Function to check models 
#author: Alan haynes # 6/9/12

modcheck <- function(model, data, res.type="pearson", other=NULL, wait=TRUE){
  #Function to check models 
  #Args: model output, original data
  #Returns: not sure
  modclass <- class(model)
  
  # residuals
  res <- residuals(model, type=res.type)
  fit <- fitted(model)
  ## extract variables
  # fixed
  fixed <- as.character(terms(model)[[3]])
  fixed <- strsplit(fixed, c(" * ", " + ", ":"), fixed=TRUE)
  fix <- character()
  if(length(fixed)==1) fix <- c(fix, fixed[[1]]) else {
    for(i in 2:length(fixed)) fix <- c(fix, fixed[[i]])}
  
  
  # random
  rand <- character()
  if(modclass == "lme") rand <- c(rand, names(model$groups))
  
  if(modclass == "mer"){
    r <- as.list(ranef(model))
    rand <- c(rand, names(ranef(model)))
    for(i in 1:length(r)) if(ncol(r[[i]]) > 1) rand <- c(rand, names(r[[i]]))
    rand <- rand[rand != "(Intercept)"]
  }               
  
  
  v <- c(fix, rand, other)
  v <- unique(v)
  n <- names(data)
  m <- match(n,v)
  v <- v[m]
  v <- na.omit(v)
  
  v2 <- character(length=length(v))
  for(i in 1:length(v)){v2[i] <- class(data[,i])
                        if(v2[i] == "character") {v2[i] <- "factor"
                                                  data[,i] <- as.factor(data[,i])}
  }
  # na.action
  if(is.null(na.action(model)) == FALSE) {na.act <- na.action(model)
                                          data <- data[-na.act,]}
  
  
  factors <- data[,v[v2 == "factor"]]
  covars  <- data[,v[v2 != "factor"]]
  
  paropt <- par(c("mfrow", "ask", "mai")); on.exit(par(paropt))
  
  par(mfrow=c(1,1))
  if(wait==TRUE) par(ask=TRUE)#, mai=c(1,1,.1,.1)
  
  plot(res ~ fit, xlab="Fitted Values", ylab="Residuals")
  
  par(mfrow=c(2,2), mai=c(0.7,0.7,0.1,0.1))
  if(wait==TRUE)par(ask=TRUE)
  # col by factors
  if(length(factors) >0 ){
    if(length(names(factors))==0){ plot(res ~ fit, col= as.integer(factors))} else {
      for(i in 1: length(names(factors))){
        plot(res ~ fit,
             col=as.integer(factors[,i]),
             xlab="Fitted Values",
             ylab="Residuals",
             main=names(factors)[i])
        abline(h=0)
        mtext("Fitted", side=1, line=2)
        mtext("Residuals", side=2, line=2)
      }}}
  # col by covar
  if(length(covars) > 0){
    if(length(names(covars))==0){ plot(res ~ covars)
                                  abline(h=0)
                                  mtext("Covariate", side=1, line=2)
                                  mtext("Residuals", side=2, line=2)} else {
                                    for(i in 1: length(names(covars))){
                                      plot(res ~ covars[,i],
                                           xlab=names(covars)[i],
                                           ylab="Residuals")
                                      abline(h=0)
                                      mtext(names(covars)[i], side=1, line=2)
                                      mtext("Residuals", side=2, line=2)
                                    }}}
  # heterogeneity
  if(length(factors) >0){
    if(length(names(factors))==0){ plot(res ~ factors)} else {
      for(i in 1:length(names(factors))) {plot(res ~ factors[,i])
                                          abline(h=0)
                                          mtext(names(factors)[i], side=1, line=2)
                                          mtext("Residuals", side=2, line=2)}}}
  
  par(mfrow=c(1,2))
  plot(density(res))
  require(car)
  qqPlot(res)
  qqline(res)
}