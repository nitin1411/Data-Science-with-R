#Clustering for the crime data and identifying the number of clusters formed
cd <- scale(crime_data[,2:5]) #standardising the dataset
d <- dist(cd, method = "euclidean") #computing the distance matrix
d
fit <- hclust(d, method = "average") #Building the algorith with average linkage method
plot(fit) #display dendogram
grp <- cutree(fit, k = 5)
rect.hclust(fit, k = 5, border = "red")

#Attaching cluster number to states
clusters = data.frame('states' = crime_data[,1], 'cluster' = groups)

#Building Algorithm with Centroid Linkage Method
fit <- hclust(d, method = 'centroid')
plot(fit)
grp1 <- cutree(fit, k = 5)
rect.hclust(fit, k = 5, border = 'red')

#using K-Means Clustering
#Elbow chart
wss <- c()
for(i in 2:15) wss[i] <- sum(kmeans(data, centers = i)$withinss)
plot(1:15, wss, type = 'b', xlab = "No. of clusters", ylab = '"Average distance')

#cluster algorithm building
km <- kmeans(cd, 7)
km$centers
km$cluster

#animation presentation
windows()
anim <-kmeans.ani(cd, 7)


#clustering (Both hierarchical and K means clustering) for the airlines data to obtain optimum number of clusters
#HClust method
air <- EastWestAirlines
