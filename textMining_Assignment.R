# Amazon review of canon camera
library(rvest)
library(XML)
library(magrittr)

aurl <- "https://www.amazon.in/Canon-Digital-Camera-Black-24-105mm/dp/B01KURGS9Y/ref=sr_1_1?crid=1M30ZSSWF1UWO&dchild=1&keywords=canon+1dx+mark+ii&qid=1587983490&sprefix=canon+1dx+ma%2Caps%2C369&sr=8-1#customerReviews"
amazon_reviews <- NULL
for (i in 1:10) {
  curl <- read_html(as.character(paste(aurl,i,sep = "=")))
  review <- curl %>% html_nodes(".review-text") %>% html_text()
  amazon_reviews <- c(amazon_reviews, review)
  
}
length(amazon_reviews)
write.table(amazon_reviews, "canon-camera.txt", row.names = FALSE)

#Sentiment analysis of canon 1dx mark 3 camera 
camtxt <- canon.camera$x
t <- as.character(camtxt)
library(tm)
t <- Corpus(VectorSource(t))
inspect(t[1])

#data cleansing
rt <- tm_map(t, removePunctuation)
rt <- tm_map(t, tolower)
inspect(rt[1])
rt <- tm_map(t, removeNumbers)
rt <- tm_map(t, removeWords, stopwords('english') )
inspect(rt[1])
rt <- tm_map(t, stripWhitespace)
inspect(rt[1])

#converting unstructured data into term doc matrix
tdm1 <- TermDocumentMatrix(rt)
dtm <- t(tdm1)
canon_tdm <- as.matrix(tdm1)

#barplot
w <- rowSums(canon_tdm)
w
w_sub <- subset(w, w >= 20)
w_sub
windows()
barplot(w_sub, las=3 , col = rainbow(20))

#wordcloud
library(wordcloud)
windows()
wordcloud(words = names(w_sub), freq = w_sub)

wsub <- sort(rowSums(canon_tdm), decreasing = TRUE)
wordcloud(words = names(wsub), freq = wsub)

windows()
wordcloud(words = names(wsub), freq = wsub, random.order = F, colors = rainbow(20), scale=c(3,1), rot.per = 0.3)

#loading positive and negative words
p.words <- scan(file.choose(), what = "character", comment.char = ";")
n.words <- scan(file.choose(), what = "character", comment.char = ";")

#positive wordcloud
p.matches = match(names(wsub), c(p.words))
p.matches = !is.na(p.matches)
freq_pw <- wsub[p.matches]
p_names <- names(freq_pw)
windows()
wordcloud(p_names, freq_pw, scale = c(4,1), colors = rainbow(20))

#negative wordcloud
n.matches = match(names(wsub), c(n.words))
n.matches = !is.na(n.matches)
freq_nw <- wsub[n.matches]
n_names <- names(freq_nw)
windows()
wordcloud(n_names, freq_nw, scale = c(4,1), colors = rainbow(20))






#IMDB REVIEW OF OZARK WEB SERIES
url = 'https://www.imdb.com/title/tt5071412/reviews?ref_=tt_ql_3'
Imdb_rev = NULL
url1 = read_html(as.character(url))
rev = url1 %>% html_nodes('.show-more__control') %>% html_text()
Imdb_rev = c(Imdb_rev,rev)
length(Imdb_rev)
write.table(Imdb_rev, "ozark_review.txt", row.names = FALSE)

#sentiment analysis of ozark web series 
ozrev <- ozark_review$x
or <- as.character(ozrev)
library(tm)
or <- Corpus(VectorSource(or))
inspect(or[1])
#data cleaning
orev <- tm_map(or, removePunctuation)
orev <- tm_map(or, tolower)
orev <- tm_map(or, removeNumbers)
orev <- tm_map(or, removeWords, stopwords ('english'))

#converting reviews into term doc matrix
otdm <- TermDocumentMatrix(orev)
odtm <- t(otdm)
oz_tdm <- as.matrix(otdm)

#barplot
ozr <- rowSums(oz_tdm)
ozr
ozr_sub <- subset(ozr, ozr >= 5) 
ozr_sub
windows()
barplot(ozr_sub, las = 3, col = rainbow(10))
#removing unnecessary words
orev <- tm_map(or, removeWords, c('season','series','show','will','the','one','two'))
orev <- tm_map(or, stripWhitespace)
otdm <- TermDocumentMatrix(orev)
odtm <- t(otdm)
oz_tdm <- as.matrix(otdm)

#wordcloud
library(wordcloud)
windows()
wordcloud(words = names(ozr_sub), freq = ozr_sub)

ozr_sub1 <- sort(rowSums(oz_tdm), decreasing = TRUE)
windows()
wordcloud(words = names(ozr_sub1), freq = ozr_sub1) #all words considered

windows()
wordcloud(words = names(ozr_sub1), freq = ozr_sub1 ,random.order = F, colors = rainbow(14), scale = c(3,1), rot.per = 0.3)

#positive and negative matching 
#loading the dictionaries
op.words <- scan(file.choose(), what = "character", comment.char = ";")
on.words <- scan(file.choose(), what = "character", comment.char = ";")
#positive wordcloud
op.matches <- match(names(ozr_sub1), c(op.words))
op.matches = !is.na(op.matches)
op_freq = ozr_sub1[op.matches]
op_names <- names(op_freq)
windows()
wordcloud(words = op_names, freq = op_freq, scale = c(3,1), colors = rainbow(20))

#negative wordcloud
on.matches = match(names(ozr_sub1), on.words)
on.matches = !is.na(on.matches)
on_freq = ozr_sub1[on.matches]
on_names = names(on_freq)
windows()
wordcloud(words = on_names, freq =  on_freq, scale = c(3,1), colors = rainbow(20))