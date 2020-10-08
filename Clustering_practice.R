#CLUSTERING

mydata <- Universities
mydata1 <- scale(mydata[,2:7])
d <- dist(mydata1, method = 'euclidean') #computing the distance matrix
d
fit <- hclust(d, method = 'average') #Building the algorith with average linkage method
plot(fit) #display dendogram
groups <- cutree(fit, k=4) #cutting dendogram into 4 clusters
rect.hclust(fit, k=4, border = 'red') #drawing dendogram with red borders around 4 clusters

#attaching clusters numbers to universities
clusters = data.frame('uni'= mydata[,1], 'cluster'= groups)

#Building the algorith with centroid linkage method
fit <- hclust(d, method = 'centroid')
plot(fit)
groups <- cutree(fit, k=5) #cutting dendogram into 4 clusters
rect.hclust(fit, k=5, border = 'blue') #drawing dendogram with blue borders around 4 clusters

#K-Means clustering
install.packages("plyr")
library(plyr)
x <- runif(50)
y <- runif(50)
data <- cbind(x,y)
plot(data)
#Elbow chart
wss <- c()
for(i in 2:15) wss[i] <- sum(kmeans(data, centers = i)$withinss)
plot(1:15, wss, type = 'b', xlab = "No. of clusters", ylab = '"Average distance')

#Cluster algorith building
km <- kmeans(data, 10)
km$centers
km$cluster

#Animation
install.packages("animation")
library(animation)
windows()
km <- kmeans.ani(data,5)
