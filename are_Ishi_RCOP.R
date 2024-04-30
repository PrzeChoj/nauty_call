source("is_RCOP.R")

p <- 5
all_ishi_full_graphs <- all_ishi_full_graphs_p_5

allVertexPartitions <- partitions::listParts(p) # podział na kolory wierzcholkow
allEdgePartitions <- partitions::listParts(p * (p - 1) / 2) # podział na kolory krawędzi

sum_RCOP <- 0
for (i in 1:nrow(all_ishi_full_graphs)) {
  vPartition <- allVertexPartitions[[all_ishi_full_graphs[i, 1]]]
  ePartition <- allEdgePartitions[[all_ishi_full_graphs[i, 2]]]
  
  print(vPartition)
  print(ePartition)
  is_also_RCOP <- is_RCOP(vPartition, ePartition)
  print(is_also_RCOP)
  sum_RCOP <- sum_RCOP + is_also_RCOP
  cat("\n")
}
