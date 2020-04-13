jandata <- read.csv("JC-201901-citibike-tripdata.csv")
str(jandata)
summary(jandata)

#cleaning data
jandata$bikeid <- NULL

#separate test and train data
set.seed(12345)
jandata_rand <- jandata[order(runif(1000)), ]

summary(jandata$tripduration)
summary(jandata_rand$tripduration)
head(jandata$tripduration)
head(jandata_rand$tripduration)

jandata_train <- jandata[1:9000, ]
jandata_test  <- jandata[9001:19676, ]

#Decision tree
library(C50)
jandata_model <- C5.0(jandata_train[], jandata_train$tripduration)

#Linear model
durationmodel <- lm(tripduration ~ start.station.id + end.station.id, data = jandata_train)
summary(durationmodel)

#Predict outcomes
newvalue <- data.frame(start.station.id = 3272 , end.station.id = 3270)
predict(durationmodel, newdata=newvalue)
predict(durationmodel, newdata=newvalue, interval="prediction")
shapiro.test(residuals(durationmodel))
residualPlots(durationmodel)

#Generalized linear model for prediction
#logit.model <- glm(tripduration ~ starttime , data = jandata_train, family = "binomial")
#summary(logit.model)



