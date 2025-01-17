
# Load libraries
library(SuperLearner)
library(cvAUC)

# Load data
setwd("/home/data/Harvard/king/ls3/covid/new/data/")
mydata <- read.csv('/home/data/Harvard/king/ls3/covid/new/data/covid_stress_vars.csv')

x <- mydata[,11:19] # These should be the 9 variables in your final model

Y <- ifelse(mydata$ls3_dxsum_30 == 1, 1, 0)

weight <- mydata$weight_lsw3_norm

# Make learners

## These are the ranger settings for your final ranger
ranger_tune <- list(num.trees = 2000,
                      max.depth = 3,
                      min.node.size = 15)

ranger_lrnr <- create.Learner('SL.ranger', tune = ranger_tune, detailed_names = T)

# Run SL
cvControl <- SuperLearner.CV.control(V=10L)

set.seed(20230503)
ranger_sl <- SuperLearner(Y = Y, X = x, family = gaussian(),
                          obsWeights = weight,
                          SL.library = ranger_lrnr$names,
                          cvControl = cvControl)

saveRDS(ranger_sl,'ranger_sl_for_cv_pred_prob.rds')

# Output CV pred probs
cv_pred_prob <- ranger_sl$Z
colnames(cv_pred_prob) <- names(ranger_sl$fitLibrary)

fold <- rep(0,nrow(x))
for(i in 1:10)
    fold[ranger_sl$validRows[[i]]] <- i

out_cv_pred <- data.frame(masterid = mydata$masterid,
                          weight_lsw3_norm2 = weight,
                          fold = fold,
                          cv_pred_prob)
write.csv(out_cv_pred,'ranger_cv_pred_prob_dxsum.csv',row.names=F)

