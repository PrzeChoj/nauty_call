# install.packages("Rcpp")

library(Rcpp)

dyn.load("C_get_orbits.so")

library(giigTests)

vPartition <- list(c(1, 2), c(3, 4))
ePartition <- list(c(1), c(3, 4), c(6))

is_RCOP <- function(vPartition, ePartition){
  my_list <- make_factor_graph_for_nauty(vPartition, ePartition)

  p <- my_list[[1]]
  lab <- my_list[[2]]
  ptn <- my_list[[3]]
  orbits <- my_list[[4]]
  edges_from <- my_list[[5]]
  edges_to <- my_list[[6]]

  num_edges <- length(edges_from)

  new_orbits <- .C("C_get_orbits",
     as.integer(p),
     as.integer(lab),
     as.integer(ptn),
     as.integer(orbits),
     as.integer(num_edges),
     as.integer(edges_from),
     as.integer(edges_to),
     result = integer(p)
  )$result

  are_the_same_orbits(orbits, new_orbits)
}

is_CROP(vPartition, ePartition)


