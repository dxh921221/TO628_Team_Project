jandata <- read.csv("JC-201901-citibike-tripdata.csv")
str(jandata)
summary(jandata)
#cleaning data
jandata$bikeid <- NULL

set.seed(12345)
jandata_rand <- jandata[order(runif(1000)), ]

summary(jandata$tripduration)
summary(jandata_rand$tripduration)
head(jandata$tripduration)
head(jandata_rand$tripduration)

jandata_train <- jandata[1:9000, ]
jandata_test  <- jandata[9001:19676, ]

#Generalized linear model for prediction
logit.model <- glm(tripduration ~ starttime , data = jandata, family = "binomial")
summary(logit.model)

#Predict outcomes

