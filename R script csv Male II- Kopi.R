library(igraph)
setwd("~/Dropbox/#PHD/DATA ANALYSIS/R/Egtved Contemporaries")
#Above is mac wd.For windows use setwd("C:/Users/Lofel/Dropbox/#PHD/DATA ANALYSIS/R/Egtved Contemporaries")
data <- read.csv("Male per II.csv", header = TRUE, row.names = 1, sep = ";")
incidencegraph <- graph_from_incidence_matrix(data)
burial.bp <- bipartite.projection(incidencegraph)
burial.bp

plot(burial.bp$proj1, vertex.label.color="black", vertex.label.dist=1, vertex.size=5, edge.width = 0.1)
plot(burial.bp$proj2, vertex.label.color="black", vertex.label.dist=1.5, vertex.size=2)
cfg1 <- cluster_fast_greedy(burial.bp$proj1)
cfg2 <- cluster_fast_greedy(burial.bp$proj2)
dendPlot(cfg1, mode="hclust")
dendPlot(cfg2, mode="hclust")
plot(cfg1, burial.bp$proj1)
plot(cfg2, burial.bp$proj2)

# Get adjacency matrix out of the incidence graph
# using  get.adjacency(incidencegraph, type=c("both"), attr="NULL", names=TRUE, sparse=FALSE) 

adj_burial <- get.adjacency(incidencegraph, type= "both")
adj_burial

# convert the matrix (dgcMatrix)) into a dataframe, need the tidyverse library for pipes
install.packages("tidyverse")
library(tidyverse)

a_burial <- adj_burial %>% 
  as.matrix %>%
  as.data.frame
write.csv(a_burial,"output/Adjacency.csv") # generates a csv with adjacency in "output" folder in your WD
