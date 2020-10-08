#ENTROPY CALCULATION (BEFORE SPLIT)
-3/5 * log2(3/5)
-2/5 * log2(2/5)
0.4421794 + 0.5287712

#ENTROPY AFTER SPLIT = ENTROPY OF LEFT NODE + ENTROPY OF RIGHT NODE
#ENTROPY OF PRICE COLUMN
-3/4 * log2(3/4) - (1/4 * log2(1/4)) #entropy of left node
1/1 * log2(1/1)
#entropy after split = entropy of left node + entropy of right node
#  = 0.8112781 + 0

#info gain = entropy before split - entropy after split
0.9709506 - 0.8112781 #entropy b.s - entropy a.s

#implementation of decision tree
#install.packages("caret")
#install.packages("C50")
library(caret)
install.packages("C50")
library(C50)

data("iris")
intraininglocal <- createDataPartition(iris$Species, p = 0.70, list = F)
training <- iris[intraininglocal,]
testing <- iris[-intraininglocal,]
#Model Building
model <- C5.0(training$Species ~., data =  training)
summary(model)
#Predict for test Dataset
pred <- predict.C5.0(model, testing[,-5])
a <- table(testing$Species, pred)
sum(diag(a) / sum(a))
#Plotting the decision tree
plot(model)


###BAGGING METHOD UNDER "ENSEMBLE MODELLING"
acc <- c()
for (i in 1:100)
{
print(i)  
#data partition
  intraininglocal <- createDataPartition(iris$Species, p=0.70, list = F)
  train1 <- iris[intraininglocal,]
  test1 <- iris[-intraininglocal,]
  #model building
  fittree <- C5.0(train1$Species~., data = train1)
  #predicting
  pred <- predict.C5.0(fittree, test1[,-5])
  a <- table(test1$Species, pred)
  #accuracy
  acc <- c(acc, sum(diag(a) / sum(a)))
}
summary(acc)
boxplot(acc)

###BOOSTING METHOD UNDER "ENSEMBLE MODELLING"
trainingdata <- createDataPartition(iris$Species, p = 0.8, list = F)
traindata <- iris[trainingdata,]
testdata <- iris[-trainingdata,]

#model building
boostmod <- C5.0(traindata$Species~., data = traindata, trials=10)
#predicting
pred <- predict.C5.0(boostmod, testdata[,-5])
summary(boostmod)
accurate <- table(testdata$Species, pred)

sum(diag(accurate) / sum(accurate))

#BAGGING AND BOOSTING

acc <- c()
for (i in 1:100)
{
  print(i)  
  #data partition
  intraininglocal <- createDataPartition(iris$Species, p=0.70, list = F)
  train1 <- iris[intraininglocal,]
  test1 <- iris[-intraininglocal,]
  #model building
  fittree <- C5.0(train1$Species~., data = train1, trials = 20)
  #predicting
  pred <- predict.C5.0(fittree, test1[,-5])
  a <- table(test1$Species, pred)
  #accuracy
  acc <- c(acc, sum(diag(a) / sum(a)))
}
summary(acc)
boxplot(acc)








