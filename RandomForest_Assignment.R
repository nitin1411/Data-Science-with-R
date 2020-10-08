#Building random forest on fraud data
#install.packages("caret", dependencies = True)
#install.packages("randomForest")
library(randomForest)
Fraud_check$Urban <- as.numeric(Fraud_check$Urban) - 1
Fraud_check$Undergrad <- as.numeric(Fraud_check$Undergrad) - 1
Tax.inc <- cut(Fraud_check$Taxable.Income, breaks = c(0,30000,99700), labels = c('Risky','Good'))
View(fc_rf)
Fraud_check <- dummy_cols(Fraud_check, select_columns = 'Marital.Status', remove_selected_columns = TRUE)
fc_rf <- cbind(Tax.inc, Fraud_check)
fc_rf <- fc_rf[,-3]

#Building the model
model_rf <- randomForest(fc_rf$Tax.inc ~. , data = fc_rf, ntree = 1000)
print(model_rf)

##Importance of the variable - Lower Gini
print(importance(model_rf))
#prediction
pred_rf <- predict(model_rf, fc_rf[,-1])
table(pred_rf, fc_rf$Tax.inc)

#"City Population" and "Work Experience" play a major role in determining whether an individual is likely to 
#committ an act of fraud or not.


#Building random forest with target variable sales
View(Company_Data)
Company_Data$Urban <- as.numeric(Company_Data$Urban) - 1
Company_Data$US <- as.numeric(Company_Data$US) - 1 
Company_Data <- dummy_cols(Company_Data, select_columns = 'ShelveLoc', remove_selected_columns = T)
Sales <- cut(Company_Data$Sales, breaks = c(0,10,17), labels = c('<=10','>10'))
Company_Data <- Company_Data[,-1]
sales_rf <- cbind(Sales,Company_Data)
library(gam)
sales_rf1 <- na.omit(sales_rf)
View(sales_rf1)
#building the model
mod_rf <- randomForest(sales_rf1$Sales ~., data = sales_rf1, ntree = 1000)
print(mod_rf)

##Importance of the variable - Lower Gini
print(importance(mod_rf))
#prediction
pred_sales_rf <- predict(mod_rf, sales_rf1[,-1])
table(pred_sales_rf, sales_rf1$Sales)

#"Price", Good Shelf Location" , "Age", "Income", "Competitor's Price", "Advertising" and "Population" are 
#the attributes that determine high sales of the company.