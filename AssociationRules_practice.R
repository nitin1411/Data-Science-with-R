#ASSOCIATION rULES
library(arules)
titanic <- Titanic[,-c(1)]
rules <- apriori(titanic)
arules::inspect(rules)
rules.sorted <- sort(rules, by = 'lift')
arules::inspect(rules.sorted)

#rules with rhs containing "survived" only
rules <- apriori(titanic, parameter = list(minlen = 1, supp= 0.1, conf= 0.5), appearance = list(rhs= c("Survived=No", "Survived=Yes")), control = list(verbose = F))
arules::inspect(rules)

#rules with rhs containing "survived" only and different support and confidence values
rules2 <- apriori(titanic, parameter = list(minlen=1, supp = 0.5, conf = 0.7), 
                  appearance = list(rhs = c("Survived=No", "Survived=Yes")), control = list(verbose=F))
arules::inspect(rules2)
