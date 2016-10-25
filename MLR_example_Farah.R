######################################
# 12.10.2016
# Multiple Linear Regression (MLR) example
# BISC 481
######################################

## Install packages
# Bioconductor
source("https://bioconductor.org/biocLite.R")
biocLite() 
# DNAshapeR
biocLite("DNAshapeR")
# Caret
install.packages("caret")

## Initialization
library(DNAshapeR)
library(caret)
workingPath <- "/Users/farahnajib/Downloads/BISC481-master/gcPBM/"
## Had to change the name of the above working path so that it would 
## work on my computer

## Predict DNA shapes
fn_fasta <- paste0(workingPath, "Max.txt.fa") ## I modified this line according to whether I wanted information for Mad, Myc, or Max
pred <- getShape(fn_fasta)

## Encode feature vectors
featureType <- c("1-mer") ## I changed this depending on whether I just wanted the R-squared for the sequence, 1mer, or the sequence and the shape, 1mer+shape
featureVector <- encodeSeqShape(fn_fasta, pred, featureType)
head(featureVector)

## Build MLR model by using Caret
# Data preparation
fn_exp <- paste0(workingPath, "Max.txt") ## Also needed to change this if I wanted to work with Mad, Myc, or Max
exp_data <- read.table(fn_exp)
df <- data.frame(affinity=exp_data$V2, featureVector)

# Arguments setting for Caret
trainControl <- trainControl(method = "cv", number = 10, savePredictions = TRUE)

# Prediction without L2-regularized
model <- train (affinity~ ., data = df, trControl=trainControl, 
                method = "lm", preProcess=NULL)
summary(model)

# Prediction with L2-regularized
model2 <- train(affinity~., data = df, trControl=trainControl, 
               method = "glmnet", tuneGrid = data.frame(alpha = 0, lambda = c(2^c(-15:15))))
model2
result <- model2$results$Rsquared[1]


