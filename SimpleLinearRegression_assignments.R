#predicting weight gained using calories consumed
model <- lm(calories_consumed$Weight.gained..grams. ~ calories_consumed$Calories.Consumed, data = calories_consumed)
summary(model)

# Predicting delivery time using sorting time 
dt <- lm(delivery_time$Delivery.Time ~ delivery_time$Sorting.Time, data = delivery_time)
summary(dt)

#prediction model for Churn_out_rate
chor <- lm(emp_data$Churn_out_rate ~ emp_data$Salary_hike, data = emp_data)
summary(chor)
plot(emp_data$Salary_hike, emp_data$Churn_out_rate, main = "line of best fit", col.main = "black", xlab = "salary hike", ylab = "churn out rate")
abline(chor, col = "black")
predict(chor, newdata = data.frame(emp_data$Salary_hike = c(100)))
plot(chor)
residualPlots(chor)
avPlots(chor)
qqPlot(chor)
influenceIndexPlot(chor)

#iteration
chor1 <- emp_data[-10,]
chor.mod <- lm(chor1$Churn_out_rate ~ chor1$Salary_hike, data = emp_data)
summary(chor.mod)

#iteration 2
chor2 <- chor1[-1,]
chor2.mod <- lm(chor2$Churn_out_rate ~ chor2$Salary_hike , data = chor2)
summary(chor2.mod)


# prediction model for Salary_hike
sd <- lm(Salary_Data$Salary ~ Salary_Data$YearsExperience, data = Salary_Data)
summary(sd)
influenceIndexPlot(sd)

#iteration 1 - removing 24th observation 
sd1 <- Salary_Data[-24,]
sd1.mod <- lm(sd1$Salary ~ sd1$YearsExperience, data = sd1)
summary(sd1.mod)

#iteration 2 - removing 2nd observation
sd2 <- sd1[-2,]
sd2.mod <- lm(sd2$Salary~sd2$YearsExperience, data = sd2)
summary(sd2.mod)
