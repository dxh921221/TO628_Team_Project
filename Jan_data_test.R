jandata <- read.csv("JC-201901-citibike-tripdata.csv")
str(jandata)
summary(jandata)
#cleaning data
jandata$bikeid <- NULL
jandata$tripduration <- as.factor(jandata$tripduration)
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
durationmodel <- lm(tripduration ~ starttime, data = jandata_train)
summary(durationmodel)

#Generalized linear model for prediction
#logit.model <- glm(tripduration ~ starttime , data = jandata_train, family = "binomial")
#summary(logit.model)

#Predict outcomes

