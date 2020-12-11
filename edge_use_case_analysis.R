## EDGE USE CASE CLUSTERS
# SELF- AND SUPER-ORGANIZING MAPS IN EDGE COMPUTING USE CASES
## R Source Code - Ryan Anderson 
## Playing around with supervised pattern recognition, and self organizing maps 

#install.packages("kohonen") / install.packages("diffusionMap")
library("kohonen")  # Load the kohonen package

# set, get and check directory
setwd("/Users/ryananderson/CODE/edge_use_case_analysis")
getwd()

# Wardrobe
pretty_palette <- c("#1f77b4", '#ff7f0e', '#2ca02c', '#d62728', '#9467bd', '#8c564b', '#e377c2')
coolBlueHotRed <- function(n, alpha = 1) {rainbow(n, end=4/6, alpha=alpha)[n:1]}

# import raw data from CSV (wiill drop some columns later)
raw_data <- read.csv("Edge Use Cases - Master List.csv")

head(raw_data) ## what have we got?

# drop the non numerical
data <- ((raw_data[3:9])) 
head(data)
dim(data)

## make sector NUMERIC
data.sc <- scale(data)
head(data.sc)  #  let's have  a  peek
set.seed(7)

## TEST - Edge Use Cases - full size
data.som <- som(data.sc, grid = somgrid(4, 4, "hexagonal"))
plot(data.som, main = "Edge Use Cases")

### LETS do a 1 by 2 
par(mfrow=c(1,2))
plot(data.som, main = "Edge Use Cases \n Attributes")
plot(data.som, type="count", main="Edge Use Cases \n # Use Cases Per Node \n")
## plot(data.som, type="dist.neighbours") # often referred to as the U-Matrix, this visualisation is of the distance between each node and its neighbours. 

 
##################
### LETS do a 2 by 2 Grid -  Dashboard like
par(mfrow=c(2,2))

# plot 1 - hexagonal
plot(data.som, main = "Edge Use Cases \n Attributes")

# plot 2 - new color and square
som_grid <- somgrid(xdim = 4, ydim=4, topo="rectangular")
data.som <- som(data.sc,  grid = som_grid)
plot(data.som, palette.name = coolBlueHotRed, main = "Edge Use Case Segmentation")

# plot 3
plot(data.som, type="count", main="Edge Use Cases \n # Use Cases Per Node")

# plot 4
plot(data.som, type="dist.neighbours") # often referred to as the U-Matrix, this visualisation is of the distance between each node and its neighbours. 
###
################## WORKS ABOVE HERE

## Test Below

# --- working

## Test Above
  
# ref: http://www.r-bloggers.com/self-organising-maps-for-customer-segmentation-using-r/

### NOT WORKING BELOw here

### OK - Let's play with Diffusion Map
library("diffusionMap")

D = dist(scale(data)) # use Euclidean distance on data (no index)
## DIST: This function computes and returns the distance matrix computed by using the specified distance measure to compute the distances between the rows of a data matrix.

head(D)
dmap = diffuse(D,eps.val=10, t=100, neigen=2) 
head(dmap)
plot(dmap$X[,1],dmap$X[,2],
     xlab="Diffusion Map Coordinate 1", ylab="Diffusion Map Coordinate 2",
     main="Diffusion Map of Use Cases")
