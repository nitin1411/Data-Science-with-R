#KNN classification of Glass types
#loading the data
g <- glass
table(g$Type)
#scaling the data
# use the scale() function to z-score standardize a data frame
gz <- as.data.frame(scale(g[-10]))
gz <- cbind(gz, g[10])
gz <- gz[,-10]
#creating train and test dataset using random partition
library(caret)
g_training <- createDataPartition(gz$Type, p = 0.7 , list = F)
gz_train <- gz[g_training,]
gz_test <-  gz[-g_training,]
#creating labels 
g_train_labels <- gz[g_training,10]
g_test_labels <- gz[-g_training,10]
#model building using k as 7
library(class)
gz_pred <- knn(train = gz_train, test = gz_test, cl = g_train_labels, k = 7)
#cross tabulation of predicted vs actual
library(gmodels)
CrossTable(x = gz_pred , y = g_test_labels , prop.chisq = F, prop.c = F, prop.r = F)
prop.table(table(gz_pred, gz_test$Type))
round(prop.table(table(gz$Type)) * 100, digits = 1)
#improving efficiency with different values of  k
gz_pred2 <- knn(train = gz_train, test = gz_test, cl = g_train_labels, k = 10)
CrossTable(x = gz_pred2 , y = g_test_labels , prop.chisq = F, prop.c = F, prop.r = F)
prop.table(table(gz_pred2, gz_test$Type))

gz_pred3 <- knn(train = gz_train, test = gz_test, cl = g_train_labels, k = 14)
CrossTable(x = gz_pred3 , y = g_test_labels , prop.chisq = F, prop.c = F, prop.r = F)
prop.table(table(gz_pred3, gz_test$Type))
round(prop.table(table(gz$Type)) * 100, digits = 1)

gz_pred4 <- knn(train = gz_train, test = gz_test, cl = g_train_labels, k = 5)
CrossTable(x = gz_pred4 , y = g_test_labels , prop.chisq = F, prop.c = F, prop.r = F)
prop.table(table(gz_pred4, gz_test$Type))
round(prop.table(table(gz$Type)) * 100, digits = 1)

#KNN classification of Animal type
#loading the data
zoo <- Zoo[,-1]
#there is no need to standardize the data as there isn't much deviation
#the data is more or less on the same scale
table(zoo$type)
round(prop.table(table(zoo$type)) * 100, digits = 1)
#creating training and testing data
zoo_train <- zoo[1:71,]
zoo_test <- zoo[72:101,]
#labelling
zoo_train_label <- zoo[1:71,17]
zoo_test_label <- zoo[72:101,17]
#model building
zoo_pred <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 7)
CrossTable(x = zoo_pred, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

zoo_pred2 <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 14)
CrossTable(x = zoo_pred2, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

zoo_pred3 <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 21)
CrossTable(x = zoo_pred3, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

zoo_pred4 <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 2)
CrossTable(x = zoo_pred4, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

zoo_pred5 <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 3)
CrossTable(x = zoo_pred5, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

zoo_pred6 <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 4)
CrossTable(x = zoo_pred6, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

zoo_pred7 <- knn(train = zoo_train, test = zoo_test, cl = zoo_train_label, k = 5)
CrossTable(x = zoo_pred7, y = zoo_test_label, prop.chisq = F, prop.c = F, prop.r = F)
round(prop.table(table(zoo_test$type)) * 100, digits = 1)

#model with k = 2,3,4,5 are very similar and most accurate.
