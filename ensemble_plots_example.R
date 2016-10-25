######################################
# 01.10.2016
# Emsemble plots example
# BISC 481
######################################

# Initialization
library(DNAshapeR)

# Extract sample sequences
fn <- "/Users/farahnajib/Downloads/BISC481-master/CTCF/bound_500.fa"

# Predict DNA shapes
pred <- getShape(fn)

# Generate ensemble plots
plotShape(pred$MGW) ## Used this line to generate ensemble plots for MGW, HelT, and ProT
heatShape(pred$ProT, 20) ## This was an alternative to using the above line; I did not use it
