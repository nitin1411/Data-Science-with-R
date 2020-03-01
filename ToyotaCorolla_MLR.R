#Toyota Corolla used car Best Price
toy <- Toyoto_Corrola[,-c(1,2,8)]

#scatter plot matrix
pairs(toy)

#correlation matrix
cor(toy)

#regression model
model.toy <- lm(toy$Price~., data = toy)
summary(model.toy)

#multi-collinearity
car::vif(model.toy)

#diagnostic plots
plot(model.toy)
residualPlots(model.toy)
avPlots(model.toy)
qqPlot(model.toy)

#Deletion diagnostic
influenceIndexPlot(model.toy)

#iteration 1 - remove 222nd observation
toy1 <- toy[-222,]
model1 <- lm(toy1$Price~., data = toy1)
car::vif(model1)
influenceIndexPlot(model1)

#iteration 2 - remove 961st observation
toy2 <- toy[-c(222,961),]
model2 <- lm(toy2$Price~., data = toy2)
influenceIndexPlot(model2)
