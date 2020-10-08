#twitter analysis - for a user account

install.packages("twitteR")
library("twitteR")

install.packages("ROAuth")
library("ROAuth")

install.packages("base64enc")
library(base64enc)

install.packages("httpuv")
library(httpuv)
### https://apps.twitter.com/

cred <- OAuthFactory$new(consumerKey='2NFXXXXXXXXBb2Gdar',
                         consumerSecret='Z6h7aXXXXXXXX04kWznH0XrZ638PdM6Ix',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')

#save(cred, file="twitter authentication.Rdata")
#load("twitter authentication.Rdata")

setup_twitter_oauth("2NFD2caXXXXXXXFBb2Gdar", 
                    "Z6h7aDzus8XXXXXXXXXX04kWznH0XrZ638PdM6Ix",
                    "2722336712-HWw9b9ZXXXXXXXOlJORJ4tcUVgqc2", # Access token
                    "9MSo3O7RJBLXXXXXXXXsjN5eP5PIaK")  # Access token secret key

Tweets <- userTimeline('narendramodi', n = 1000)
TweetsDF <- twListToDF(Tweets)
write.csv(TweetsDF, "Tweets_sarf.csv")


#twitter analysis - for a particular word

word_tweets<- searchTwitter('lockdown', n=1000, lang="en", resultType = "recent")
class(word_tweets)
word_tweets[1:20]

Virat_txt<-sapply(Tweets, function(x) x$getText())

str(Virat_txt)

#https://apps.twitter.com/ 


Virat_corpus<-Corpus(VectorSource(Virat_txt))
inspect(Virat_corpus[100])


Virat_clean<-tm_map(Virat_corpus, removePunctuation)
Virat_clean<-tm_map(Virat_clean, content_transformer(tolower))
Virat_clean<-tm_map(Virat_clean, removeWords, stopwords("english"))
Virat_clean<-tm_map(Virat_clean,removeNumbers)
Virat_clean<-tm_map(Virat_clean, stripWhitespace)

Virat_clean<-tm_map(Virat_clean, removeWords, c("gameofthrones")) ## clean some words


wordcloud(Virat_clean, random.order = F, max.words = 5,colors=rainbow(50))
wordcloud(Virat_clean, rot.per=0.5, random.order=TRUE,colors=brewer.pal(8, "Dark2"))



