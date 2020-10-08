#multiple linear regression model
cars <- Cars
summary(cars)

#scatter plot matrix
pairs(cars)

#correlation matrix
cor(cars)

#regression model and summary
model.car <- lm(MPG ~., data = cars)
summary(model.car)

###Experiment###
reg_vol <- lm(MPG ~ VOL, data = cars)
summary(reg_vol)

reg_wt <- lm(MPG ~ WT, data = cars)
summary(reg_wt)

reg_wt_vol <- lm(MPG ~ WT + VOL, data = cars)
summary(reg_wt_vol)

reg_sp_hp <- lm(MPG ~ SP + HP, data = cars)
summary(reg_sp_hp)

#multi-collinearity
install.packages("car")
library(car)
car::vif(model.car)

#subset selection
library(MASS)
stepAIC(model.car)

#diagnostic plots : residual plots, QQ-plots, std. residuals vs fitted.
plot(model.car)

#residual vs regressors
library(car)
residualPlots(model.car)

#added variable plots
avPlots(model.car)

#QQ-plots of studentised residuals
qqPlot(model.car)

#Deletion diagnostic
influenceIndexPlot(model.car) #index plots of influence measures

#iteration 1 - remove observation 77th
cars1 <- Cars[-77,]
model1 <- lm(cars1$MPG ~., data = cars1)
car::vif(model1)

influenceIndexPlot(model1)
#iteration 2 - remove observation 79th
cars2 <- Cars[c(-77,-79),]
model2 <- lm(cars2$MPG~., data = cars2)
car::vif(model2)

influenceIndexPlot(model2)
#iteration 3 - remove observation 80th
cars3 <- Cars[c(-77,-79,-80),]
model3 <- lm(cars3$MPG~., data = cars3)
car::vif(model3)

influenceIndexPlot(model3)
#iteration 4 - remove observation 6th
cars4 <- Cars[c(-66,-77,-79,-80),]
model4 <- lm(cars4$MPG~., data = cars4)
car::vif(model4)
residualPlots(model4)

influenceIndexPlot(model4)
#iteration 5 - remove observation 1st
cars5 <- Cars[c(-1,-66,-77,-79,-80),]
model5 <- lm(cars5$MPG~., data = cars5)
car::vif(model5)
influenceIndexPlot(model5)
residualPlots(model5)





