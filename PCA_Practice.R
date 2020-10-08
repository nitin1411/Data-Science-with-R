#Principle Component Analysis
install.packages("xlsx")
pca <- Universities
pca <- princomp(pca [,2:7], cor = T, scores = T, covmat = NULL)
summary(pca)
pca$scores

#pca$loadings
plot(pca$scores[,1:2], col = "Blue", pch = 18, cex = 0.3, lwd = 3)
text(pca$scores[,1:2], labels = c(1:25), cex = 1)

#PCA for image compression
library(jpeg)
library(imager)
library(pixmap)

cat <- readJPEG('C:\\Users\\nitin\\Downloads\\cat.jpg')

ncol(cat)
nrow(cat)

r <- cat[,,1]
g <- cat[,,2]
b <- cat[,,3]

cat.r.pca <- prcomp(r, center = FALSE)
cat.g.pca <- prcomp(g, center = FALSE)
cat.b.pca <- prcomp(b, center = FALSE)

rgb.pca <- list(cat.r.pca, cat.g.pca, cat.b.pca)
pca.img <- sapply(rgb.pca, function(j) {  compressed.img <- j$x[,1:50] %*% t(j$rotation[,1:50])}, simplify = 'array')
a<-pixmap::pixmapRGB(pca.img)
windows()
plot(a)
