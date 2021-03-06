##' cor.test for all varibles
##'
##' cor.test for all varibles(each two columns)
##'
##' @param x A numeric matrix or data.frame
##' @return a data.frame with cor.test p.value and estimate
##' @author Xiaojie Sun
##' @export
##' @examples
##' x = iris[,-5]
##' cor.full(x)
##' @seealso
##' \code{\link{draw_heatmap}};\code{\link{draw_volcano}};\code{\link{draw_venn}}

cor.full <- function(x){
  ss = list()
  p = list()
  ss1 = combn(colnames(x),2)
  ss2 = apply(ss1, 2, paste,collapse =":")

  for(i in (1:ncol(ss1))){
    bt = x[,ss1[1,i]]
    kt = x[,ss1[2,i]]
    cot = cor.test(bt,kt)
    p[[i]] = c(cot$p.value,cot$estimate)
    names(p[[i]]) = c("p.value","cor")
  }
  re = do.call(cbind,p)
  colnames(re) = apply(ss1, 2, paste,collapse =":")
  return(as.data.frame(t(re)))
}



##' cor.test for one varible with all varibles
##'
##' cor.test for all varibles(each two columns)
##'
##' @param x A numeric matrix or data.frame
##' @param var your choosed varible,only one.
##' @return A data.frame with cor.test p.value and estimate
##' @author Xiaojie Sun
##' @export
##' @examples
##' x = iris[,-5]
##' cor.one(x,"Sepal.Width")
##' @seealso
##' \code{\link{draw_heatmap}};\code{\link{draw_volcano}};\code{\link{draw_venn}}

cor.one <- function(x,var){
  if(!(var %in% colnames(x))) stop(paste0(var," is not a colname of ",x,",please check it."))
  if(!all(!duplicated(colnames(x)))) stop("unique colnames is required")
  ss = list()
  p = list()
  ss1 = matrix(c(rep(var,times = (ncol(x)-1)),
                 setdiff(colnames(x),var)),
               nrow = 2,byrow = T)
  ss2 = setdiff(colnames(x),var)

  for(i in (1:ncol(ss1))){
    bt = x[,ss1[1,i]]
    kt = x[,ss1[2,i]]
    cot = cor.test(bt,kt)
    p[[i]] = c(cot$p.value,cot$estimate)
    names(p[[i]]) = c("p.value","cor")
  }
  re = do.call(cbind,p)
  colnames(re) = ss2
  return(as.data.frame(t(re)))
}



##' intersect_all
##'
##' calculate intersect  set for two or more elements
##'
##' @param ... some vectors or a list with some vectors
##' @export
##' @return vector
##' @author Xiaojie Sun
##' @examples
##' x1 = letters[1:4]
##' x2 = letters[3:6]
##' x3 = letters[3:4]
##' re =intersect_all(x1,x2,x3)
##' re2 = intersect_all(list(x1,x2,x3))
##' re3 = union_all(x1,x2,x3)
##' @seealso
##' \code{\link{geo_download}};\code{\link{draw_volcano}};\code{\link{draw_venn}}
intersect_all <- function(...){
  li = list(...)
  if(length(li)==1 & is.list(li[[1]])) li = li[[1]]
  result = li[[1]]
  for(k in 1:length(li)){
    result = intersect(result,li[[k]])
  }
  return(result)
}

##' union_all
##'
##' calculate union set for two or more elements
##'
##' @param ... some vectors or a list with some vectors
##' @export
##' @return vector
##' @author Xiaojie Sun
##' @examples
##' x1 = letters[1:4]
##' x2 = letters[3:6]
##' x3 = letters[3:4]
##' re =intersect_all(x1,x2,x3)
##' re2 = intersect_all(list(x1,x2,x3))
##' re3 = union_all(x1,x2,x3)
##' @seealso
##' \code{\link{geo_download}};\code{\link{draw_volcano}};\code{\link{draw_venn}}
union_all <-  function(...){
  li = list(...)
  if(length(li)==1 & is.list(li[[1]])) li = li[[1]]
  result = li[[1]]
  for(k in 1:length(li)){
    result = union(result,li[[k]])
  }
  return(result)
}
