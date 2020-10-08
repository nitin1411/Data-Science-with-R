#Neural network for predicting the strength of the concrete
#load the dataset
#normalize the dataset 
normalize <- function(x) {
  return ((x - min(x))/ (max(x)-min(x)))}
conc_norm <- as.data.frame(lapply(concrete, normalize))

#creating training and testing datasets
conc_train <- conc_norm[1:773,]
conc_test <- conc_norm[774:1030,]

#training the model
library(neuralnet)
conc_model <- neuralnet(formula = strength ~ cement + slag + ash + water + superplastic + coarseagg + 
                          fineagg + age, data = conc_train)
#network topology
windows()
plot(conc_model)
#obtaining model results
conc_model_results <- compute(conc_model, conc_test[1:8])
#predicted strength
pred_strength <- conc_model_results$net.result
#correlation between predicted and actual strength
cor(pred_strength, conc_test$strength)

#improving the model - using 5 hidden layers
conc_model2 <- neuralnet(formula = strength ~ cement + slag + ash + water + superplastic + coarseagg + 
                          fineagg + age, data = conc_train, hidden = c(5,2))
windows()
plot(conc_model2)
conc_model2_results <- compute(conc_model2, conc_test[1:8])
pred_strength2 <- conc_model2_results$net.result
cor(pred_strength2, conc_test$strength)

#with 0.93 correlation between predicted and actual strength, we have built a robust neural network

#Neural Network model for 50_startups data to predict profit 
#load the data
startup <- `50_Startups`
#creating dummy variable for "State" column
startup <- dummy_cols(startup, select_columns = 'State', remove_selected_columns = T)
View(startup)
#custom normalize the data
normalize <- function(x) {
  return ((x - min(x))/(max(x)-min(x)))
}
startup_nl <- as.data.frame(lapply(startup[1:4], normalize))
View(startup_nl)
startup_norm <- cbind(startup_nl, startup[,c(5,6,7)])
View(startup_norm)
#creating training and testing datasets
start_train <- startup_norm[1:40,]
start_test <- startup_norm[41:50,]

#training model without hidden layers
startup_model <- neuralnet(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend  , data = start_train)
windows()
plot(startup_model)
#obtaining model result
startup_model_result <- compute(startup_model, start_test[c(1,2,3,5,6,7)])
#predicted strength vs actual strength
start_pred <- startup_model_result$net.result
#correlation between predicted vs actual
cor(start_pred, start_test$Profit) #75.39
#training model with hidden layers
startup_model2 <- neuralnet(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend  , data = start_train, hidden = c(5,3))
windows()
plot(startup_model2)
#model result
startup_model_result2 <- compute(startup_model2, start_test[,c(1,2,3,5,6,7)])
#predicted vs actual
start_pred2 <- startup_model_result2$net.result
#correlation between pedicted and actual
cor(start_pred2, start_test$Profit) #75.8

#experiments with hidden layers and feature selection
sm <- neuralnet(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend , data = start_train, hidden = c(10,5))
windows()
plot(sm)
sm_result <- compute(sm, start_test[c(1,2,3,5,6,7)])
sm_pred <- sm_result$net.result
cor(sm_pred, start_test$Profit) #73.01
#increase in hidden layers has led to decrease in accuracy
#building model with a lesser hidden layer
sm2 <- neuralnet(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend , data = start_train, hidden = c(3,2))
plot(sm2)
sm2_result <- compute(sm2, start_test[-4])
sm2_pred <- sm2_result$net.result
cor(sm2_pred, start_test$Profit) #74.9

sm3 <- neuralnet(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend , data = start_train, hidden = c(4,1))
sm3_result <- compute(sm3, start_test[-4])
sm3_pred <- sm3_result$net.result
cor(sm3_pred, start_test$Profit) #78.79

sm4 <- neuralnet(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend , data = start_train, hidden = c(6,1))
sm4_result <- compute(sm4, start_test[-4])
sm4_pred <- sm4_result$net.result
cor(sm4_pred, start_test$Profit) #79.72

#model with 6 hidden layers is giving the maximum accuracy of 79.72..
#with a further increase in hidden layers the accuracy is decreasing

##PREDICTING THE BURNED AREA OF FOREST FIRES WITH NEURAL NETWORKS
#loading the data
forestfires$size_category <- as.numeric(forestfires$size_category) 
ff <- forestfires[,-c(1,2)]
View(ff)
is.null(ff) #checking if the dataset has null values
#normalize the dataset 
normalize <- function(x) {
  return ((x - min(x))/ (max(x)-min(x)))}
ff_norm <- as.data.frame(lapply(ff, normalize))
#EDA
#scatter plot matrix
plot(ff$area, type = "l")
windows()
pairs(ff_norm)
cor(ff)
ff_eda <- ff_norm[,1:9]
##checking for multi-collinearity
install.packages("car")
library(car)
ff_mlrmod <- lm(ff_eda$area~. , data =  ff_eda)
car::vif(ff_mlrmod)
pairs(ff_eda)
cor(ff_eda)
#subset selection
library(MASS)
stepAIC(ff_mlrmod)# the StepAIC value is the least at 2954.8 except MonthSep and Daywed


#creating training and testing datasets
library(C50)
library(caret)
intraining <- createDataPartition(ff_norm$area, p = 0.8, list = F)
ff_train <- ff_norm[intraining,]
ff_test <- ff_norm[-intraining,]

#building model without hidden layers
library(neuralnet)
ff_mod <- neuralnet(formula = area ~ FFMC + DMC + DC + ISI + temp + RH + wind + rain
  , data = ff_train)



ff_mod <- neuralnet(formula = area ~ FFMC + DMC + DC + ISI + temp + RH + wind + rain + 
                      dayfri + daymon + daysat + daysun + daythu + daytue + monthapr + 
                      monthaug + monthdec + monthfeb + monthjan + monthjul + monthjun + 
                      monthmar + monthmay + monthnov + monthoct + size_category, data = ff_train )
ff_mod_result <- compute(ff_mod, ff_test[-9])
ff_pred <- ff_mod_result$net.result
cor(ff_pred, ff_test$area) #correlation of 0.108 is the maximum we can get from this algorithm
