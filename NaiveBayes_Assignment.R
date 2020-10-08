#NAIVE BAYES CLASSIFICATION ON SMS DATA
#loading the data 
sms <- sms_raw_NB
str(sms) #examining the data structure
#convert spam ham to factor
sms$type <- factor(sms$type)
View(sms)
#Building corpus using library(tm)
library(tm)
sms_corp <- Corpus(VectorSource(sms$text))
#data cleaning using tm_map function
clean_corp <- tm_map(sms_corp, tolower)
clean_corp <- tm_map(clean_corp, removePunctuation)
clean_corp <- tm_map(clean_corp, removeNumbers)
clean_corp <- tm_map(clean_corp, removeWords, stopwords())
clean_corp <- tm_map(clean_corp, stripWhitespace)
inspect(clean_corp)
#creating document term matrix
corp_dtm <- DocumentTermMatrix(clean_corp)
#creating training and test data
sms_train <- sms[1:4169,]
sms_test <- sms[4170:5559,]

dtm_train <- corp_dtm[1:4169,]
dtm_test <- corp_dtm[4170:5559,]

clean_corp_train <- clean_corp[1:4169]
clean_corp_test <- clean_corp[4170:5559]

#checking the proportion of spam is similar
prop.table(table(sms_train$type))
prop.table(table(sms_test$type))

#wordcloud visualisation
library(wordcloud)
windows()
wordcloud(clean_corp_train, min.freq = 30, random.order = FALSE)

#creating subsets of spam and ham in the training data
spam_sms <- subset(sms_train, type == 'spam')
ham_sms <- subset(sms_train, type == 'ham')
wordcloud(spam$text, max.words = 40, scale = c(3,0.5), colors = 'orange')
wordcloud(ham$text, max.words = 40, scale = c(3,0.5), colors = 'red')

#frequent words
dict_sms <- findFreqTerms(dtm_train, 5)
train_sms <- DocumentTermMatrix(clean_corp_train, list(dictionary = dict_sms))
test_sms <- DocumentTermMatrix(clean_corp_test, list(dictionary = dict_sms))
#convert counts to factor
count_convert <- function(x) {
  x <- ifelse(x>0,1,0)
  x <- factor(x, levels = c(0,1), labels = c('No', 'Yes'))
}

#apply count_convert() to columns of train/test data
train_sms <- apply(train_sms, MARGIN = 2, count_convert)
test_sms <- apply(test_sms,MARGIN = 2, count_convert)

#model training
library(e1071)
classify_sms <- naiveBayes(train_sms, sms_train$type)
#evaluating model performance
sms_pred <- predict(classify_sms, test_sms)

library(gmodels)
CrossTable(sms_pred, sms_test$type, prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE, dnn = c('predicted', 'actual'))
#improving model efficiency
classify2_sms <- naiveBayes(train_sms, sms_train$type, laplace = 1)
sms_pred2 <- predict(classify2_sms, test_sms)
CrossTable(sms_pred2, sms_test$type, prop.r = F, prop.t = F, prop.chisq = F, dnn = c('predicted','actual'))



#NAIVE BAYES CLASSIFICATION ON SALARY DATA
#laoding data
sd_train <- SalaryData_Train
sd_test <- SalaryData_Test
sal_classifier <- naiveBayes(sd_train, sd_train$Salary)
sal_pred <- predict(sal_classifier, sd_test)
sal_pred
CrossTable(sal_pred, sd_test$Salary, prop.r = F, prop.t = F, prop.chisq = F, dnn = c('predicted', 'actual'))

#improving the model
sal_classifier2 <- naiveBayes(sd_train, sd_train$Salary, laplace = 1)
sal_pred2 <- predict(sal_classifier2, sd_test)
CrossTable(sal_pred2, sd_test$Salary, prop.r = F, prop.t = F, prop.chisq = F, dnn = c('predicted', 'actual'))
