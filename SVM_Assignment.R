# CLASSIFYING FOREST FIRES
ff <- forestfires[,-c(1,2)] #dropping the month and day column as dummy variable have been created for them
#creating train and test data
train_ff <- ff[1:400,]
test_ff <- ff[401:517,]

#training the model on train data with simple linear SVM
library(kernlab)
ff_classifier <- ksvm(size_category ~., data = train_ff, kernel = "vanilladot")

#predicting on test data
ff_predict <- predict(ff_classifier, test_ff)
head(ff_predict)

#table of predictions
correctness <- ff_predict == test_ff$size_category
prop.table(table(correctness))

#checking if we can improve the model
ff_classifier_rbf <- ksvm(size_category ~. , data = train_ff, kernel = "rbfdot")
ff_predict_rbf <- predict(ff_classifier_rbf, test_ff)
head(ff_predict_rbf)
correctness_rbf <- ff_predict_rbf == test_ff$size_category
prop.table(table(correctness_rbf))

#the accuracy decreased, so we'll go with simple linear SVM using vanilladot kernel


#CLASSIFYING SALARY DATA

train_sal <- dummy_cols(`SalaryData_Train(1)`)
train_sal_data <- train_sal[,-c(2,3,5,6,7,8,9,13)] #removing the columns used to create dummy variables
View(train_sal_data)

test_sal <- dummy_cols(`SalaryData_Test(1)`)
test_sal_data <- test_sal[,-c(2,3,5,6,7,8,9,13)] #removing the columns used to create dummy variables

library(kernlab)

#training the model
sd_classifier <- ksvm(Salary ~., data = train_sal_data, kernel = "vanilladot")
#predicting on test data
sd_predict <- predict(sd_classifier, test_sal_data)
head(sd_predict)
#table of predictions
sd_correctness <- sd_predict == test_sal_data$Salary
prop.table(table(sd_correctness))

#improving the model
sd_classifier_rbf <- ksvm(Salary ~. , data = train_sal_data, kernel = "rbfdot")
#predicting
sd_predict_rbf <- predict(sd_classifier_rbf, test_sal_data)
head(sd_predict_rbf)
#correctness
sd_correctness_rbf <- sd_predict_rbf == test_sal_data$Salary
prop.table(table(sd_correctness_rbf))

#since the accuracy is 99.38% we'll go with rbfdot kernel