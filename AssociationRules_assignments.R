######ASSOCIATION RULES#########

###Prepare association rules for the "Books" data sets#######
library(arules)
book<-read.transactions("C:\\Users\\nitin\\Desktop\\Assignments\\Association Rules\\book.csv",format="basket")
inspect(book[1:10])

# count of each item from all the transactions 
itemFrequencyPlot(book,topN=20)

book_rules<-apriori(book,parameter = list(support = 0.5,confidence = 0.02,minlen=4))
installed.packages(arulesViz)
library(arulesViz)
plot(book_rules,method = "scatterplot")
plot(book_rules,method = "grouped")
plot(book_rules,method = "graph")
inspect(book_rules[1:5])
rules <- sort(book_rules,by="lift")
inspect(rules[1:4])

## With different support, confidence and minimum length ##

book_rules1<-apriori(book,parameter = list(support = 0.8,confidence = 0.01,minlen=4))
plot(book_rules1,method = "scatterplot")
plot(book_rules1,method = "grouped")
plot(book_rules1,method = "graph")
plot(book_rules1,method = "mosaic")
inspect(book_rules1[1:5])
rules1 <- sort(book_rules1,by="lift")
inspect(rules[1:4])


##########Association rules for "Groceries" Data Set #########
library(arules)
groceries<-read.transactions('C:\\Users\\nitin\\Desktop\\Assignments\\Association Rules\\groceries.csv',format="basket")
inspect(groceries[1:10])

# count of each item from all the transactions 
itemFrequencyPlot(groceries,topN=20)

groceries_rules<-apriori(groceries,parameter = list(support = 0.002,confidence = 0.05,minlen=3))
library(arulesViz)
plot(groceries_rules,method = "scatterplot")
plot(groceries_rules,method = "grouped")
plot(groceries_rules,method = "graph")
inspect(groceries_rules[1:5])
rules <- sort(groceries_rules,by="lift")
inspect(rules[1:4])

## With different support, confidence and minimum length ##

groceries_rules1<-apriori(groceries,parameter = list(support = 0.001,confidence = 0.06,minlen=4))
plot(groceries_rules1,method = "scatterplot")
plot(groceries_rules1,method = "grouped")
plot(groceries_rules1,method = "graph")
plot(groceries_rules1,method = "mosaic")
inspect(groceries_rules1[1:5])
rules1 <- sort(groceries_rules1,by="lift")
inspect(rules[1:5])

##########Association Rules with "My_Movies" Data Set #########
library(arules)
movies<-read.transactions('C:\\Users\\nitin\\Desktop\\Assignments\\Association Rules\\my_movies.csv',format="basket")
inspect(movies[1:10])
class(movies)

# count of each item from all the transactions 
itemFrequencyPlot(movies,topN=20)

movies_rules<-apriori(movies,parameter = list(support = 0.002,confidence = 0.05,minlen=3))
library(arulesViz)
plot(movies_rules,method = "scatterplot")
plot(movies_rules,method = "grouped")
plot(movies_rules,method = "graph")
inspect(movies_rules[1:5])
rules <- sort(movies_rules,by="lift")
inspect(rules[1:5])

## With different support, confidence and minimum length ##

movies_rules1<-apriori(movies,parameter = list(support = 0.003,confidence = 0.06,minlen=4))
plot(movies_rules1,method = "scatterplot")
plot(movies_rules1,method = "grouped")
plot(movies_rules1,method = "graph")
inspect(movies_rules1[1:5])
rules1 <- sort(movies_rules1,by="lift")
inspect(rules[1:5])














