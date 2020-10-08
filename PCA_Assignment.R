#Principal component analysis and clustering on wine data
#loading the data
install.packages("xlsx")
wine_pca <- princomp(wine[,2:14], cor = T, covmat = NULL, scores = T)
summary(wine_pca)  
wine_pca$scores
plot(wine_pca$scores[,1:3], col = "Blue", pch = 10, cex = 0.3, lwd = 3)
text(wine_pca$scores[,1:3], labels = c('1','2','3'), cex = 1)

#clustering
wine_s <- scale(wine[2:14])
w <- dist(wine_s, method = 'euclidean')
w
wine_fit <- hclust(w, method = 'average') #building algorithm with average linkage method
plot(wine_fit)
wine_grp <- cutree(wine_fit, k = 3)
rect.hclust(wine_fit, k=3, border = 'red')
#attaching cluster number to wines
w_cluster = data.frame('wine cluster'= wine[,1], 'cluster' = wine_grp)
wine_fit2 <- hclust(w, method = 'centroid') #building algorithm with centroid linkage method
plot(wine_fit2)
wine_grp2 <- cutree(wine_fit2, k = 3)
rect.hclust(wine_fit2, k = 3, border = 'blue')
## there is no clarity from hierarchial clustering..
## lets try kmeans clustering

#installing necessary packages
library(plyr)
wine_km <- wine_s
#elbow chart / scree-plot
wss <- c()
for (i in 2:15) wss[i] <- sum(kmeans(wine_km, centers = i)$withinss )
plot(1:15, wss, type = 'b', xlab= 'number of clusters', ylab= 'average distance')

#cluster algorithm building
w_km <- kmeans(wine_km, 3)
w_km$centers
w_km$cluster
w_cluster_km = data.frame('wine cluster'= wine[,1], 'cluster' = w_km$cluster)


#animation
library(animation)
windows()
w_km_ani <- kmeans.ani(wine, 3)
