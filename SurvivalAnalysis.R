#Survival analysis on unemployment rate

install.packages("survival")
library(survival)
survival_unemployment1<- survival_unemployment1
  
attach(survival_unemployment1)

# Define variables 
time <- spell
event <- event
X <- cbind(logwage, ui, age)
group <- ui
# Descriptive statistics
summary(time)
summary(event)
summary(X)
summary(group)

# Kaplan-Meier non-parametric analysis
kmsurvival <- survfit(Surv(time,event) ~ 1)

plot(kmsurvival, xlab="Time", ylab="Survival Probability")

# Kaplan-Meier non-parametric analysis by group
kmsurvival1 <- survfit(Surv(time, event) ~ group)
plot(kmsurvival1, xlab="Time", ylab="Survival Probability")
