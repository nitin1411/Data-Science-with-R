#FORECASTING PLASTIC SALES
#loading the data set
plastic <- PlasticSales
plot(plastic$Sales, type = "l")

#creating dummy variable for month
ps <- data.frame(outer(rep(month.abb, length = 60), month.abb, "==") + 0 )
View(ps)
colnames(ps) <- month.abb
psdata <- cbind(plastic, ps)
View(psdata)
psdata['t'] <- 1:60
psdata["logsales"] <- log(psdata$Sales)
psdata["tsqrd"] <- psdata["t"] * psdata["t"]

#data partioning
ps_train <- psdata[1:48,]
ps_test <- psdata[49:60,]

####Linear Model####
lin_mod <- lm(Sales ~ t, data = ps_train)
summary(lin_mod)

lin_pred <- data.frame(predict(lin_mod, interval = 'predict', newdata = ps_test))
View(lin_pred)
rmse_lin <- sqrt(mean((ps_test$Sales - lin_pred$fit) ^ 2, na.rm = T))
rmse_lin

####Exponential Model####
expo_mod <- lm(logsales ~ t, data = ps_train)
summary(expo_mod)
expo_pred <- data.frame(predict(expo_mod, interval = 'predict', newdata = ps_test))
rmse_expo <- sqrt(mean((ps_test$Sales - exp(expo_pred$fit))^2 , na.rm = T))
rmse_expo

####Quadratic Model####                  
quad_mod <- lm(Sales ~ t + tsqrd, data = ps_train)
summary(quad_mod)
quad_pred <- data.frame(predict(quad_mod, interval = 'predict', newdata = ps_test))
View(quad_pred)
rmse_quad <- sqrt(mean((ps_test$Sales - quad_pred$fit)^2, na.rm = T))
rmse_quad

####Additive Seasonality Model####
add_sea <- lm(Sales ~ Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data= ps_train)
summary(add_sea)
add_sea_pred <- data.frame(predict(add_sea, interval = 'predict', newdata = ps_test))
rmse_add_sea <- sqrt(mean((ps_test$Sales - add_sea_pred$fit)^2, na.rm = T))
rmse_add_sea

####Additive Seasonality with linear trend####
add_sea_lin <- lm(Sales ~ t +Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data= ps_train)
summary(add_sea_lin)
add_sea_lin_pred <- data.frame(predict(add_sea_lin, interval = 'predict', newdata = ps_test))
rmse_add_sea_lin <- sqrt(mean((ps_test$Sales - add_sea_lin_pred$fit)^2, na.rm = T))
rmse_add_sea_lin

####Additive Seasonality with Quadratic####
add_sea_quad <- lm(Sales ~ t + tsqrd + Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data= ps_train)
summary(add_sea_quad)
add_sea_quad_pred <- data.frame(predict(add_sea_quad, interval = 'predict', newdata = ps_test))
rmse_add_sea_quad <- sqrt(mean((ps_test$Sales - add_sea_quad_pred$fit)^2, na.rm =T))
rmse_add_sea_quad

####Multiplicative Seasonality####
mul_sea <- lm(logsales ~ Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data= ps_train )
summary(mul_sea)
mul_sea_pred <- data.frame(predict(mul_sea, interval = 'predict', newdata = ps_test))
rmse_mul_sea <- sqrt(mean((ps_test$Sales - exp(mul_sea_pred$fit))^2, na.rm = T))
rmse_mul_sea

####Multiplicative Seasonality Linear trend####
mul_sea_lin <- lm(logsales ~ t + Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data= ps_train)
summary(mul_sea_lin)
mul_sea_lin_pred <- data.frame(predict(mul_sea_lin, interval = 'predict', newdata = ps_test))
rmse_mul_sea_lin <- sqrt(mean((ps_test$Sales - exp(mul_sea_lin_pred$fit))^2, na.rm =T))
rmse_mul_sea_lin

#preparing table of model and their RMSE values
RMSE_table <- data.frame('Model'= c('lin_mod','expo_mod','quad_mod','add_sea','add_sea_lin','add_sea_quad',
                                    'mul_sea','mul_sea_lin'), 'RMSE' = c(rmse_lin,rmse_expo,rmse_quad,rmse_add_sea,
                                                                         rmse_add_sea_lin,rmse_add_sea_quad,rmse_mul_sea,
                                                                        rmse_mul_sea_lin))
View(RMSE_table)

# Use entire data : Additive seasonality with Linear has least RMSE value (135.5536)
newmod <- lm(Sales ~ t + Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov,data= psdata )
