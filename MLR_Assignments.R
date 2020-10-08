#prediction model for profit of 50_startups data.
startup <- `50_Startups`[,-4]
View(startup)
su.mod <- lm(startup$Profit ~. , data = startup)
summary(su.mod)
cor(startup)
car::vif(su.mod) #testing for multicollinearity..(result - independent variable are not correlated)
plot(su.mod)
avPlots(su.mod)
qqPlot(su.mod)
influenceIndexPlot(su.mod)

#iteration 1 - removing 50th observation
su1 <- startup[-50,]
su1.mod <- lm(su1$Profit ~., data = su1)
summary(su1.mod)

#iteration 2 - removing 49th observation
su2 <- su1[-49,]
su2.mod <- lm(su2$Profit~., data = su2)
summary(su2.mod)

influenceIndexPlot(su2.mod)
#iteration 3 - removing 47th observation
su3 <- su2[-47,]
su3.mod <- lm(su3$Profit~., data = su3)
summary(su3.mod)
stepAIC(su3.mod)

su4.mod <- lm(su3$Profit ~ su3$R.D.Spend + su3$Marketing.Spend, data = su3)
summary(su4.mod)



#Predict Price of Toyota corolla
tc_data <- ToyotaCorolla
summary(tc_data)
str(tc_data)

#creating dummy variables
tc_data <- dummy_cols(tc_data, select_columns = c('Fuel_Type','Color','Model'), remove_selected_columns = T)

#dropping mfg_month and mfg_year columns as they are unnecessary because age of the car is already given
tc_data <- tc_data[,-c(3,4)]

#since the data are of different scales, we'll normalize the data.
normalize <- function(x) {
  return((x - min(x)/max(x) - min(x)))
}

tc_data_norm <- as.data.frame(lapply(tc_data, normalize))
tc_data_scaled <- scale(tc_data)

#regression model 
tc_mod <- lm(Price ~., data = tc_data_scaled)
